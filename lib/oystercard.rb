require_relative './station.rb'
require_relative './journey.rb'

class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @card_info = {balance: 0, journey_history: [], journey: nil}
  end
  
  def top_up(amount)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if @card_info[:balance] + amount > MAXIMUM_BALANCE
    @card_info[:balance] += amount
  end


  def touch_in(entry_station)
    fail "Insufficient money to touch in" if @card_info[:balance] < MINIMUM_BALANCE

    if !!@card_info[:journey] == true
      @card_info[:journey] = @card_info[:journey].end_journey
      deduct(@card_info[:journey].fare)
      @card_info[:journey_history]<< @card_info[:journey]
      @card_info[:journey]= Journey.new(entry_station)
    else
      @card_info[:journey] = Journey.new(entry_station)
    end

  end

  def touch_out(exit_station)
    if @card_info[:journey] == nil
      @card_info[:journey] = Journey.new

      @card_info[:journey] = @card_info[:journey].end_journey(exit_station)
      deduct(@card_info[:journey].fare)
      add_to_history
      @card_info[:journey] = nil      
    else
      @card_info[:journey] = @card_info[:journey].end_journey(exit_station)
      deduct(@card_info[:journey].fare)
      add_to_history
      @card_info[:journey] = nil
    end

     puts "Your balance is now negative: #{@card_info[:balance]}" if @card_info[:balance] < 0
  end

  def balance
    @card_info[:balance]
  end

  private

  def deduct(deducted_amount)    
    @card_info[:balance] -= deducted_amount
  end

  def add_to_history
    @card_info[:journey_history]  << {ID: @card_info[:journey].journey_id, journey: @card_info[:journey]}
    # @journey = {entry_station: nil, exit_station: nil}
  end
end
