require './lib/team'
require_relative 'test_helper'

class TeamTest < MiniTest::Test
  def test_it_exists
    team = Team.new({team_id: "1", franchiseid: "23", teamname: "Atlanta United", abbreviation: "ATL", stadium: "Mercedes-Benz Stadium",link: "/api/v1/teams/1"})
    assert_instance_of Team, team
  end

  def test_initialization_attributes
    team = Team.new({team_id: "1", franchiseid: "23", teamname: "Atlanta United", abbreviation: "ATL", stadium: "Mercedes-Benz Stadium",link: "/api/v1/teams/1"})
    assert_equal "1", team.team_id
    assert_equal "23", team.franchiseid
    assert_equal "Atlanta United", team.teamname
    assert_equal "ATL", team.abbreviation
    assert_equal "Mercedes-Benz Stadium", team.stadium
    assert_equal "/api/v1/teams/1", team.link
  end
end
