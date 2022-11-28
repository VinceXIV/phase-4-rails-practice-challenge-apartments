class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        render json: Tenant.create!(tenant_params), status: :created
    end

    def index
        render json: Tenant.all, status: :ok
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, status: :ok, serializer: TenantApartmentSerializer
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update(tenant_params)

        render json: tenant, status: :ok
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy

        head :no_content
    end

    private
    def tenant_params
        params.permit(:name, :age)
    end

    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: 422
    end

    def record_not_found
        render json: {error: "Record not found"}, status: 404
    end
end
