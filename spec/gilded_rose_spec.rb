require 'gilded_rose'

describe GildedRose do

  describe 'normal item' do

    describe 'quality' do
      it 'should never be negative after updating' do
        item = Item.new(name="normal item", sell_in=0, quality=0)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.quality).to eq(0)
      end

      it 'should never be more than 50' do
        item = Item.new(name="normal item", sell_in=2, quality=50)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.quality).to be <=(50)
      end
    end

    describe 'sell_in' do
      it 'decreases quality by 1 after each day' do
        item = Item.new(name="normal item", sell_in=1, quality=0)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq(0)
      end
    end

    context 'sell_in days is negative' do
      it 'quality degrades twice as fast' do
        quality = 10
        item = Item.new(name="normal item", sell_in=0, quality=quality)
        items = [item]
        gilded_rose = described_class.new(items)
        n = 3
        n.times do |x|
          gilded_rose.update_quality
        end
        expect(item.quality).to eq(quality - (n * 2))
      end
    end

  end

  describe 'Aged Brie' do
    context 'sell_in days is positive'
      it 'increases quality by 1 each day' do
        item = Item.new(name="Aged Brie", sell_in=3, quality=0)
        items = [item]
        gilded_rose = described_class.new(items)
        n = 3
        n.times do |x|
          gilded_rose.update_quality
        end
        expect(item.quality).to eq(n)
      end

      it 'quality should never be more than 50' do
        item = Item.new(name="Aged Brie", sell_in=2, quality=49)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.quality).to be(50)
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
        expect(item.quality).to eq(n * 2)
      end

    end

    describe 'Sulfuras, Hand of Ragnaros' do
      it 'sell_in days do not decrease' do
        item = Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=2, quality=49)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to be(2)
      end

      it 'quality does not decrease' do
        item = Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=2, quality=49)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.quality).to be(49)
      end
    end


  end
