# frozen_string_literal: true

require "test_helper"
require "mocha/mini_test"

describe ParkingController do
  describe "All params are correct" do
    let(:params) do
      {
        parking: {
          code: "ABC",
          unit: 1,
          make: "FAST",
          color: "Green",
          license: "banana",
          start_date: "2017-05-05",
          end_date: "2017-05-09",
          contact: "test@example.com"
        }
      }
    end
    let(:subject) { post :create, params: params }
    it "Should save flow" do
      subject
      assert_redirected_to registered_path
    end

    it "Should send registration email" do
      parking = Parking.new(
        code: "ABC",
        unit: 1,
        make: "FAST",
        color: "Green",
        license: "banana",
        start_date: "2017-05-01",
        end_date: "2017-05-04",
        contact: "test@example.com"
      )
      parking.save
      parking[:id] += 1
      subject
      action_mailer_job_must_be_enqueued ParkingMailer, "registration", parking
    end

    it "Should send confirmation email if contact has valid email address" do
      parking = Parking.new(
        code: "ABC",
        unit: 1,
        make: "FAST",
        color: "Green",
        license: "banana",
        start_date: "2017-05-01",
        end_date: "2017-05-04",
        contact: "test@example.com"
      )
      parking.save
      parking[:id] += 1
      subject
      action_mailer_job_must_be_enqueued ParkingMailer, "confirmation", parking
    end
  end
  describe "Contact is not an email" do
    let(:params) do
      {
        parking: {
          code: "ABC",
          unit: 1,
          make: "FAST",
          color: "Green",
          license: "banana",
          start_date: "2017-05-05",
          end_date: "2017-05-09",
          contact: "555-5555"
        }
      }
    end
    let(:subject) { post :create, params: params }

    it "Should not send confirmation email if contact has valid email address" do
      parking = Parking.new(
        code: "ABC",
        unit: 1,
        make: "FAST",
        color: "Green",
        license: "banana",
        start_date: "2017-05-01",
        end_date: "2017-05-05",
        contact: "555-5555"
      )
      parking.save
      parking[:id] += 1
      subject
      action_mailer_job_wont_be_enqueued ParkingMailer, "confirmation", parking
    end
  end

  describe "Missing params" do
    [:unit, :make, :color, :license, :start_date, :end_date, :contact].each do |param|
      describe "Missing #{param}" do
        full_parameter =
          {
            parking: {
              unit: "1",
              make: "FAST",
              color: "Green",
              license: "banana",
              start_date: "2017-05-05",
              end_date: "2017-05-06",
              contact: "test@test.com"
            }
          }

        let(:params) do
          {
            parking: full_parameter[:parking].except(param)
          }
        end
        let(:subject) { post :create, params: params }

        it "Should not save" do
          subject
          assert_template "parking/index"
        end
      end
    end

    describe "Incorrect parameters" do
      describe "Unit is not a number" do
        let(:params) do
          {
            parking: {
              code: "ABC",
              unit: "One hundred ten",
              make: "FAST",
              color: "Green",
              license: "banana"
            }
          }
        end
        let(:subject) { post :create, params: params }

        it "Should not save" do
          subject
          assert_template "parking/index"
        end
      end
    end
  end

  describe "Too many days" do
    describe "In a single month" do
      let(:params) do
        {
          parking: {
            code: "ABC",
            unit: 1,
            make: "FAST",
            color: "Green",
            license: "banana",
            start_date: "2017-05-05",
            end_date: "2017-05-26",
            contact: "test@example.com"
          }
        }
      end
      let(:subject) { post :create, params: params }

      it "Should not save" do
        subject
        assert_template "parking/index"
      end
    end

    describe "In multilpe months beginning month too long" do
      let(:params) do
        {
          parking: {
            code: "ABC",
            unit: 1,
            make: "FAST",
            color: "Green",
            license: "banana",
            start_date: "2017-05-20",
            end_date: "2017-06-26",
            contact: "test@example.com"
          }
        }
      end
      let(:subject) { post :create, params: params }
      it "Should not save" do
        subject
        assert_template "parking/index"
      end
    end

    describe "In multilpe months beginning end too long" do
      let(:params) do
        {
          parking: {
            code: "ABC",
            unit: 1,
            make: "FAST",
            color: "Green",
            license: "banana",
            start_date: "2017-05-29",
            end_date: "2017-06-26",
            contact: "test@example.com"
          }
        }
      end
      let(:subject) { post :create, params: params }
      it "Should not save" do
        subject
        assert_template "parking/index"
      end
    end

    describe "Spanning more than a month" do
      let(:params) do
        {
          parking: {
            code: "ABC",
            unit: 1,
            make: "FAST",
            color: "Green",
            license: "banana",
            start_date: "2017-05-29",
            end_date: "2017-07-02",
            contact: "test@example.com"
          }
        }
      end
      let(:subject) { post :create, params: params }
      it "Should not save" do
        subject
        assert_template "parking/index"
      end
    end
  end
end

class ParkingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parking_index_url
    assert_response :success
  end
end
