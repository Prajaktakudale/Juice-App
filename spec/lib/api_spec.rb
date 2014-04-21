require 'spec_helper.rb'

describe 'API Test' do

  before(:each) do
    Employee.all.destroy
  end

  it "total of number of glasses page should ok" do
    get "/total/numberOfGlasses"
    expect(last_response.status).to eq(200)
  end

  it "total of number of glasses page should not ok" do
    get "/total/numberOfGlasse"
    expect(last_response.status).to eq(404)
  end

  it "juice consumtion page should ok" do
   Employee.count.should == 0
   post '/employee/juice/comsumption', {:employee_id => "12345",:numberOfGlasses=>1,:date_time=>"Date"}.to_json
   Employee.count.should == 1
   expect(last_response.status).to eq(200)
 end

 it "juice consumtion page should add one record in database" do
   Employee.count.should == 0
   post '/employee/juice/comsumption', {:employee_id => "23456",:numberOfGlasses=>1,:date_time=>"Date"}.to_json
   Employee.count.should == 1
 end

   it "juice consumtion page should not ok" do
   post '/employee/juice/comsumptions', {:employee_id => "34567",:numberOfGlasses=>1,:date_time=>"Date"}.to_json
   expect(last_response.status).to eq(404)
 end
end