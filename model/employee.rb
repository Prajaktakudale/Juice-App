class Employee

	include Mongoid::Document
	field :employee_id,   :type => String

    embeds_many :juice_requests

	validates_presence_of :employee_id, :message => "Incorrect or missing employee Id"

end