class GildedRose
    def initialize(items)
        @items = items
        @quality_names = ['Aged Brie', 'Backstage passes to a TAFKAL80ETC concert', 'Sulfuras, Hand of Ragnaros', 'Conjured Mana Cake']
    end

    def update_quality
        @items.each do |item|
            update_item(item)
            item.sell_in -= 1 unless item.name === @quality_names[2]
        end
    end

    private

    def degrades(quality, value = 1)
        (quality - value > 0)? quality - value : 0;
    end

    def increases(quality, value = 1)
        (quality + value < 50)? quality + value : 50;
    end

    def update_item(item)
        case item.name
        when @quality_names[0]
            item.quality = increases(item.quality);
        when @quality_names[1]
            if(item.sell_in <= 0)
                item.quality = 0;
            elsif(item.sell_in <= 5)
                item.quality = increases(item.quality, 3);
            elsif(item.sell_in <= 10)
                item.quality = increases(item.quality, 2);
            else
                item.quality = increases(item.quality);
            end
        when @quality_names[2]
            item
        when @quality_names[3]
            item.quality = degrades(item.quality, 2);
        else
            item.quality = (item.sell_in <= 0)? degrades(item.quality, 2) : degrades(item.quality);
        end
    end
end