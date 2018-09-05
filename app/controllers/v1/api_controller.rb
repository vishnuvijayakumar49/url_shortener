class V1::ApiController < V1::BaseController
  before_filter :ensure_params_exist
  include TineeHelper

  def shorten
    authenticate = authenticate(params[:user], params[:password])
    status = authenticate[:success]
    if status
      render json: create_shorten_url
    else
      render json: {error: authenticate[:message]}
    end
  end

  def authenticate(user, password)
    resource = User.find_by_email(params[:user])
    return invalid_login_attempt if resource.blank?
    if resource.valid_password?(params[:password])
      sign_in("user", resource)
      password = resource.encrypted_password
      return {:success=>true, :auth_token=>password, :email=>resource.email}
    end
    invalid_login_attempt
  end

  def create_shorten_url
    valid_url = URI.unescape(params[:url])
    if valid_url
      begin
        save_encoded_url(valid_url)
      rescue ActiveRecord::RecordNotUnique
        old_tinee_url = TineeUrl.find_by_url(valid_url)
        url = request.base_url + '/' + old_tinee_url.encoded_id
        return { :status => "success" , :url =>  url}
      end
    else
       return { :status => "failure" }
    end
  end

  protected

  def ensure_params_exist
    return unless (params[:user].blank? || params[:password].blank?)
    return :json=>{:success=>false, :message=>"missing user_login parameter"}
  end

  def invalid_login_attempt
    warden.custom_failure!
    return {:success=>false, :message=>"Invalid login or password"}
  end
end