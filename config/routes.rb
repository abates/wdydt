
Rails.application.routes.draw do
  resources :activity_validators
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "registrations" }

  resources :expenses

  get "calendar/month" => "calendar#month"
  get "calendar/week" => "calendar#week"
  get "calendar/day" => "calendar#day"
  
  {"dashboard" => "dashboard_", "activities" => ""}.each do |c, p|
    scope "#{c}/:activity_type" do
      controller c do
        get '' => :index, as: "#{p}activities"
        post '' => :create
        get '/new' => :new, as: "new_#{p}activity"
        get ':id/edit' => :edit, as: "edit_#{p}activity"
        get ':id' => :show, as: "#{p}activity"
        patch ':id' => :update
        put ':id' => :update
        delete ':id' => :destroy
      end
    end
  end

  resources :customizations

  authenticated do
    root to: "dashboard#index", as: :authenticated_root
  end
  
  root to: "welcome#index"
end
