require 'grape'

class NestedAPI < Grape::API
  namespace :nested do
    get do
      { hello: 'world' }
    end
  end
end

class API < Grape::API

  # This behaves nicely
  namespace :nested do
    mount NestedAPI
  end

  # This causes a memory leak
  mount NestedAPI

  get :hello do
    { hello: 'world' }.to_json
  end

  route :any, '*path' do
    if API.recognize_path(request.path.gsub(%r{/?$}, ''))
      { not_found: 'not found' }.to_json 
    else
      { hello: 'world' }.to_json
    end
  end
end