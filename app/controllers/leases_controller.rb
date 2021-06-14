class LeasesController < ApplicationController
    
    def create
        lease = Lease.create(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = find_lease
        if lease
            lease.destroy
        else
            render_not_found
        end
    end

    private

    def find_lease
        Lease.find_by(id: params[:id])
    end

    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end

    def render_not_found
        render json: {error: "Not found"}, status: :not_found
    end
    
end
