function Item(name, sell_in, quality) {
  this.name = name;
  this.sell_in = sell_in;
  this.quality = quality;
}

const items = [];
const itemNames = ['Aged Brie', 'Backstage passes to a TAFKAL80ETC concert', 'Sulfuras, Hand of Ragnaros', 'Conjured Mana Cake'];

const degrades = (quality, value = 1) => {
  let valueUpdated;
  if(quality > 0) valueUpdated = quality - value;
  if(valueUpdated < 0) valueUpdated = 0;
  return valueUpdated;
};

const increases = (quality, value = 1) => {
  let valueUpdated;
  if(quality < 50) valueUpdated = quality + value;
  if(valueUpdated > 50) valueUpdated = 50;
  return valueUpdated;
};

const update_quality = () => {
  items.forEach((item) => {
    if(item.name === itemNames[2]) {
      item.sell_in -= 1;
      return item;
    }

    if(item.name === itemNames[3]) {
      item.sell_in -= 1;
      return item.quality = degrades(item.quality, 2);
    }

    if(item.sell_in <= 0 ) {
      if(!itemNames.slice(0,2).includes(item.name)) {
        item.quality = degrades(item.quality, 2);
      } else {
        (item.name === itemNames[1]) ? item.quality = 0 : item.quality = increases(item.quality);
      };
    } else {
      if(item.name === itemNames[0]) {
        item.quality = increases(item.quality);
      } else if(item.name === itemNames[1]) {
        switch(true) {
          case (item.sell_in <= 5):
            item.quality = increases(item.quality, 3);
            break;
          case (item.sell_in <= 10):
            item.quality = increases(item.quality, 2);
            break;
          default:
            item.quality = increases(item.quality);
        }
      } else {
        item.quality = degrades(item.quality);
      }
    };

    item.sell_in -= 1;
  });
}
