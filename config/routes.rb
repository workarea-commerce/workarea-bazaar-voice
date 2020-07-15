Workarea::Storefront::Engine.routes.draw do
  get 'bazaar_voice/product/:id', to: 'bazaar_voice#show', as: 'bazaar_voice_container_page'
end
