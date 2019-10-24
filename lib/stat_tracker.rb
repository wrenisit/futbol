require_relative 'game_teams_collection'
require_relative 'team_collection'
require_relative 'game_collection'

require 'csv'

class StatTracker

    def self.from_csv(locations)
      StatTracker.new(locations)
    end

    def initialize(locations)
      @game_path = locations[:games]
      @team_path = locations[:teams]
      @game_teams_path = locations[:game_teams]
    end

    def game
      GameCollection.new(@game_path)
    end

    def game_teams
      GameTeamsCollection.new(@game_teams_path)
    end

    def team
      TeamCollection.new(@team_path)
    end
end
