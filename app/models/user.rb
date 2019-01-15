class User < ApplicationRecord

  validates :first_name, presence: :true
  validates :last_name, presence: :true
  validates :email, presence: :true, uniqueness: :true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  has_many :products, dependent: :destroy

  def self.create_form_provider_data(auth_data)
    where(provider: auth_data.provider, uid: auth_data.uid,email: auth_data.info.email).first_or_create do |user|
      user.first_name = auth_data.info.first_name.presence || auth_data.info.name.split(" ")[0]
      user.last_name = auth_data.info.last_name.presence  || auth_data.info.name.split(" ")[1]
      user.email = auth_data.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end
