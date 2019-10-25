require 'csv'
require_relative 'game_teams'
require_relative 'stat_tracker'

class GameTeamsCollection
  attr_reader :game_teams_instances

  def initialize(game_teams_path)
    @game_teams_path = game_teams_path
    @game_teams_instances = all_game_teams
  end

  def all_game_teams
    csv = CSV.read("#{@game_teams_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      GameTeams.new(row)
    end
  end
end
