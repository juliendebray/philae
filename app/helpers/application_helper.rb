module ApplicationHelper
  def resource_name
   :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def yield_with_default(holder, default)
    if content_for?(holder)
      content_for(holder).squish
    else
      default
    end
  end

  def yield_logo(holder, css_class)
    if content_for?(holder)
      link_to root_path, {class: css_class} do
        image_tag("logo_hp.png", id: "logo")
      end
    else
      link_to root_path, {class: css_class} do
        image_tag("logo.png", id: "logo")
      end
    end
  end

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
      when :success then "alert-success"
      when :error   then "alert-error"
      when :alert   then "alert-block"
      when :notice  then "alert-info"
    end
  end
end
