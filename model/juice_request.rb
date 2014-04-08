class JuiceRequest

  include Mongoid::Document

  field :no_of_glasses, :type => String
  field :date_time, :type => String

  embedded_in :employee 

end