ActiveAdmin.register Destination do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :overview, :ne_lat, :ne_lng, :sw_lat, :sw_lng, :formalities, :regions, :transportation, :intro_title, :sentence1, :sentence2, :sentence3, :sentence4, :sentence5, :enter_title, :enter_line1, :enter_line2, :enter_line3, :visit_time_title, :visit_line1, :visit_line2, :visit_line3, :security_title, :security_line1, :security_line2, :transport_title, :transport_line1, :transport_line2, :transport_line3, :transport_line4, :transport_line5, :toknow_title, :toknow_line1, :toknow_line2, :toknow_line3, :toknow_line4, :toknow_line5, :country_code, :security_line3
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
