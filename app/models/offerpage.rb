class Offerpage
  include Mongoid::Document
  field :title, :type => String
  field :filename, :type => String
  field :description, :type => String
  field :keywords, :type => String
  field :headline, :type => String
  field :subhead, :type => String
  field :content_block1, :type => String
  field :content_block2, :type => String
  field :offer_block, :type => String
  field :testimonials, :type => String
  field :video, :type => String
  field :published, :type => Boolean
end
