require 'test_helper'

class ReceiptMailerTest < ActionMailer::TestCase
  test "successful_charge_receipt" do
    mail = ReceiptMailer.successful_charge_receipt
    assert_equal "Successful charge receipt", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
