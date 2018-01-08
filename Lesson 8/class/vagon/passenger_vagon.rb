class PassengerVagon < Vagon
  def initialize(places)
    super(:passenger)
    self.all_places = places
    self.free_places = places
  end

  def take_place(num)
    self.free_places -= num if self.all_places > 0
  end

  def get_free_places
    self.free_places
  end

  def get_not_free_places
    self.all_places - self.free_places
  end

  protected
    attr_accessor :all_places, :free_places
end