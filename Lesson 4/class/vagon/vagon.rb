class Vagon
  attr_reader :type
  def initialize(type)
    @type = type
  end
end

require_relative 'cargo_vagon'
require_relative 'passenger_vagon'