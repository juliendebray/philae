ActiveAdmin.register RecommendedTrip do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :description, :destination_id, :step_1, :step_2, :step_3, :step_4, :step_5, :step_6, :step_7, :step_8, :step_9, :step_10, :step_11, :step_12, :step_13, :step_14, :step_15
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
