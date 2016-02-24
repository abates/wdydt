class User < ActiveRecord::Base
  include Gravtastic
  gravtastic size: 29, default: "blank"

  has_many :identities

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook,:github,:google_oauth2]

  def unused_providers
    (self.class.omniauth_providers - identities.map { |i| i.provider.to_sym })
  end
end
