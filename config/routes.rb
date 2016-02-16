Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  as :user do
    get "/login" => "devise/sessions#new"
    delete "/logout" => "devise/sessions#destroy"
  end

  resources :expenses

  scope 'activities/:activity_type' do
    controller 'activities' do
      get '' => :index, as: :activities
      post '' => :create
      get '/new' => :new, as: :new_activity
      get ':id/edit' => :edit, as: :edit_activity
      get ':id' => :show, as: :activity
      patch ':id' => :update
      put ':id' => :update
      delete ':id' => :destroy
    end
  end
  

  get 'calendar/month' => 'calendar#month'
  get 'calendar/week' => 'calendar#week'
  get 'calendar/day' => 'calendar#day'
  
  scope 'welcome/:activity_type' do
    controller 'welcome' do
      get '' => :index, as: :welcome
      post '' => :create
      get '/new' => :new, as: :new_welcome
      get ':id/edit' => :edit, as: :edit_welcome
      patch ':id' => :update
      put ':id' => :update
      delete ':id' => :destroy
    end
  end
  root 'welcome#index'
end
