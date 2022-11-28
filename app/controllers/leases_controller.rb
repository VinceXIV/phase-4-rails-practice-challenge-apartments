class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        render json: Lease.create!(lease_params), status: :created
    end

    def index
        render json: Lease.all, status: :ok
    end

    def show
        lease = Lease.find(params[:id])
        render json: lease, status: :ok
    end

    def update
        lease = Lease.find(params[:id])
        lease.update(lease_params)

        render json: lease, status: :ok
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy

        head :no_content
    end

    private
    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: 422
    end

    def record_not_found
        render json: {error: "Record not found"}, status: 404
    end
end
