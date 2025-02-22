class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end 

  def valid? 
    if @sender.valid? && @receiver.valid?
      return true
    else 
      return false
    end 
  end 

  def execute_transaction
    if @sender.balance < @amount || !valid?
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    elsif @status == "complete"
      return "you have already made the transaction"
    else
      @sender.balance -= @amount
      @receiver.deposit(@amount)
      @status = "complete"
    end
  end

  def reverse_transfer
    if @status == 'complete'
      @sender.deposit(@amount)
      @receiver.balance -= @amount
      @status = 'reversed'
    end
  end
end
