# frozen_string_literal: true

require_relative '../instance_counter'

# class Station
class Station
  include InstanceCounter
  @@stations = []

  STATION_NAME_FORMAT = /^\w+\s?\w+$/.freeze

  class << self
    def all
      @@stations
    end

    def find(station_name)
      @@stations.select { |station| station.name == station_name }.last
    end
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def arrival_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def return_trains_by_type(type)
    trains.find_all { |train| train.type == type }
  end

  def show_trains
    trains.each { |train| puts "#{train.number}  #{train.type}" }
  end

  protected

  def validate!
    raise 'Invalid station name!' if name !~ STATION_NAME_FORMAT
  end
end
