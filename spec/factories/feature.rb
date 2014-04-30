FactoryGirl.define do

  factory :feature, class:Hash do
    initialize_with {
      geometry: {
          x: 997986.50,
          y: 5783631.06,
          spatialReference: { wkid: 102100 }
      },
      attributes: {
          status: 1,
          req_id: "12345",
          req_type: "Graffiti Complaint – Private Property",
          req_date: "30.09.2013",
          req_time: "14:00",
          address: "via dei matti 1",
          district: "Lugano"
      }
    }
  end
end