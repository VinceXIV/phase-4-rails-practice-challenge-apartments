class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        render json: Apartment.create!(apartment_params), status: :created
    end

    def index
        render json: Apartment.all, status: :ok
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok, serializer: ApartmentTenantSerializer
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)

        render json: apartment, status: :ok
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy

        head :no_content
    end

    private
    def apartment_params
        params.permit(:number)
    end

    def record_invalid(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: 422
    end

    def record_not_found
        render json: {error: "Record not found"}, status: 404
    end
end
