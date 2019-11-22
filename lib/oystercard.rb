require_relative './station.rb'
require_relative './journey.rb'

class OysterCard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @journey_history = []
    @balance = 0
  end
  
  def top_up(amount)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end


  def touch_in(entry_station)
    fail "Insufficient money to touch in" if @balance < MINIMUM_BALANCE

    unless @journey.nil?
      @journey.end_journey
      deduct(@journey.fare)
      add_to_history
    end

    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    if @journey == nil
      @journey = Journey.new

      @journey.end_journey(exit_station)
      deduct(@journey.fare)
      add_to_history
      @journey = nil      
    else
      @journey.end_journey(exit_station)
      deduct(@journey.fare)
      add_to_history
      @journey = nil
    end

    puts "Your balance is now negative: #{@balance}" if @balance < 0
  end

  def balance
    @balance
  end

  def in_journey?
    !@journey.nil? && @journey.in_journey?
  end

  private

  def deduct(deducted_amount)    
    @balance -= deducted_amount
  end

  def add_to_history
    @journey_history  << @journey
  end
end
