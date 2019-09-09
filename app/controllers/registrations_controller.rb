class RegistrationsController < Devise::RegistrationsController
  def new
  	@secret_code = SecretCode.available.first
  	if @secret_code.present?
      super
    else
      flash[:error] = "No Secret Code available, please request for a secret code from admin user"
      redirect_to root_path
    end
  end

  def create
   	super
  end

  def update
    super
  end

  
end 