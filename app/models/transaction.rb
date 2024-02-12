class Transaction < ApplicationRecord
  belongs_to :user

  TYPES = {
    transfer_to_user: 'transfer_to_user',
    transfer_from_user: 'transfer_from_user',
    transfer_out: 'transfer_out',
    transfer_in: 'transfer_in'
  } 
end
