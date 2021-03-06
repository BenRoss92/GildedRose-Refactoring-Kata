class GildedRose

  def initialize(items)
    @items = items
  end

  def normal_update_quality
    @items.each do |item|
      item.sell_in -= 1
      return if item.quality == 0
      item.quality -= 1
      item.quality -= 1 if item.sell_in < 0
    end
  end

  def brie_update_quality
    @items.each do |item|
      item.sell_in -= 1
      return if item.quality >= 50
      item.quality += 1
      item.quality += 1 if item.sell_in < 0
    end
  end

  def sulfuras_update_quality
  end

  def backstage_update_quality
    @items.each do |item|
      item.sell_in -= 1
      item.quality += 1
      return if item.quality >= 50
      return item.quality = 0 if item.sell_in < 0
      item.quality += 1 if item.sell_in <= 5
      item.quality += 1 if item.sell_in <= 10
    end
  end

  def update_quality
    @items.each do |item|
      case item.name
      when "Normal Item"
        return normal_update_quality
      when "Aged Brie"
        return brie_update_quality
      when "Sulfuras, Hand of Ragnaros"
        return sulfuras_update_quality
      when "Backstage passes to a TAFKAL80ETC concert"
        return backstage_update_quality
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
