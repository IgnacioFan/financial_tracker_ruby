class User < ApplicationRecord
  ROLE = {
    admin: 1,
    staff: 2,
    client: 3
  }

  before_validation :set_client, :on => :create

  validates_presence_of :name

  private

  def set_client
    self.role = ROLE[:client]
  end
end
