require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "scrape_info" do
    mail = UserMailer.scrape_info
    assert_equal "Scrape info", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
