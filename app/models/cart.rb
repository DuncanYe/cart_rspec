class Cart
  attr_reader :items
  # 把@items 實例變數，做成可讀取的簡寫方法

  def initialize(items = [])
    @items = items
  end

  def add_item(id)
    #不清楚 id , product_id 
    find_item = items.find { |item| item.product_id == id }

    if find_item
      find_item.increment
    else
      @items << CartItem.new(id)
    end
  end

  def empty?
    @items.empty?
  end

  def total_price
    items.reduce(0) { |sum, item| sum + item.price }
  end

  def serialize
    all_items = items.map {
      |item|
      { "product_id" => item.product_id, "quantity" => item.quantity }
    }

    { "items" => all_items }
  end

  def self.from_hash(hash)
    if hash.nil?
      new[]
    else
      new hash["items"].map { |item_hash|
        CartItem.new(item_hash["product_id"], item_hash["quantity"])
       }
    end
  end

end