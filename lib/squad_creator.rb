require 'json'
require_relative './team_manager'
#
# Creates rugby squads from given JSON file containing
# a list of athletes and squads. This is the entry point
# for creating squads.
#
class SquadCreator
  # Initializes with list of athletes and squads.
  #
  # @param athletes_file_path [String] path of the file
  def initialize(athletes_file_path)
    @athletes_file_path = athletes_file_path
  end

  # Creates an new squad out of the athlete list
  # from given JSON file.
  # @param squad_id [Integer] Squad ID
  # @return [Hash]
  def create(squad_id)
    {
      id: squad_id,
      squad: "Squad #{squad_id}",
      athletes: team_manager.create_new_team
    }
  end

  # Creates an new squad out of the athlete list
  # from given JSON file and prints the Squad formation
  # in the terminal.
  # @param squad_id [Integer] Squad ID
  def create_and_output_as_string(squad_id)
    squad = create(squad_id)
    puts squad_as_string(squad)
  end

  private

  def squad_as_string(squad)
    output = "Squad ID: #{squad[:id]} \n" +
      "Squad Name: #{squad[:squad]} \n" +
      "Athletes: \n" + athletes_as_string(squad[:athletes])
  end

  def athletes_as_string(athletes)
    athletes.map do |athlete|
      " - #{athlete[:name]} - #{athlete[:position]}"
    end.join("\n")
  end

  def team_manager
    @team_manager ||= ::TeamManager.new(file_content_hash['athletes'])
  end

  def file_content_hash
    begin
      @file_content_hash ||= JSON.parse(File.read(@athletes_file_path))
    rescue
      raise "Error opening JSON file."
    end
  end
end
