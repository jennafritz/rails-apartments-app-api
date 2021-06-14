class LeaseSerializer < ActiveModel::Serializer
  attributes :rent
  belongs_to :apartment, only: [:number]
  belongs_to :tenant, only: [:name, :age]
end
