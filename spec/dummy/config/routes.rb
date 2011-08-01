Rails.application.routes.draw do
  mount WebsiteBuilderEngine::Engine => "/builder"
end
