class OysterCard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  

  def initialize
    @balance =  0
    @in_journey = false
  end
  
  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
    
  end

  def deduct(deducted_amount)
    # fail "Not enough money on the card, balance is #{balance}" if @balance < deducted_amount
    
    @balance -= deducted_amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

end
