class ImportOrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @import_order = current_user.import_orders.new(import_order_params)
    if @import_order.save
      render json: @import_order, status: :created
    else
      render json: @import_order.errors, status: :unprocessable_entity
    end
  end

  # GET /import_orders/
  def index
    @import_orders = current_user.import_orders

    render json: @import_orders, status: :ok
  end

  private

  def import_order_params
    params.require(:import_order).permit(
      :import_from, :product, :units, :product_description, 
      :product_link, :company_name, :address, :city, 
      :state_province, :contact, :request_quotation
    )
  end

  def authenticate_user!
    unless session[:user_id] && User.exists?(session[:user_id])
      render json: { error: 'Not logged in' }, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
