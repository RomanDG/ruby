class CargoVagon < Vagon
  attr_accessor :free_volume

  def initialize(volume)
    super(:cargo)
    @all_volume = volume
    @free_volume = volume
  end

  def take_volume(vol)
    self.free_volume -= vol if self.all_volume > 0
  end

  def get_not_free_volume
    self.all_volume - self.free_volume
  end

  protected
    attr_accessor :all_volume
end