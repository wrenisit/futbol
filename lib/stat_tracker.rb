require_relative 'game_teams_collection'
require_relative 'team_collection'
require_relative 'game_collection'
require_relative '../modules/game_module'
require 'csv'

class StatTracker
    include GameModule
    attr_reader :game_collect

    def self.from_csv(locations)
      StatTracker.new(locations)
    end

    def initialize(locations)
      @game_path = locations[:games]
      @team_path = locations[:teams]
      @game_teams_path = locations[:game_teams]
    end

    def game
      @game_collect = GameCollection.new(@game_path)
    end

    def count_of_games_by_season
      @game_collect.count_of_games_by_season
    end

    def game_teams
      GameTeamsCollection.new(@game_teams_path)
    end

    def team
      TeamCollection.new(@team_path)
    end
end
