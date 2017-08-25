require 'amazon/ecs'

class Article < ApplicationRecord
  has_many :prices

  def current_price
    res = Amazon::Ecs.item_lookup(asin, { response_group: 'Offers', country: 'de' })
    item = res.get_element('Item')
    item.get_element('LowestNewPrice').get('Amount')
  end

  def store_current_price
    prices << Price.create(amount: current_price, date: Date.today) if current_price.present?
  end
end
