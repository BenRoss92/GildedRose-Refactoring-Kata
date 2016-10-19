require 'gilded_rose'

describe GildedRose do

  describe 'Normal Item' do

    describe 'sell_in days' do
      it 'decreases sell_in by 1 after each day' do
        item = Item.new(name="Normal Item", sell_in=1, quality=0)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq(0)
      end

      it 'decreases sell_in by number of days passed' do
        n = 3
        item = Item.new(name="Normal Item", sell_in=n, quality=0)
        items = [item]
        gilded_rose = described_class.new(items)
        n.times do |x|
          gilded_rose.update_quality
          expect(item.sell_in).to eq(n - (x + 1))
        end
        expect(item.sell_in).to eq(0)
      end

      it 'sell_in days can be negative' do
        item = Item.new(name = "Normal Item", sell_in=0, quality=0)
        items = [item]
        gilded_rose = described_class.new(items)
        gilded_rose.update_quality
        expect(item.sell_in).to eq(-1)
      end

    end

    describe 'quality' do

      context 'sell_in days is positive' do
        it 'should never be negative after updating' do
          item = Item.new(name="Normal Item", sell_in=0, quality=0)
          items = [item]
          gilded_rose = described_class.new(items)
          gilded_rose.update_quality
          expect(item.quality).to eq(0)
        end

        it 'should never be more than 50' do
          item = Item.new(name="Normal Item", sell_in=2, quality=50)
          items = [item]
          gilded_rose = described_class.new(items)
          gilded_rose.update_quality
          expect(item.quality).to be <=(50)
        end

        it 'decreases quality by 1' do
          item = Item.new('Normal Item', sell_in=1, quality=1)
          items = [item]
          gilded_rose = described_class.new(items)
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end

        it 'decreases quality by no. of sell_in days' do
          n = 3
          item = Item.new('Normal Item', sell_in=n, quality=3)
          items = [item]
          gilded_rose = described_class.new(items)
          n.times do |x|
            gilded_rose.update_quality
          end
          expect(item.quality).to eq 0
        end
      end

      context 'sell_in days is negative' do
        it 'quality degrades twice as fast' do
          quality = 10
          item = Item.new(name="Normal Item", sell_in=0, quality=quality)
          items = [item]
          gilded_rose = described_class.new(items)
          n = 3
          n.times do |x|
            gilded_rose.update_quality
          end
          expect(item.quality).to eq(quality - (n * 2))
        end

        it 'lowers quality value twice as fast after N days' do
          quality = 10
          item = Item.new('Normal Item', sell_in=0, quality=quality)
          items = [item]
          gilded_rose = described_class.new(items)
          n = 3
          n.times do |x|
            gilded_rose.update_quality
          end
          expect(item.quality).to eq (quality - (2 * n))
        end
      end
    end

  end

  describe 'Aged Brie' do
    it 'quality should never be more than 50' do
      item = Item.new(name="Aged Brie", sell_in=2, quality=49)
      items = [item]
      gilded_rose = described_class.new(items)
      gilded_rose.update_quality
      expect(item.quality).to be(50)
    end

    context 'sell_in days is positive' do
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
    end

      context 'sell_in days is negative' do
        it 'doubles quality each day' do
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

    describe 'Backstage passes to a TAFKAL80ETC concert' do

      context 'sell_in days above 10 and quality is 49' do
        it 'quality increases to 50' do
          item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=15, quality=49)
          items = [item]
          gilded_rose = described_class.new(items)
          gilded_rose.update_quality
          expect(item.quality).to eq(50)
        end
      end

      context 'sell_in days at least 5 and quality is 49' do
        it 'increases to 50 instead of 51' do
          item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=5, quality=49)
          items = [item]
          gilded_rose = described_class.new(items)
          gilded_rose.update_quality
          expect(item.quality).to eq(50)
        end
      end

      context 'sell_in days is positive' do
        it 'increases quality by 1 each day' do
          item = Item.new(name='Backstage passes to a TAFKAL80ETC concert', sell_in=20, quality=0)
          items = [item]
          gilded_rose = described_class.new(items)
          n = 3
          n.times do |x|
            gilded_rose.update_quality
          end
          expect(item.quality).to eq(quality + n)
        end
      end

      context 'sell_in days is 10 or less and more than 5' do
        it 'doubles quality each day' do
          item = Item.new(name='Backstage passes to a TAFKAL80ETC concert', sell_in=10, quality=0)
          items = [item]
          gilded_rose = described_class.new(items)
          n = 3
          n.times do |x|
            gilded_rose.update_quality
          end
          expect(item.quality).to eq(n * 2)
        end
      end

      context 'when sell in 5 days or less' do
         it 'increases by 3 the older it gets' do
           item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=5, quality=1)
           items = [item]
           gilded_rose = described_class.new(items)
           n = 5
           n.times do |x|
             gilded_rose.update_quality
           end
           expect(item.quality).to eq (quality + (n * 3))
         end
       end


      context 'sell_in days is 0' do
        it 'quality is 0' do
          item = Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in=0, quality=5)
          items = [item]
          gilded_rose = described_class.new(items)
          gilded_rose.update_quality
          expect(item.quality).to eq(0)
        end
      end
    end


  end
