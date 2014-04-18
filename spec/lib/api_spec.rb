require 'spec_helper.rb'

describe 'API Test' do

  before(:each) do
    Employee.all.destroy
  end

  it "total page should ok" do
    get "/total/numberOfGlasses"
    expect(last_response.status).to eq(200)
  end

  it "total page should not ok" do
    get "/total/numberOfGlasse"
    expect(last_response.status).to eq(404)
  end

  it "total page should ok" do
   Employee.count.should == 0
   post '/employee/juice/comsumption', {:employee_id => "1574",:numberOfGlasses=>1,:date_time=>"Date"}.to_json
   Employee.count.should == 1
   expect(last_response.status).to eq(200)
 end

   it "total page should not ok" do
   post '/employee/juice/comsumptions', {:employee_id => "1574",:numberOfGlasses=>1,:date_time=>"Date"}.to_json
   expect(last_response.status).to eq(404)
 end

end