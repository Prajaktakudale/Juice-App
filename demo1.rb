require 'sinatra'
require 'mongoid'
require 'json'
Mongoid.load!("./config/mongoid.yml")

get '/employee/:id/drinks/:numberOfGlasses/glass' do
  "#{params[:id]} - #{params[:numberOfGlasses]}"
end

post '/employee/:id/drinks/:numberOfGlasses/glass' do
  new_juice_request = JSON.parse(request.body.read)
  employee_id = new_juice_request["employee_id"]
  numberOfGlasses = new_juice_request["numberOfGlasses"]
  date_time = new_juice_request["date_time"]
  
  request = Employee.new(:employee_id => employee_id, :juice_requests => [JuiceRequest.new({:no_of_glasses => numberOfGlasses, :date_time => Date.today})])
  request.save!
end