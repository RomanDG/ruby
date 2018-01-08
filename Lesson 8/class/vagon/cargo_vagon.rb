class CargoVagon < Vagon
  def initialize(volume)
    super(:cargo)
    self.all_volume = volume
    self.free_volume = volume
  end

  def take_volume(vol)
    self.free_volume -= vol if self.all_volume > 0
  end

  def get_free_volume
    self.free_volume
  end

  def get_not_free_volume
    self.all_volume - self.free_volume
  end

  protected
    attr_accessor :all_volume, :free_volume
end