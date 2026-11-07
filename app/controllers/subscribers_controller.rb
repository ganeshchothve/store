class SubscribersController < ApplicationController
  allow_unauthenticated_access
  before_action :set_product

  def create
    @subscriber = @product.subscribers.where(subscriber_params).first_or_create
    if @subscriber.save
      redirect_to @product, notice: "Successfully subscribed."
    else
      render "products/show", status: :unprocessable_entity
    end
  end

  private

  def subscriber_params
    params.expect(subscriber: [ :email ])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
