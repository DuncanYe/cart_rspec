require 'rails_helper'

RSpec.describe Cart, type: :model do
  
  describe "購物車基本功能" do 

    it "商品可放進購物車，購物車裡要有東西" do
      cart = Cart.new
      cart.add_item (1)
      expect(cart.empty?).to be false
    end
  end
end
