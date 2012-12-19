# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Chart
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Chart.
  # enable :sync

  #add model specifc code here
   property :user_name, :string 
   property :device_count, :integer 
end
