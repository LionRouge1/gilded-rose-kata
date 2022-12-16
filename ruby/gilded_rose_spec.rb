require File.join(File.dirname(__FILE__), 'gilded_rose_impve')
require_relative 'item'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq("foo")
    end

    it 'Quality should decreses' do
      items =[Item.new("+5 Dexterity Vest", 10, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(9)
      expect(items[0].quality).to eq(19)
    end

    describe 'Quality should increase' do
      it 'when item name is Aged Brie' do
        items = [Item.new('Aged Brie', 2, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(1)
        expect(items[0].quality).to eq(1)
      end

      it 'when item name is Backstage passes to a TAFKAL80ETC concert' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(14)
        expect(items[0].quality).to eq(21)
      end

      it 'when item name is conjured Mana Cake' do
        items = [Item.new('conjured Mana Cake', 3, 6)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(2)
        expect(items[0].quality).to eq(5)
      end
    end

    describe 'Backstage passes to a TAFKAL80ETC concert' do
      it 'increase by 2 when sell_in is <= 10 ' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 47)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(9)
        expect(items[0].quality).to eq(49)
      end

      it 'increase by 3 when sell_in is <= 5 ' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 4, 47)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(3)
        expect(items[0].quality).to eq(50)
      end

      it 'drops to 0 when sell_in is <= 0 ' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 47)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(-1)
        expect(items[0].quality).to eq(0)
      end
    end

    it 'Quality and sell-in should not change' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(0)
      expect(items[0].quality).to eq(80)
    end

    it 'Quality should not be grader than 50' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 49)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(9)
      expect(items[0].quality).to be <= 50
    end
  end

end
