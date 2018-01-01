# frozen_string_literal: true

require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  describe ParkingMailer do
    it "should send the correct email" do
      parking = Parking.new(
        code: "ABC",
        unit: 1,
        make: "FAST",
        color: "Green",
        license: "banana",
        start_date: "2017-05-01",
        end_date: "2017-05-02"
      )
      email = ParkingMailer.registration(parking)

      assert_emails 1 do
        email.deliver_now
      end
      assert_equal I18n.t("email.subject"), email.subject
      assert_equal read_fixture("registration").join.strip, email.text_part.body.to_s.strip
      assert_equal read_fixture("registration_html").join.strip, email.html_part.body.to_s.strip
    end
  end
end
