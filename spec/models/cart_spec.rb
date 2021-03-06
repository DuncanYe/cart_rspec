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

      expect(cart.items.first.product.title).to eq "拉拉鍊"
      expect(cart.items.first.quantity).to eq 4
      expect(cart.items.second.product_id).to be p2.id
      expect(cart.items.first.product).to be_a Product
    end

    it "購物車裡的項目可以計算自己的項目總額" do
      cart = Cart.new
      p1 = Product.create(title:"蘋果", price: 100)
      p2 = Product.create(title:"梨子", price: 300)

      3.times{ cart.add_item(p1.id) }
      2.times{ cart.add_item(p2.id) }

      expect(cart.items.first.price).to be 300
      expect(cart.items.second.price).to be 600
    end

    it "購物車計算自己的總額" do
      cart = Cart.new
      p1 = Product.create(title:"手錶", price: 50)
      p2 = Product.create(title:"鹹酥雞", price: 100)

      3.times {
        cart.add_item(p1)
        cart.add_item(p2)
            # 這裡傳只寫p1或數字也都可以？有傳什麼比較好嗎？
      }
      expect(cart.total_price).to be 450
    end

    describe "購物車進階功能" do
      it "將購物車內容轉成 Hash ，存到 Session 裡" do
        cart = Cart.new
        3.times { cart.add_item(2) }
        4.times { cart.add_item(3) }

        expect(cart.serialize).to eq session_hash
      end
    end

    it "可以把 Session 內容(Hash 格式)，還原成購物車內容" do
      cart = Cart.from_hash(session_hash)

      expect(cart.items.first.product_id).to be 2
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.product_id).to be 3
      expect(cart.items.second.quantity).to be 4
    end

    private

    def session_hash
      {
        "items" => [
          {"product_id" => 2, "quantity" => 3},
          {"product_id" => 3, "quantity" => 4}
        ]
      }
    end

  end
end
