require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it { should validate_inclusion_of(:status).in_array(["pending", "paid"]) }
  end

  describe "associations" do
    it { should belong_to(:creator).class_name("User") }
  end
end
