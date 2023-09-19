require "rails_helper"

RSpec.describe "Create a new subscription" do
  before(:each) do
    @customer1 = Customer.create!(first_name: 'Amy', last_name: 'Spears', email: 'amers123@gmail.com', address: '123 street, denver, CO, 80028')
    @tea1 = Tea.create!(title: 'Earl Grey', temperature: 'boiling', brew_time: '4-6 minutes')
    
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
# require 'pry'; binding.pry
        expect(subscription).to be_a(Hash)
      end
    end
  end