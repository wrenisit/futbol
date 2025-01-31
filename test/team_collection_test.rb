require './test/test_helper'
require 'csv'
require './lib/team'
require './lib/stat_tracker'
require './lib/team_collection'
require './lib/game_collection'
require './lib/game'

class TeamCollectionTest < MiniTest::Test

  def setup
    @team_instance = TeamCollection.new('./dummy_data/dummy_teams.csv')
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_instance
  end

  def test_it_initalizes
    assert_equal './dummy_data/dummy_teams.csv', @team_instance.team_path
    assert_equal 16, @team_instance.team_instances.size
  end

  def test_all_teams
    assert_equal "Atlanta United" , @team_instance.all_teams.first.teamname
  end

  def test_the_count_of_teams
    assert_equal 16, @team_instance.count_of_teams
  end

  def test_winningest_team_method
    assert_equal "FC Dallas", @team_instance.winningest_team("6")
    assert_equal "LA Galaxy", @team_instance.winningest_team("17")
  end

  def test_highest_scoring_visitor
    game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
    assert_equal "FC Dallas", @team_instance.highest_scoring_visitor(game_collection.highest_visitor_id)
  end

  def test_highest_scoring_home_team
    game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
    assert_equal "DC United", @team_instance.highest_scoring_home_team(game_collection.highest_home_id)
  end

  def test_lowest_scoring_visitor
    game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
    assert_equal "Toronto FC", @team_instance.lowest_scoring_visitor(game_collection.lowest_visitor_id)
  end

  def test_lowest_scoring_home_team
    game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
    assert_equal "Sporting Kansas City", @team_instance.lowest_scoring_home_team(game_collection.lowest_home_id)
  end

  def test_name_finder_method
    assert_equal "Chicago Fire", @team_instance.name_finder("4")
    assert_equal "New York Red Bulls", @team_instance.name_finder("8")
  end

  def test_worst_fans
    assert_equal ["Sporting Kansas City"], @team_instance.worst_fans(["5"])
    assert_equal ["LA Galaxy", "Houston Dynamo"], @team_instance.worst_fans(["17", "3"])
  end

  def test_team_info
    expected = {"team_id"=> "20", "franchise_id"=> "21", "team_name"=> "Toronto FC", "abbreviation"=> "TOR", "link"=> "/api/v1/teams/20"}
    assert_equal expected, @team_instance.team_info("20")
  end

  def test_best_fans
    assert_equal "Sporting Kansas City", @team_instance.best_fans("5")
  end
end
