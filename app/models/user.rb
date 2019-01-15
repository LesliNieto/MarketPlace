class User < ApplicationRecord

  validates :first_name, presence: :true
  validates :last_name, presence: :true
  validates :email, presence: :true, uniqueness: :true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :products, allow_destroy: true

end
