class Api::V1::CompaniesController < ApiController
  load_and_authorize_resource
  before_action :set_company, only: [:show, :update , :destroy]

  def index
    @companies = Company.accessible_by(current_ability) #in pundit we use current_policy
      # @companies = current_user.companies
    render json: @companies, status: :ok
  end

  def show
    render json: @company, status: :ok
  end

  def create
    @company = Company.new(company_params)
    #@company = current_user.companies.build(company_params)
    if @company.save
      render json: @company, status: :ok
    else
      Rails.logger.error("Company creation failed: #{@company.errors}")
      render json: { data: @company.errors.full_messages, status: "failed" },
             status: :unprocessable_entity
    end
  end

  def update
       if @company.update(company_params)
        render json: @company, status: :ok
       else
        render json: {data: @company.errors.full_messages, status: "failed"},
          status: :unprocessable_entity
       end
  end

  def destroy
    if @company.destroy
      render json: {data: 'Company deleted successfully', status: 'sucess'},
        status: :ok
    else
      render json: {data: 'Something went wrong', status: 'failed'}
    end
  end
  private

  def set_company
    @company = current_user.companies.find(params[:id])
  rescue ActiveRecord::RecordNotFound => error
    render json: error.message, status: :unauthorized
  end

  def company_params
    params.require(:company).permit(:name, :address, :established_year,:user_id )
  end
end
