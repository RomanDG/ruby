class PassengerVagon < Vagon
  attr_accessor :free_places

  def initialize(places)
    super(:passenger)
    @all_places = places
    @free_places = places
  end

  def take_place(num)
    self.free_places -= num if self.all_places > 0
  end

  def get_not_free_places
    self.all_places - self.free_places
  end

  protected
    attr_accessor :all_places
end