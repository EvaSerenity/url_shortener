Rails.application.routes.draw do

  get '/:token', to: 'url_shortener#expand'
  post '/', to: 'url_shortener#shorten'

end
