require 'csv'
require_relative 'game'
require_relative 'stat_tracker'

class GameCollection
  attr_reader :game_instances

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @game_instances = all_stats
  end

  def all_stats
    game_objects = []
    csv = CSV.read("#{@csv_file_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      game_objects <<  Game.new(row)
    end
    game_objects
  end

# Returns an array that contains every game score both winners and losers added together
  def total_scores
    total_scores_array = []
      @game_instances.each do |game|
        total_goals = game.away_goals + game.home_goals
        total_scores_array << total_goals
      end
    total_scores_array
  end

end
