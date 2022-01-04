Rails.application.routes.draw do
  #Auth Routes
  post '/users/auth/login', to: 'authentication#login'
  post '/users/auth/register', to: 'authentication#register'

  #Task Routes
  get '/tasks', to: 'task#getAllTasks'
  get '/tasks/:id', to: 'task#getOneTaskById'
  post '/tasks', to: 'task#createOneTask'
  put '/tasks/:id', to: 'task#updateOneTaskById'
  delete '/tasks/:id', to: 'task#deleteOneTaskById'

  #Tag Routes
  get '/tags', to: 'tag#getAllTags'
  get '/tags/:id', to: 'tag#getOneTagById'
  post '/tags', to: 'tag#createOneTag'
  put '/tags/:id', to: 'tag#updateOneTagById'
  delete '/tags/:id', to: 'tag#deleteOneTagById'
end
