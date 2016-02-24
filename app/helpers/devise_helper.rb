module DeviseHelper
  def provider_name provider
    return case provider.to_s
           when "google_oauth2"
             "google"
           else
             provider.to_s
           end
  end

  def social_icon provider
    content_tag :div, class: "btn btn-social-icon btn-#{provider_name(provider)}" do
      content_tag :span, class: "fa fa-#{provider_name(provider)}" do
      end
    end
  end

  def link_to_social_login provider
    link_to user_omniauth_authorize_path(provider), class: "btn btn-social-icon btn-#{provider_name(provider)}" do 
      content_tag :span, class: "fa fa-#{provider_name(provider)}" do
      end
    end
  end

  def devise_error_messages!
  end
end
