require("pry-byebug")
require_relative("moduls/properties")

Properties.delete_all()

property1 = Properties.new({
  "address" => "44 Poplar Park Port Seton EH32 0TD"
  "value" => "250000"
  "bedrooms" => "4"
  "build" => "detached"
})
property1.save()

property2 = Properties.new({
  "address" => "4 Beulah Musselburgh EH21 7LH"
  "value" => "360000"
  "bedrooms" => "3"
  "build" => "semi-detached"
})
property2.save()
