ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require_relative 'rest.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Rest Api" do

  it "should return json" do
    get '/listAll?page=0&&size=1'
    last_response.headers['Content-Type'].must_equal 'application/json' #;charset=utf-8
  end 

# Query recipe request
  it "should return 404" do
    get '/listAll?page=1&&size=1'
    assert_equal last_response.status, 404
  end 

  it "should return the id=1 recipe" do
    get '/listAll?page=0&&size=1'
    recipe_info = { id: 1, name: 'name',instructions: 'instructions', ingredients:'ingredients',linkself: '/listAll?page=0',linkprev: '',linknext: '/listAll?page=1'}
    recipe_info.to_json.must_equal last_response.body
    assert_equal last_response.status, 200
  end

 # Add recipe request
  it "should return the added recipe" do
    post '/addRecipe', params={name: 'name1',instructions: 'instructions1', ingredients: 'ingredients1'}
    recipe_info = { id: 2, name: 'name1',instructions: 'instructions1', ingredients: 'ingredients1'}
    recipe_info.to_json.must_equal last_response.body
    last_response.status.must_equal 201
  end

  it "should return the recipe already exists" do
    post '/addRecipe', params={name: 'name',instructions: 'instructions', ingredients: 'ingredients'}
    "The recipe already exists".must_equal last_response.body
  end

  # Delete recipe request
  it "should return the status 204" do
    delete '/removeRecipe/1'
    last_response.status.must_equal 204
  end

  it "should return not found" do
    delete '/removeRecipe/2'
    "Not Found 2".must_equal last_response.body
    last_response.status.must_equal 404
  end

# Update recipe request
  it "should return the updated recipe" do
    post '/updateRecipe', params={name: 'name',instructions: 'instructions1', ingredients: 'ingredients1'}
    recipe_info = { id: 1, name: 'name',instructions: 'instructions1', ingredients: 'ingredients1'}
    recipe_info.to_json.must_equal last_response.body
    last_response.status.must_equal 200
  end

  it "should return the recipe not found" do
    post '/updateRecipe', params={name: 'name1',instructions: 'instructions1', ingredients: 'ingredients1'}
    response_info = "Not Found Recipe Name - name1"
    response_info.must_equal last_response.body
    last_response.status.must_equal 404
  end
end