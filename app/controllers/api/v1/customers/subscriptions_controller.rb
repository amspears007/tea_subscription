class Api::V1::Customers::SubscriptionsController < ApplicationController
  def create
    # customer = Customer.find(params[:customer_id])
    new_sub = Subscription.create!(subscription_params)
    if new_sub.save
			render json: SubscriptionsSerializer.new(new_sub), status: 201
		else
			render json: { error: sub.errors.full_messages.to_sentence }, status: 400
		end
    # require 'pry'; binding.pry
  end
end

private

def subscription_params
  params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
end