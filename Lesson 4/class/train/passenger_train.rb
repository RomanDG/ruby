class PassengerTrain < Train
  def initialize(number, type)
    super
  end

  def add_vagon
    super if type == 'passenger'
  end

  def delete_vagon
    super
  end
end