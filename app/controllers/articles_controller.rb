require 'amazon/ecs'

class ArticlesController < ApplicationController
  def index

    res = Amazon::Ecs.item_search('ruby', country: 'de')

    item = res.items.first
    item_attributes = item.get_element('ItemAttributes')

    res = Amazon::Ecs.item_lookup('B01KV1C1D6', { country: 'de' })
    item = res.get_element('Item')
    item_attributes = item.get_element('ItemAttributes')

    @bla = item_attributes.get_element('Title')

    res = Amazon::Ecs.item_lookup('B01KV1C1D6', { response_group: 'Offers', country: 'de' })
    item = res.get_element('Item')
    @bla_price = item.get_element('LowestNewPrice').get_element('Amount')
  end
end
