class JuiceRequest

  include Mongoid::Document

  field :no_of_glasses, :type => Integer
  field :date_time, :type => String

  embedded_in :employee 

  validates_numericality_of :no_of_glasses, :greater_than => 1 , :message => "Incorrect...!"
  validates_presence_of :date_time, :message => "Incorrect or missing date and time"
end