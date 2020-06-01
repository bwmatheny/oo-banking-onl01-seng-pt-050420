class Transfer
  attr_accessor :sender, :receiver, :amount, :status

    def initialize(from, to, amount)
      @sender = from
      @receiver = to
      @status = "pending"
      @amount = amount
    end

    def valid?
      self.receiver.valid? && self.sender.valid?
    end

    def execute_transaction
      if valid? && sender.balance > amount && self.status == "pending"
        receiver.balance += amount
        sender.balance -= amount
        self.status = "complete"
      else
        reject_transfer
      end
    end

    def reject_transfer
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

    def reverse_transfer
      if valid? && receiver.balance > amount && self.status == "complete"
        receiver.balance -= amount
        sender.balance += amount
        self.status = "reversed"
      else
        reject_transfer
      end
    end


end
