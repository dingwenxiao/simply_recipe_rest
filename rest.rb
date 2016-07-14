# myapp.rb
require 'sinatra'
require "json"

get '/listAll' do 
  return_message = {id:1, name:'name', instructions:'instructions',ingredients:'ingredients',linkself: '/listAll?page=0',linkprev: '',linknext: '/listAll?page=1'} 
  page = params['page']
  size = params['size']
  logger.info "list all recipes by page and size"
  logger.info return_message
  content_type :json
  if(page=='0') 
    [200, [return_message.to_json]]
  else
    status 404
 end
end

post "/addRecipe" do
  name = params['name']
  instructions = params['instructions']
  ingredients = params['ingredients']
  content_type :json
  if name != 'name' 
    recipe = {id:2,name:name,instructions:instructions,ingredients:ingredients}
    logger.info "added rececipe"
    [201, [recipe.to_json]]
  else
    halt 409, 'The recipe already exists' 
  end
end

delete '/removeRecipe/:id' do
  id = params[:id]
  if id != '1'
    halt 404, "Not Found id: #{id}"
  else 
    #[200, ["\"msg\":\"Deleted recipe 1\""]]
    status 204
  end
end

post "/updateRecipe" do
  name = params['name']
  instructions = params['instructions']
  ingredients = params['ingredients']
  if name!='name'
    halt 404, "Not Found Recipe Name - #{name}"
  else
    logger.info "update rececipe"
    recipe = {id:1,name:name,instructions:instructions,ingredients:ingredients}
    [200, [recipe.to_json]]
  end
end
