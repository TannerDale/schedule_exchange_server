class Api::V1::StoresController < Api::V1::BaseController
  def index; end

  def show; end

  def create
    store = Store.create!(store_params)
    render json: V1::StoreSerializer.new(store), status: 201
  end

  private

  def store_params
    params.permit(:street_address, :zip_code, :store_number, :company_id)
  end
end
