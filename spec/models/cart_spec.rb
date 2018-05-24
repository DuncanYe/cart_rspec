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

    it "商品可放進購物車，也可以拿出來(要是同個商品)" do
      cart = Cart.new
      p1 = Product.create(title:"拉拉鍊")
      p2 = Product.create(title:"游泳")

      4.times { cart.add_item(p1.id) }
      3.times { cart.add_item(p2.id) }

      expect(cart.items.first.title).to eq "拉拉鍊"
      expect(cart.items.second.product_id).to eq p2.id
      expect(cart.items.first.product).to be_a Product
    end

  end
end
