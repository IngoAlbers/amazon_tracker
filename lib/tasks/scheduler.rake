# frozen_string_literal:true

desc 'This task is called by the Heroku scheduler add-on'

namespace :articles do
  task store_current_prices: :environment do
    Article.all.each(&:store_current_price)
  end
end
