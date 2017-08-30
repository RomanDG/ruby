class CargoTrain < Train
  def initialize(number, type)
    super
  end

  def add_vagon
    super if type == 'cargo'
  end

  def delete_vagon
    super
  end
end