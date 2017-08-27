require 'amazon/ecs'

class Article < ApplicationRecord
  has_many :prices

  after_create :store_current_price

  def current_price
    res = Amazon::Ecs.item_lookup(asin, { response_group: 'Offers', country: 'de' })
    item = res.get_element('Item')
    item.get_element('LowestNewPrice').get('Amount')
  end

  def last_stored_price
    prices&.order(date: :desc)&.first&.amount
  end

  def store_current_price
    prices << Price.create(amount: current_price.to_i / 100.0, date: Date.today) if current_price.present?
  end
end
