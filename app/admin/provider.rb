ActiveAdmin.register Provider do
  permit_params :name, :email, :description, :activities_description, :website, :phone, :picture_name, :address, :other

  # form multipart: true do |f|
  #     f.inputs "Provider Details" do
  #       f.input :name
  #       f.input :email
  #       f.input :description
  #       f.input :activities_description
  #       f.input :website
  #       f.input :phone
  #       f.input :address
  #       f.input :other
  #       f.input :picture, required: false
  #     end
  #     f.actions
  #   end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
