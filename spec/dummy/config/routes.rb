Rails.application.routes.draw do

  mount WebsiteBuilderEngine::Engine => "/website_builder_engine"
end
