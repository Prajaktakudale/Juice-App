class Employee

	include Mongoid::Document
	field :employee_id,   :type => String

    embeds_many :juice_requests
end