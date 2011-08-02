class Setting
  include Mongoid::Document
  field :site_name, :type => String
  field :site_title, :type => String
  field :site_tagline, :type => String
  field :site_description, :type => String
  field :site_keywords, :type => String
  field :twitter_account, :type => String
  field :domain, :type => String
  field :articles_directory, :type => String
  field :offerpages_directory, :type => String
  field :sidebar, :type => String
end
