class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    render json: V1::UserSerializer.new(user)
  end

  def create
    user = User.create!(user_params)
    render json: V1::UserSerializer.new(user), status: 201
  end

  private

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :company_id,
      :role
    )
  end
end
