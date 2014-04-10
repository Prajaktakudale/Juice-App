require 'sinatra'
require 'mongoid'
require 'json'
require './model/employee.rb'
require './model/juice_request.rb'

Mongoid.load!("./config/mongoid.yml")


get '/generateqr' do
	erb :index
end

post '/generateqr/create' do
	employee_id = params["Employee Id"]
	url = "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=#{employee_id}"
	erb :qr_generated, :locals => {:employee_id => employee_id, :qr_url => url }
end

get '/total/numberOfGlasses' do
	"#{Employee.all.collect(&:juice_requests).flatten.length}"
end

post '/employee/juice/comsumption' do
  	new_juice_request = JSON.parse(request.body.read)
  	emp_id = new_juice_request["employee_id"]
  	numberOfGlasses = new_juice_request["numberOfGlasses"].to_i

  	date_time = new_juice_request["date_time"]
  	if(Employee.where({:employee_id => emp_id}).exists?)
  		Employee.find_by(employee_id: "12345").juice_requests << JuiceRequest.new({:no_of_glasses => numberOfGlasses,:date_time => date_time})
  	else
  		request = Employee.new(:employee_id => emp_id, :juice_requests => [JuiceRequest.new({:no_of_glasses => numberOfGlasses, :date_time => date_time})])
  		request.save!
	end
end