class ApplicationController < ActionController::API
  before_action :make_it_snake!

  private

  def make_it_snake!
    params.deep_transform_keys!(&:underscore)
  end
end
