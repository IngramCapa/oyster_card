require_relative "station"

class Journey 

  attr_reader :in_journey

  def initialize
    @in_journey = false
    @complete = false
  end

  def complete?
    @complete
  end


  def fare
  end


  # def in_journey?
  #   return !!@journey[:entry_station]
  #   # !! - returns true, not necessary for the rest of the code to be written
  # end


end