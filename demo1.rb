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

post '/total/numberOfGlasses' do
  start_date = params["startDate"]
  end_date = params["endDate"]
  
  s_month = start_date.split("/").first
  s_day = start_date.split("/").second
  s_year = start_date.split("/").third
  st_date = DateTime.new(s_year.to_i,s_month.to_i,s_day.to_i,00,00,00).strftime("%Q")
  
  e_month = end_date.split("/").first
  e_day = end_date.split("/").second
  e_year = end_date.split("/").third
  ed_date = DateTime.new(e_year.to_i,e_month.to_i,e_day.to_i,23,59,59).strftime("%Q")
  
  "#{Employee.all.between("juice_requests.date_time" => st_date..ed_date).pluck(:juice_requests).flatten.count}"

end

post '/employee/juice/comsumption' do
    new_juice_request = JSON::parse request.body.read
    emp_id = new_juice_request["employee_id"]
  	number_ofGlasses = new_juice_request["numberOfGlasses"]
  	date_time = new_juice_request["date_time"]

  	if(Employee.where({:employee_id => emp_id}).exists?)
  		Employee.find_by(employee_id: emp_id).juice_requests << JuiceRequest.new({:no_of_glasses => number_ofGlasses,:date_time => date_time})
  	else
  		request = Employee.new(:employee_id => emp_id, :juice_requests => [JuiceRequest.new({:no_of_glasses => number_ofGlasses, :date_time => date_time})])
  		request.save!
	end
	status 200
end