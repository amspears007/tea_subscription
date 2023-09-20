require "rails_helper"

RSpec.describe "it returns all subscriptions" do
  before(:each) do
    @customer1 = Customer.create!(first_name: 'Amy', last_name: 'Spears', email: 'amers123@gmail.com', address: '123 street, denver, CO, 80028')
    @tea1 = Tea.create!(title: 'Morning Time Tea', temperature: 'boiling', brew_time: '4-6 minutes')
    @tea2 = Tea.create!(title: 'Variety', temperature: 'boiling', brew_time: '8 minutes')
    @sub1 = Subscription.create!(title: "Super Fun Tea", price: 11.99, status: "inactive", frequency: "bi-weekly", customer_id: @customer1.id, tea_id: @tea1.id)
    @sub2 = Subscription.create!(title: "Monthly Tea", price: 10.00, status: "active", frequency: "monthly", customer_id: @customer1.id, tea_id: @tea2.id)
    @sub3 = Subscription.create!(title: "Tea, Tea, Tea", price: 12.50, status: "active", frequency: "weekly", customer_id: @customer1.id, tea_id: @tea1.id)
  end

  describe "happy paths" do
    it "can create a subscription with a customer and tea id" do
      get "/api/v1/customers/#{@customer1.id}/subscriptions"

      expect(response).to be_successful
      expect(response.status).to eq(201)
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(subscription).to be_a(Hash)
    end
  end
end