require 'sinatra'
require 'mongoid'
require 'json'
require './model/employee.rb'
require './model/juice_request.rb'
require 'erb'
require 'date'

Mongoid.load!("./config/mongoid.yml")


get '/generaterecord/glasses' do
    erb :index
end

get '/total/numberOfGlasses' do
  start_date = params["startDate"]
  end_date = params["endDate"]
  
  s_month = start_date.split("/").first
  s_day = start_date.split("/").second
  s_year = start_date.split("/").third
  st_date = DateTime.new(s_year.to_i,s_month.to_i,s_day.to_i,00,00,00,00).to_i
  
  e_month = end_date.split("/").first
  e_day = end_date.split("/").second
  e_year = end_date.split("/").third
  ed_date = DateTime.new(e_year.to_i,e_month.to_i,e_day.to_i,23,59,59,00).to_i

  
  p "#{Employee.all.between(:juice_requests => {:date_time => st_date..ed_date}).count}"

#{}"#{Employee.all.collect(&:juice_requests).flatten.length}"

end

post '/employee/juice/comsumption' do
    new_juice_request = request.body.read
  	emp_id = new_juice_request["employee_id"].to_i
  	numberOfGlasses = new_juice_request["numberOfGlasses"].to_i
  	date_time = new_juice_request["date_time"]

  	if(Employee.where({:employee_id => emp_id}).exists?)
  		Employee.find_by(employee_id: emp_id).juice_requests << JuiceRequest.new({:no_of_glasses => numberOfGlasses,:date_time => date_time})
  	else
  		request = Employee.new(:employee_id => emp_id, :juice_requests => [JuiceRequest.new({:no_of_glasses => numberOfGlasses, :date_time => date_time})])
  		request.save!
	end
	status 200
  	body ''
end