require 'rails_helper'

describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :description }
    it { should validate_presence_of :discount_amount }
    it { should validate_presence_of :minimum_quantity }
  end

  describe "relationships" do
    it {should belong_to :item}
  end

end  
