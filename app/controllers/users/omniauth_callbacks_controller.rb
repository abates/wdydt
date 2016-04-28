class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    define_method provider.to_sym do
      generic_callback("#{provider}")
    end
  end

  [:facebook, :github, :google_oauth2].each do |provider|
    provides_callback_for provider
  end

  def generic_callback provider
    @identity = Identity.find_for_oauth request.env["omniauth.auth"]

    @user = @identity.user || current_user

    if @user.nil?
      @user = User.create(
        provider: provider,
        uid: @identity.uid,
        password: Devise.friendly_token[0,20],
        email: @identity.email, 
        name: @identity.name,
      )
    end

    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

