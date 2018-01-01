# frozen_string_literal: true

require "test_helper"

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
