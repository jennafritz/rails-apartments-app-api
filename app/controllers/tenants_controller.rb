class TenantsController < ApplicationController

    def index
        tenants = Tenant.all
        render json: tenants, status: :ok
    end

    def show
        tenant = find_tenant
        if tenant
            render json: tenant, status: :ok
        else
            render_not_found
        end
    end

    def create
        new_tenant = Tenant.create!(tenant_params)
        render json: new_tenant, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def update
        tenant = find_tenant
        if tenant
            tenant.update!(tenant_params)
            render json: tenant, status: :ok
        else
            render_not_found
        end
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def destroy
        tenant = find_tenant
        if tenant
            tenant.destroy
            render json: {}, status: :no_content
        else
            render_not_found
        end
    end

    private

    def find_tenant
        Tenant.find_by(id: params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def render_not_found
        render json: {error: "Not found"}, status: :not_found
    end

end
