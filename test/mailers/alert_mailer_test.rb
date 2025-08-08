require "test_helper"

class AlertMailerTest < ActionMailer::TestCase
  test "triggered" do
    mail = AlertMailer.triggered

    assert_equal "Triggered", mail.subject
    assert_equal [ "user@example.test" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
  end
end
