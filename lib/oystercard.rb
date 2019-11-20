class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :in_journey, :entry_station

  def initialize
    @balance =  0
    @in_journey = false
    @entry_station = nil

  end
  
  def top_up(amount)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

 

  def in_journey?
    # @in_journey
    return @entry_station == entry_station ? true : false

  end

  def touch_in(entry_station)
    fail "Insufficient money to touch in" if balance < MINIMUM_BALANCE
    
    @entry_station = entry_station
    @in_journey = true
    
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
    @in_journey = false
  end


  private

  def deduct(deducted_amount)    
    @balance -= deducted_amount
  end

  
end
