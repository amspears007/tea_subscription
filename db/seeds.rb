# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@customer1 = Customer.create!(first_name: 'Amy', last_name: 'Spears', email: 'amers123@gmail.com', address: '123 street, denver, CO, 80028')
@customer2 = Customer.create!(first_name: "John", last_name: "Doe", email: "john.doe@example.com", address: "123 Main St")
@tea1 = Tea.create!(title: 'Morning Time Tea', temperature: 'boiling', brew_time: '4-6 minutes')
@tea2 = Tea.create!(title: 'Variety', temperature: 'boiling', brew_time: '8 minutes')
@sub1 = Subscription.create!(title: "Super Fun Tea", price: 11.99, status: "inactive", frequency: "bi-weekly", customer_id: @customer1.id, tea_id: @tea1.id)
@sub2 = Subscription.create!(title: "Monthly Tea", price: 10.00, status: "active", frequency: "monthly", customer_id: @customer1.id, tea_id: @tea2.id)
@sub3 = Subscription.create!(title: "Tea, Tea, Tea", price: 12.50, status: "active", frequency: "weekly", customer_id: @customer1.id, tea_id: @tea1.id)

# tea1 = Tea.create(title: "Green Tea", description: "Refreshing green tea", temperature: 80, brew_time: 3)
# tea2 = Tea.create(title: "Black Tea", description: "Bold black tea", temperature: 95, brew_time: 5)
# tea3 = Tea.create(title: "Oolong Tea", description: "Fragrant oolong tea", temperature: 90, brew_time: 4)
# tea4 = Tea.create(title: "White Tea", description: "Delicate white tea", temperature: 85, brew_time: 2)

# subscription1 = Subscription.create(title: "Monthly Green Tea", price: 10.99, status: "active", frequency: "weekly", customer: customer1, tea: tea1)
# subscription2 = Subscription.create(title: "Weekly Black Tea", price: 8.99, status: :"active", frequency: "weekly", customer: customer2, tea: tea2)