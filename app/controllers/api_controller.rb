class ApiController < ApplicationController

  protect_from_forgery with: :null_session
  before_action :set_request_details
  before_action :authenticate_request

  helper_method :current_user,:search_query,:current_page,:permissions

  class NotAuthenticatedError < StandardError; end
  rescue_from NotAuthenticatedError do
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end


  class ExpiredSessionError < StandardError; end
  rescue_from ExpiredSessionError do
    render json: { error: 'Your session has expired' }, status: :unauthorized # unofficial expired session
  end


  def authenticate_request
    fail ExpiredSessionError if current_user.nil?
  end




  def current_user
    @current_user ||= User.find_by(access_token: request.headers['Authorization'])
  end


  def current_page
    params[:page].present? ? params[:page] : 1
  end

  def search_query
    @search_query ||= params[:query].present? ? JSON.parse(params[:query].gsub('=>', ':')) : false
  end


  protected

  def render_obj_errors(obj = nil)
    render json: {
      message: 'Validation failed', errors: (obj || @obj).errors.full_messages
    }, status: 422
  end
end
