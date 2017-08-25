class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.references :article
      t.date :date
      t.monetize :amount
    end
  end
end
