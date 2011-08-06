module WebsiteBuilderEngine
  class OfferpagesController < ApplicationController

    before_filter :get_settings, :only => [:publish, :index, :new, :destroy]

    def publish
      @offerpage = Offerpage.find(params[:id])
      @permalink = "http://#{@settings.domain}/#{@settings.offerpages_directory}/#{@offerpage.filename}.html"
      offerpage_page = render_to_string(:template => "website_builder_engine/offerpages/template.html.haml", :layout => false )
      FileUtils.makedirs(@file_path) unless File.exists?(@file_path)
      File.open("#{@file_path + @offerpage.filename}.html", 'w') {|f| f.write(offerpage_page) }
      @offerpage.update_attribute(:published, true)
      respond_to do |format|
        format.html { redirect_to offerpages_path, notice: "Built a webpage for the offer page \"#{@offerpage.title}\"" }
      end

    end
  
    def index
      @offerpages = Offerpage.all
      respond_to do |format|
        format.html # index.html.erb
      end
    end

    def show
      @offerpage = Offerpage.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
      end
    end

    def new
      @offerpage = Offerpage.new
      respond_to do |format|
        format.html # new.html.erb
      end
    end

    def edit
      @offerpage = Offerpage.find(params[:id])
    end

    def create
      @offerpage = Offerpage.new(params[:offerpage])
      if params[:format] == 'html'
        p1 = HTMLToTextileParser.new
        p2 = HTMLToTextileParser.new
        p3 = HTMLToTextileParser.new
        p4 = HTMLToTextileParser.new
        p1.feed(params[:offerpage][:content_block1])
        @offerpage.content_block1 = p1.to_textile
        p2.feed(params[:offerpage][:content_block2])
        @offerpage.content_block2 = p2.to_textile
        p3.feed(params[:offerpage][:offer_block])
        @offerpage.offer_block = p3.to_textile
        p4.feed(params[:offerpage][:testimonials])
        @offerpage.testimonials = p4.to_textile
      end
      respond_to do |format|
        if @offerpage.save
          format.html { redirect_to offerpages_path, notice: 'Offerpage was successfully created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def update
      @offerpage = Offerpage.find(params[:id])
      respond_to do |format|
        if @offerpage.update_attributes(params[:offerpage])
          format.html { redirect_to offerpages_path, notice: 'Offerpage was successfully updated.' }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @offerpage = Offerpage.find(params[:id])
      @offerpage.destroy
      @settings = Setting.first
      FileUtils.remove_file("#{@file_path + @offerpage.filename}.html", force = true)
      respond_to do |format|
        format.html { redirect_to offerpages_url }
      end
    end
  
    protected    
      def get_settings
        @settings = Setting.first
        @docroot_path = "#{Rails.root}/public/"
        @file_path = "#{@docroot_path}#{@settings.offerpages_directory}/"
        @url_path = "/#{@settings.offerpages_directory}/"
      end
  end
end