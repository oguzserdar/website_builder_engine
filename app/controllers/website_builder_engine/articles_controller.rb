module WebsiteBuilderEngine
  class ArticlesController < ApplicationController

    before_filter :get_settings, :only => [:publish, :index, :new, :destroy]

    def publish
      # create an article page
      @article = Article.find(params[:id])
      @related_items = Hash.new
      if @article.related_items
        @article.related_items.each do |id|
          item = Article.find(id)
          @related_items[item.title] = "#{item.filename}.html"
        end
      end
      @permalink = "http://#{@settings.domain}/#{@settings.articles_directory}/#{@article.filename}.html"
      @content = RedCloth.new(@article.content).to_html.html_safe
      @sidebar = RedCloth.new(@article.sidebar).to_html.html_safe if @article.sidebar
      article_page = render_to_string(:template => "articles/template.html.haml", :layout => false )
      FileUtils.makedirs(@file_path) unless File.exists?(@file_path)
      File.open("#{@file_path + @article.filename}.html", 'w') {|f| f.write(article_page) }
      @article.update_attribute(:published, true)
      # create (or recreate) the welcome page
      @articles = Article.where(published: true)
      @welcome_sidebar = RedCloth.new(@settings.sidebar).to_html.html_safe if @settings.sidebar
      welcome_page = render_to_string(:template => "welcome/template.html.haml", :layout => false )
      File.open("#{@docroot_path}index.html", 'w') {|f| f.write(welcome_page) }
      respond_to do |format|
        format.html { redirect_to articles_path, notice: "Built a webpage for the article \"#{@article.title}\"" }
      end

    end

    def index
      @articles = Article.all

      respond_to do |format|
        format.html # index.html.erb
      end
    end

    def show
      @article = Article.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
      end
    end

    def new
      @article = Article.new
      @articles = Article.all
      @article.related_items = []
      @article.sidebar = @settings.sidebar if @settings.sidebar
      respond_to do |format|
        format.html # new.html.erb
      end
    end

    def edit
      @article = Article.find(params[:id])
      @articles = Article.all
    end

    def create
      @article = Article.new(params[:article])
      if params[:format] == 'html'
        p1 = HTMLToTextileParser.new
        p2 = HTMLToTextileParser.new
        p1.feed(params[:offerpage][:content])
        @offerpage.content = p1.to_textile
        p2.feed(params[:offerpage][:sidebar])
        @offerpage.sidebar = p2.to_textile
      end
      respond_to do |format|
        if @article.save
          format.html { redirect_to articles_path, notice: 'Article was successfully created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def update
      @article = Article.find(params[:id])
      params[:article][:related_items] ||= []
      respond_to do |format|
        if @article.update_attributes(params[:article])
          format.html { redirect_to articles_path, notice: 'Article was successfully updated.' }
        else
          format.html { render action: "edit" }
        end
      end
    end
  
    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      @settings = Setting.first
      FileUtils.remove_file("#{@file_path + @article.filename}.html", force = true)
      respond_to do |format|
        format.html { redirect_to articles_url }
      end
    end
  
    protected    
      def get_settings
        @settings = Setting.first
        @docroot_path = "#{Rails.root}/public/"
        @file_path = "#{@docroot_path}#{@settings.articles_directory}/"
        @url_path = "/#{@settings.articles_directory}/"
      end
  end
end