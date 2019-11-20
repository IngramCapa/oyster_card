class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :in_journey, :journey_history, :journey

  def initialize
    @balance =  0
    @in_journey = false
    @journey_history = []
    @journey = {entry_station: nil, exit_station: nil}
  end
  
  def top_up(amount)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

  def in_journey?
    return !!@journey[:entry_station]
    # !! - returns true, not necessary for the rest of the code to be written
  end

  def touch_in(entry_station)
    fail "Insufficient money to touch in" if balance < MINIMUM_BALANCE
    
    @journey[:entry_station] = entry_station
    @in_journey = true
    
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)

    @journey[:exit_station]  = exit_station
    add_to_history

    @in_journey = false
    
  end

  private

  def deduct(deducted_amount)    
    @balance -= deducted_amount
  end

  def add_to_history
    @journey_history << @journey
    @journey = {entry_station: nil, exit_station: nil}
  end
end
