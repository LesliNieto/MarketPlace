class ProductNotifierMailer < ApplicationMailer
  default :from => "notifications@marketplace.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.product_notifier_mailer.new_product_available.subject
  #
  def new_product_available(product, user)
    @product = product
    @user = user
    @greeting = "Hi #{user.first_name}, there's a new available product in the catalogue."
    mail to: user.email, subject: "New product available."
  end
end