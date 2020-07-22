require "pry"
require "sinatra"
require "sinatra/reloader"
require "pg"
require_relative "models/planet.rb"
require_relative "models/user.rb"

enable :sessions

def is_logged_in? 
  !!session[:user_id]
end

get '/' do
  planets = read_planets()
  erb(:index, locals:{planets: planets}) 
end

get "/signup" do
  erb(:signup)
end

post "/signup" do
  create_user(params[:email], params[:first_name], params[:password])
  redirect "/"
end

get "/login" do
  erb(:login)
end

post "/login" do
  user = read_user_by_email(params[:email])
  if user && BCrypt::Password.new(user['password_digested']) == params[:password]
    session[:user_id]=user['user_id']
    redirect "/"
  end
end

delete "/login" do 
  session[:user_id] = nil
  redirect "/"
end


get '/planet/new' do
  if is_logged_in?
    erb(:new)
  else
    redirect "/login"
  end
end

get '/show/:id' do
  planet = read_planet_by_id(params[:id])
  erb(:show, locals:{planet: planet})
end

get '/planet/:id/edit' do
  planet = read_planet_by_id(params[:id])
  erb(:edit, locals:{planet: planet}) 
end

post '/planet' do
  create_planet(params[:name], params[:image_url], params[:diameter],params[:distance],params[:mass], params[:moon_count])
  redirect '/'
end

delete '/planet' do
  delete_planet_by_id(params[:id])
  redirect '/'
end

patch '/planet' do
  update_planet_by_id(params[:name],params[:image_url], params[:diameter], params[:distance], params[:mass], params[:moon_count], params[:id])
  redirect '/'
end