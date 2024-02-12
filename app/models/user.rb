class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :lastname, presence: true
    validates :email, presence: true, uniqueness: true

    has_many :transactions

    def award_welcome_bonus
        update(available_cash: BigDecimal('100.00'))
    end

    def transfer_cash(recipient, amount)
        ActiveRecord::Base.transaction do
            lock!
            update!(available_cash: available_cash - amount)
            recipient.update!(available_cash: recipient.available_cash + amount)
      
            Transaction.create!(transaction_type: Transaction::TYPES[:transfer_to_user], value: BigDecimal(amount), user: self, info: "Transfer of Silveruros to user with ID: #{recipient.id}")
            Transaction.create!(transaction_type: Transaction::TYPES[:transfer_from_user], value: BigDecimal(amount), user: recipient, info: "Transfer of Silveruros from user with ID: #{self.id}")
        end
        true
    end
end
