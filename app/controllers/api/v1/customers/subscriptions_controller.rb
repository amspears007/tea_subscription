class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find_by(id: params[:customer_id])
    if customer.nil?
      render json: { error: 'Customer must exist' }, status: 401
    else
      customer_subs = customer.subscriptions
      render json: SubscriptionsSerializer.new(customer_subs)
    end
  end

  def create
    new_sub = Subscription.new(subscription_params)
    if new_sub.save
			render json: SubscriptionsSerializer.new(new_sub), status: 201
		else
			render json: { error: new_sub.errors.full_messages.to_sentence }, status: 400
		end
  end

  def update
    updated_sub = Subscription.find_by(id: params[:id])
    # if updated_sub.nil?
    #   render json: { error: 'Subscription must exist' }, status: 401
    if updated_sub.update(subscription_params)
			render json: SubscriptionsSerializer.new(updated_sub), status: 201
    else
			render json: { error: updated_sub.errors.full_messages.to_sentence }, status: 400
    end
  end
end

private

def subscription_params
  params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
end