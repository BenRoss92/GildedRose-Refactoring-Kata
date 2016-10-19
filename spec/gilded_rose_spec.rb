require 'gilded_rose'

describe GildedRose do

  describe 'quality' do
    it 'should never be negative after updating' do
      item = Item.new(name="bread", sell_in=0, quality=0)
      items = [item]
      gilded_rose = described_class.new(items)
      gilded_rose.update_quality
      expect(item.quality).to eq(0)
    end
  end

  describe 'sell_in' do
    it 'decreases quality by 1 after each day' do
      item = Item.new(name="bread", sell_in=1, quality=0)
      items = [item]
      gilded_rose = described_class.new(items)
      gilded_rose.update_quality
      expect(item.sell_in).to eq(0)
    end
  end

  describe 'Aged Brie' do
    context 'sell_in days is positive'
      it 'when sell_in days is positive, increases quality by 1 each day' do
        item = Item.new(name="Aged Brie", sell_in=3, quality=0)
        items = [item]
        gilded_rose = described_class.new(items)
        n = 3
        n.times do |x|
          gilded_rose.update_quality
        end
        expect(item.quality).to eq(n)
      end
    end

    context 'sell_in days is negative' do
      it 'when sell_in days is negative, doubles quality each day' do
        item = Item.new(name="Aged Brie", sell_in=0, quality=0)
        items = [item]
        gilded_rose = described_class.new(items)
        n = 3
        n.times do |x|
          gilded_rose.update_quality
        end
        expect(item.quality).to eq(2 * n)
      end

    end

  end
