class JuiceRequest

  include Mongoid::Document

  field :no_of_glasses, :type => Integer
  field :date_time, :type => Integer

  embedded_in :employee 

end