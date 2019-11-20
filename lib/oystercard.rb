class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journey_history, :journey

  def initialize
    @balance =  0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
    @journey = {entry_station: nil, exit_station: nil}
  end
  
  def top_up(amount)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

 

  def in_journey?
    # return @entry_station == entry_station ? true : false
    return !!@entry_station
    # !! - returns true, not necessary for the rest of the code to be written
  end

  def touch_in(entry_station)
    fail "Insufficient money to touch in" if balance < MINIMUM_BALANCE
    
    @entry_station = entry_station
    @in_journey = true
    
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)

    @exit_station = exit_station
    add_to_history

    @entry_station = nil
    @exit_station = nil

    @in_journey = false
    
  end

  def add_to_history

    @journey[:entry_station] = @entry_station
    @journey[:exit_station]  = @exit_station

    @journey_history << @journey
    
  end

  private

  def deduct(deducted_amount)    
    @balance -= deducted_amount
  end

  
end
