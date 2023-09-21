require "rails_helper"

RSpec.describe "it returns and updates subscriptions" do
  before(:each) do
    @customer1 = Customer.create!(first_name: 'Amy', last_name: 'Spears', email: 'amers123@gmail.com', address: '123 street, denver, CO, 80028')
    @tea1 = Tea.create!(title: 'Morning Time Tea', temperature: 'boiling', brew_time: '4-6 minutes')
    @tea2 = Tea.create!(title: 'Variety', temperature: 'boiling', brew_time: '8 minutes')
    @sub1 = Subscription.create!(title: "Super Fun Tea", price: 11.99, status: "inactive", frequency: "bi-weekly", customer_id: @customer1.id, tea_id: @tea1.id)
    @sub2 = Subscription.create!(title: "Monthly Tea", price: 10.00, status: "active", frequency: "monthly", customer_id: @customer1.id, tea_id: @tea2.id)
    @sub3 = Subscription.create!(title: "Tea, Tea, Tea", price: 12.50, status: "active", frequency: "weekly", customer_id: @customer1.id, tea_id: @tea1.id)
  end
  describe "happy paths for getting all subscriptions" do
    it "returns all valid subscriptions" do
      get "/api/v1/customers/#{@customer1.id}/subscriptions"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      subs = JSON.parse(response.body, symbolize_names: true)
      expect(subs).to be_a(Hash)
      expect(subs).to have_key(:data)
      expect(subs[:data].count).to eq(3)
      expect(subs[:data]).to be_an(Array)

      subs[:data].each do |sub|
        expect(sub).to be_a(Hash)
        expect(sub.count).to eq(3)
      end

      expect(subs[:data][0][:attributes]).to be_a (Hash)
      expect(subs[:data][0][:attributes].count).to eq(6)
      expect(subs[:data][3]).to eq(nil)
      expect(subs[:data][0][:attributes]).to have_key(:customer_id)
      expect(subs[:data][0][:attributes]).to have_key(:price)
      expect(subs[:data][0][:attributes]).to have_key(:status)
    end
  end

  describe "sad paths for getting all subscriptions" do
    it "returns an error message" do
      get "/api/v1/customers/99/subscriptions"

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      bad_subs = JSON.parse(response.body, symbolize_names: true)
      expect(bad_subs).to be_a(Hash)
      expect(bad_subs).to have_key(:error)
      expect(bad_subs[:error]).to eq('Customer must exist')
    end
  end

  describe "an endpoint to cancel a customers subscription" do
    it "changes status to inactive" do
      patch "/api/v1/customers/#{@customer1.id}/subscriptions/#{@sub3.id}"

      subscription_params = {
        title: "Tea, Tea, Tea",
        price: 12.50,
        status: "inactive",
        frequency: "weekly",
        customer_id: @customer1.id,
        tea_id: @tea1.id
        }

      expect(response).to be_successful
      expect(response.status).to eq(201)
      subscription = JSON.parse(response.body, symbolize_names: true)
      expect(subscription).to be_a(Hash)
    end
  end
end