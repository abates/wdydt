
Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "registrations" }

  resources :expenses

  get 'calendar/month' => 'calendar#month'
  get 'calendar/week' => 'calendar#week'
  get 'calendar/day' => 'calendar#day'
  
  get 'activities' => 'activities#index', as: :activities_index
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

  scope 'activity_types/:activity_type' do
    controller 'activity_types' do
      get '' => :index, as: :activity_types
      post '' => :create
      get '/new' => :new, as: :new_activity_type
      get ':id/edit' => :edit, as: :edit_activity_type
      get ':id' => :show, as: :activity_type
      patch ':id' => :update
      put ':id' => :update
      delete ':id' => :destroy
    end
  end
  
  root 'welcome#index'
end
