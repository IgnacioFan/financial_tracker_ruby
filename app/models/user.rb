class User < ApplicationRecord
  ROLE = {
    admin: 1,
    staff: 2,
    client: 3
  }

  before_validation :default_role, :on => :create

  validates_presence_of :name

  has_many :products

  private

  def default_role
    self.role = ROLE[:client]
  end
end
