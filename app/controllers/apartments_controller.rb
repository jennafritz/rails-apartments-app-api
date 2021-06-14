class ApartmentsController < ApplicationController

    def index
        apartments = Apartment.all
        render json: apartments, status: :ok
    end

    def show
        apartment = find_apartment
        if apartment
            render json: apartment, status: :ok
        else
            render_not_found
        end
    end

    def create
        new_apartment = Apartment.create(apartment_params)
        # no validation for Apartment model, so no .valid? check
        render json: new_apartment, status: :created
    end

    def update
        apartment = find_apartment
        if apartment
            apartment.update!(apartment_params)
            render json: apartment, status: :ok
        # no validation for Apartment model, so no need to rescue from RecordInvalid
        # rescue ActiveRecord::RecordInvalid => invalid
        #     render json: {invalid.record.errors.full_messages}, status: :unprocessable_entity
        else
            render_not_found
        end
    end

    def destroy
        apartment = find_apartment
        if apartment
            apartment.destroy
            render json: {}, status: :no_content
        else
            render_not_found
        end
    end

    private

    def find_apartment
        Apartment.find_by(id: params[:id])
    end

    def apartment_params
        params.permit(:number)
    end

    def render_not_found
        render json: {error: "Not found"}, status: :not_found
    end

end
