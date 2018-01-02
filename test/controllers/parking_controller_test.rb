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
          end_date: "2017-06-06",
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
        end_date: "2017-05-02",
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
        end_date: "2017-05-02",
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
          end_date: "2017-06-06",
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
        end_date: "2017-05-02",
        contact: "555-5555"
      )
      parking.save
      parking[:id] += 1
      subject
      action_mailer_job_wont_be_enqueued ParkingMailer, "confirmation", parking
    end
  end

  describe "Missing params" do
    [:code, :unit, :make, :color, :license, :start_date, :end_date, :contact].each do |param|
      describe "Missing #{param}" do
        full_parameter =
          {
            parking: {
              code: "ABC",
              unit: 1,
              make: "FAST",
              color: "Green",
              license: "banana",
              start_date: "2017-05-05",
              end_date: "2017-06-06"
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
end

class ParkingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parking_index_url
    assert_response :success
  end
end
