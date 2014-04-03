require 'sinatra'

get '/employee/:id/drinks/:numberOfGlasses/glass' do
	"#{params[:id]} - #{params[:numberOfGlasses]}"
end