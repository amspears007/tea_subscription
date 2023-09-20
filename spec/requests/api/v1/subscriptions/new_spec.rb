require "rails_helper"

RSpec.describe "Create a new subscription" do
  before(:each) do
    @customer1 = Customer.create!(first_name: 'Amy', last_name: 'Spears', email: 'amers123@gmail.com', address: '123 street, denver, CO, 80028')
    @tea1 = Tea.create!(title: 'Earl Grey', temperature: 'boiling', brew_time: '4-6 minutes')
    @sub1 = Subscription.create!(title: "Super Fun Tea", price: 11.99, status: "inactive", frequency: "bi-weekly", customer_id: @customer1.id, tea_id: @tea1.id)
  end

  describe "happy paths" do
    it "can create a subscription with a customer and tea id" do

      subscription_params = {
        title: 'Tasty Teas R Us',
        price: 10.00,
        status: 'active',
        frequency: 'weekly',
        customer_id: @customer1.id,
        tea_id: @tea1.id
        }

        post "/api/v1/customers/#{@customer1.id}/subscriptions", params: subscription_params

        expect(response).to be_successful
        expect(response.status).to eq(201)
        subscription = JSON.parse(response.body, symbolize_names: true)
        expect(subscription).to be_a(Hash)
        expect(subscription[:data]).to have_key(:type)
        expect(subscription[:data]).to have_key(:id)
        expect(subscription[:data]).to have_key(:attributes)
        expect(subscription[:data][:id]).to be_an(String)

        expect(subscription[:data][:attributes].count).to eq(6)
        expect(subscription[:data][:attributes]).to have_key(:title)
        expect(subscription[:data][:attributes]).to have_key(:price)
        expect(subscription[:data][:attributes][:price]).to be_a(Float)
      end
    end

    describe "sad paths" do
      it "will return an error if a params is blank" do

        bad_params = {
          title: 'Tasty Teas R Us',
          price: 10.00,
          status: 'active',
          frequency: 'weekly',
          customer_id: @customer1.id,
          tea_id: nil
          }

          post "/api/v1/customers/#{@customer1.id}/subscriptions", params: bad_params

          expect(response).to_not be_successful
          expect(response.status).to eq(400)
          bad_sub = JSON.parse(response.body, symbolize_names: true)
          expect(bad_sub).to be_a(Hash)
          expect(bad_sub).to have_key(:error)
          expect(bad_sub[:error]).to be_a(String)
          expect(bad_sub[:error]).to eq("Tea must exist")
        end
      end
  end