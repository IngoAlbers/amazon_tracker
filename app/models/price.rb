class Price < ApplicationRecord
  belongs_to :article

  monetize :amount_cents
end
