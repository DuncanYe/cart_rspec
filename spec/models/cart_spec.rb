require 'rails_helper'

RSpec.describe Cart, type: :model do
  
  describe "購物車基本功能" do 

    it "商品可放進購物車，購物車裡要有東西" do
      cart = Cart.new
      cart.add_item (1)
      expect(cart.empty?).to be false
    end

    it "加了同樣種類商品，只增加商品數量，不增加購買項目(Cart Item)" do
      cart = Cart.new
      3.times {  cart.add_item (1) }
      5.times {  cart.add_item (2) }

      expect(cart.items.length).to be 2
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.quantity).to be 5
    end

  end
end
