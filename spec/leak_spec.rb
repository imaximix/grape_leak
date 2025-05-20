require 'rack/test'
require 'objspace'

require_relative '../api'

describe API do
  include Rack::Test::Methods

  def app
    API
  end

  context 'GET /hello' do
    it 'returns hello world' do
      get '/hello'
      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)).to eq('hello' => 'world')
    end
  end

  context 'POST /hello' do
    it 'returns 404' do

      10000.times do
        post '/hello'        
      end

      expect(last_response).to be_created
      expect(JSON.parse(last_response.body)).to eq('not_found' => 'not found')

      objects = {}
      ObjectSpace.each_object do |obj|
        objects[obj.class] ||= 0
        objects[obj.class] += 1
      end

      expect(objects[Grape::Router::Route]).to be < 10000
      p objects[Grape::Router::Route]
    end
  end
end