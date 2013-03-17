class ReceiptMailer < ActionMailer::Base
  default from: "hello@refreshrunner.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.receipt_mailer.successful_charge_receipt.subject
  #
  def successful_charge_receipt(current_user)
    @current_user = current_user

    mail to: current_user.email, subject: "Succesful charge"
  end
end
