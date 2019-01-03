class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  belongs_to :category, required: false
  belongs_to :user

  scope :published, ->{ where(status: "published") }
  scope :unpublished, ->{ where(status: "unpublished") }
  scope :archived, ->{ where(status: "archived") }

  enum status: {unpublished: 0, published: 1, archived: 2} do
    event :publish do
      transition :unpublished => :published
    end

    event :archive do
      transition :published => :archived
    end
  end

  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images, allow_destroy: true
end
