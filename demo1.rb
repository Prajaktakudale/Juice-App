require 'sinatra'
require 'mongoid'
require 'json'
require './model/employee.rb'
require './model/juice_request.rb'

Mongoid.load!("./config/mongoid.yml")

get '/total/numberOfGlasses' do
	"#{Employee.all.collect(&:juice_requests).flatten.length}"
end

post '/employee/:id/drinks/:numberOfGlasses/glass' do
  	new_juice_request = JSON.parse(request.body.read)
  	emp_id = new_juice_request["employee_id"]
  	numberOfGlasses = new_juice_request["numberOfGlasses"].to_i

  	date_time = new_juice_request["date_time"]
  	if(Employee.where({:employee_id => emp_id}).exists?)
  		Employee.find_by(employee_id: "15749").juice_requests << JuiceRequest.new({:no_of_glasses => numberOfGlasses,:date_time => date_time})
  	else
  		request = Employee.new(:employee_id => emp_id, :juice_requests => [JuiceRequest.new({:no_of_glasses => numberOfGlasses, :date_time => date_time})])
  		request.save!
	end
end