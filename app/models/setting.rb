class Setting
  include Mongoid::Document
  field :site_name, :type => String
  field :site_title, :type => String
  field :site_tagline, :type => String
  field :site_description, :type => String
  field :site_keywords, :type => String
  field :site_image_url, :type => String
  field :domain, :type => String
  field :articles_directory, :type => String
  field :offerpages_directory, :type => String
  field :sidebar, :type => String
  field :about, :type => String
  field :google_analytics_id, :type => String
  field :twitter_account, :type => String
  field :facebook_admin_id, :type => String
end
