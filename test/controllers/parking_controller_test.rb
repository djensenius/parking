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
          nights: 4
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
    describe "Missing code" do
      let(:params) do
        {
          parking: {
            unit: 1,
            make: "FAST",
            color: "Green",
            license: "banana",
            nights: 4
          }
        }
      end
      let(:subject) { post :create, params: params }

      it "Should not save" do
        subject
        assert_template "parking/new"
      end
    end

    describe "Missing unit" do
      let(:params) do
        {
          parking: {
            code: "ABC",
            make: "FAST",
            color: "Green",
            license: "banana",
            nights: 4
          }
        }
      end
      let(:subject) { post :create, params: params }

      it "Should not save" do
        subject
        assert_template "parking/new"
      end
    end

    describe "Missing make" do
      let(:params) do
        {
          parking: {
            code: "ABC",
            unit: 1,
            color: "Green",
            license: "banana",
            nights: 4
          }
        }
      end
      let(:subject) { post :create, params: params }

      it "Should not save" do
        subject
        assert_template "parking/new"
      end
    end

    describe "Missing color" do
      let(:params) do
        {
          parking: {
            code: "ABC",
            unit: 1,
            make: "FAST",
            license: "banana",
            nights: 4
          }
        }
      end
      let(:subject) { post :create, params: params }

      it "Should not save" do
        subject
        assert_template "parking/new"
      end
    end

    describe "Missing license" do
      let(:params) do
        {
          parking: {
            code: "ABC",
            unit: 1,
            make: "FAST",
            color: "Green",
            nights: 4
          }
        }
      end
      let(:subject) { post :create, params: params }

      it "Should not save" do
        subject
        assert_template "parking/new"
      end
    end

    describe "Missing nights" do
      let(:params) do
        {
          parking: {
            code: "ABC",
            unit: 1,
            make: "FAST",
            color: "Green",
            license: "banana"
          }
        }
      end
      let(:subject) { post :create, params: params }

      it "Should not save" do
        subject
        assert_template "parking/new"
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
              license: "banana",
              nights: 4
            }
          }
        end
        let(:subject) { post :create, params: params }

        it "Should not save" do
          subject
          assert_template "parking/new"
        end
      end

      describe "Nights is not a number" do
        let(:params) do
          {
            parking: {
              code: "ABC",
              unit: 1,
              make: "FAST",
              color: "Green",
              license: "banana",
              nights: "four"
            }
          }
        end
        let(:subject) { post :create, params: params }

        it "Should not save" do
          subject
          assert_template "parking/new"
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
