function Item(name, sell_in, quality) {
  this.name = name;
  this.sell_in = sell_in;
  this.quality = quality;
}

const items = [];
const itemNames = ['Aged Brie', 'Backstage passes to a TAFKAL80ETC concert', 'Sulfuras, Hand of Ragnaros', 'Conjured Mana Cake'];

const degrades = (quality, value = 1) => {
  return (quality - value > 0)? quality - value : 0;
};

const increases = (quality, value = 1) => {
  return (quality + value < 50)? quality + value : 50;
};

const update_quality = () => {
  items.forEach((item) => {

    switch(item.name) {
      case itemNames[0]:
        item.quality = increases(item.quality);
        break;
      case itemNames[1]:
        switch(true) {
          case (item.sell_in <= 0):
            item.quality = 0;
            break;
          case (item.sell_in <= 5):
            item.quality = increases(item.quality, 3);
            break;
          case (item.sell_in <= 10):
            item.quality = increases(item.quality, 2);
            break;
          default:
            item.quality = increases(item.quality);
        }
        break;
      case itemNames[2]:
        item;
        break;
      case itemNames[3]:
        item.quality = degrades(item.quality, 2);
        break;
      default:
        item.quality = (item.sell_in <= 0)? degrades(item.quality, 2) : degrades(item.quality);
    }

    item.sell_in -= 1;
  });
}
