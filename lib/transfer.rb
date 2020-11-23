require "pry"

class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  
  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def valid?
    # can check that both accounts are valid
    # calls on the sender and receiver's #valid? methods
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    # can execute a successful transaction between two accounts
    # each transfer can only happen once
    # rejects a transfer if the sender does not have enough funds (does not have a valid account)
    if @sender.balance >= @amount && @status == "pending" && self.valid?
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
    else 
      reject_tranfser
    end
  end

  def reject_tranfser
    @status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  def reverse_transfer
    # can reverse a transfer between two accounts
    # it can only reverse executed transfers
    if @receiver.balance >= @amount && @status == "complete" && self.valid?
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = "reversed"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

  end

end
