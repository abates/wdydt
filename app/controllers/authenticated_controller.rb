class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  before_action :date_setup

  private
  def date_setup
    Date.beginning_of_week = :sunday
  end
end
