class Api::V1::Customers::SubscriptionsController < ApplicationController
  def create
    new_sub = Subscription.new(subscription_params)
    if new_sub.save
			render json: SubscriptionsSerializer.new(new_sub), status: 201
		else
			render json: { error: new_sub.errors.full_messages.to_sentence }, status: 400
		end
  end
end

private

def subscription_params
  params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
end