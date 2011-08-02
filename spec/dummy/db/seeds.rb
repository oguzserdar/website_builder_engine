# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
setting = Setting.create! :articles_directory => 'howto',
  :offerpages_directory => 'products',
  :domain => 'railsapps.github.com',
  :site_name => 'Rails Apps',
  :site_title => 'Rails 3.1 Example Apps and Tutorials',
  :site_tagline => 'Starter Apps for Rails 3.1',
  :site_description => 'Examples of complete working Rails 3.1 web applications',
  :site_keywords => 'rails, ruby, apps, application, example, tutorial',
  :twitter_account => 'rails_apps',
  :sidebar => "h6. Colophon\n\nCreated with html5-website-builder"
puts 'Set defaults for the app'

data = 
<<-RUBY
h3. Lorem Ipsum Dolor

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

h3. Dolor Sit Amet

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

bq. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
RUBY

offerpage = Offerpage.create! :title => 'Installing Rails 3.1',
  :filename => 'ebook',
  :description => 'Free ebook shows how to create starter apps for Rails 3.1',
  :keywords => 'ebook, rails, ruby, apps, application, example, tutorial, install',
  :headline => 'Save Time Creating Apps with Rails 3.1',
  :subhead => 'What You Need to Know',
  :content_block1 => data,
  :content_block2 => data,
  :offer_block => data,
  :testimonials => data,
  :published => false
puts "Created offerpage #{offerpage.id}"

article1 = Article.create! :title => 'Installing Rails 3.1',
  :filename => 'installing-rails-3-1',
  :description => 'Detailed instructions on how to install Rails 3.1',
  :keywords => 'rails, ruby, apps, application, example, tutorial, install',
  :headline => 'Read This Before Installing Rails 3.1',
  :subhead => 'What You Need to Know',
  :content => data,
  :published => false,
  :related_items => []
puts "Created sample article #{article1.id}"
article2 = Article.create! :title => 'Using Rails 3.1',
  :filename => 'using-rails-3-1',
  :description => 'Detailed instructions on how to use Rails 3.1',
  :keywords => 'rails, ruby, apps, application, example, tutorial, install',
  :headline => 'How to Use Rails 3.1',
  :subhead => 'What You Need to Know',
  :content => data,
  :sidebar => setting.sidebar,
  :related_items => [article1._id.to_s],
  :published => false
puts "Created sample article #{article2.id}"
