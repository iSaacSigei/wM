class ExportOrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @export_order = current_user.export_orders.new(export_order_params)

    if @export_order.save
      render json: @export_order, status: :created
    else
      render json: @export_order.errors, status: :unprocessable_entity
    end
  end

  # GET /export_orders/
  def index
    @export_orders = current_user.export_orders

    export_orders_with_images = @export_orders.map do |export_order|
      export_order.as_json.merge(images: export_order.images.map { |image| url_for(image) })
    end

    render json: export_orders_with_images, status: :ok
  end

  def show
    export_order = current_user.export_orders.find(params[:id])

    render json: export_order.as_json.merge(images: export_order.images.map { |image| url_for(image) })
  end

  private

  def export_order_params
    params.require(:export_order).permit(
      :export_to, :product, :units, :product_description,
      :company_name, :address, :city, :state_province, :contact,
      :request_quotation, images: []
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
