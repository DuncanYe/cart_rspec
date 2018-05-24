class Cart
  attr_reader :items
  # 把@items 實例變數，做成可讀取的簡寫方法

  def initialize
    @items = []
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

end