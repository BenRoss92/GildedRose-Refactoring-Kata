require 'gilded_rose'

describe GildedRose do

  it 'quality should never be negative after updating' do
    item = Item.new(name="bread", sell_in=0, quality=0)
    items = [item]
    gilded_rose = described_class.new(items)
    gilded_rose.update_quality
    expect(item.quality).to eq(0)
  end

end
