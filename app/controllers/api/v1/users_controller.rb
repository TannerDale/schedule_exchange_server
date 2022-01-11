class Api::V1::UsersController < Api::V1::BaseController
  def create
    @user = User.create!(user_params)

    render json: V1::UserSerializer.new(@user)
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
