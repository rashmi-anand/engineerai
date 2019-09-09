class SecretCodesController < ApplicationController
	load_and_authorize_resource

	def index
		@secret_codes = SecretCode.all.paginate(page: params[:page])
	end

	def create
		sc_count = secret_code_params[:count].to_i
		SecretCode.create_codes sc_count
		flash[:now] = "#{ sc_count} secret code created successfully"
		redirect_to secret_codes_path
	end	

	private

	def secret_code_params
		params.permit(:count)
	end
end
