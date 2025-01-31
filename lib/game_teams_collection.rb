require 'csv'
require_relative 'game_teams'

class GameTeamsCollection
  attr_reader :game_teams_path, :game_teams_collection_instances, :team_best

  def initialize(game_teams_path)
    @game_teams_path = game_teams_path
    @game_teams_collection_instances = all_game_teams
  end

  def all_game_teams
    csv = CSV.read("#{@game_teams_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
       GameTeams.new(row)
    end
  end

  def winningest_team_id
    team_percents = {}
    team_stat_maker.each do |team|
      wins = team[1][:away_wins] + team[1][:home_wins]
      if wins > 0
        losses = team[1][:away_losses] + team[1][:home_losses] + team[1][:away_ties] + team[1][:home_ties]
        percent = (wins + losses) / (wins).to_f
        team_percents[team[0]] = percent.round(3)
      else
        team_percents[team[0]] = 0
      end
    end
    team_percents.min_by{|k,v| v}[0].to_s
  end

  def game_stat_maker(team_id)
    team_data = {
      away_wins: 0,
      away_losses: 0,
      home_wins: 0,
      home_losses: 0,
      away_ties: 0,
      home_ties: 0
    }
    @game_teams_collection_instances.each do |game|
      if game.team_id == team_id
        if game.result == "WIN" && game.hoa == "away"
          team_data[:away_wins] += 1
        elsif game.result == "LOSS" && game.hoa == "away"
          team_data[:away_losses] += 1
        elsif game.result == "TIE" && game.hoa == "away"
          team_data[:away_ties] += 1
        elsif game.result == "WIN" && game.hoa == "home"
          team_data[:home_wins] += 1
        elsif game.result == "LOSS" && game.hoa == "home"
          team_data[:home_losses] += 1
        elsif game.result == "TIE" && game.hoa == "home"
          team_data[:home_ties] += 1
        end
      end
    end
    team_data
  end

  def team_id_maker
    @team_list = []
    @game_teams_collection_instances.map do |game|
      @team_list << game.team_id
    end
    @team_list = @team_list.uniq
  end

  def team_stat_maker
    @team_accumulator = {}
    team_id_maker.each do |team_id|
      @team_accumulator[team_id] = game_stat_maker(team_id)
    end
    @team_accumulator
  end

  def worst_fans
    worst_fans_teams = []
    team_stat_maker

    @team_accumulator.map do |team|

      if team[1][:away_wins] > team[1][:home_wins]
        worst_fans_teams << team[0]
      end
    end
    worst_fans_teams
  end

  def most_goals_scored(value)
    most_goals = @game_teams_collection_instances.find_all do |team|
      team.team_id == value.to_i
    end
    most_goals.max_by { |team| team.goals }.goals
  end

  def fewest_goals_scored(value)
    most_goals = @game_teams_collection_instances.find_all do |team|
      team.team_id == value.to_i
    end
    most_goals.min_by { |team| team.goals }.goals
  end

  def best_team_id
    @team_best = {}
    team_stat_maker.each do |team|
      home_totals = (team[1][:home_wins] + team[1][:home_losses] + team[1][:home_ties])
      away_totals = (team[1][:away_wins] + team[1][:away_losses] + team[1][:away_ties])
      if home_totals != 0 && away_totals != 0
        home_percent = home_totals / team[1][:home_wins].to_f.round(2)
        away_percent = away_totals / team[1][:away_wins].to_f.round(2)
          if home_percent > away_percent
            team_best[team] = (home_percent - away_percent)
          end
      end
      @team_best.min_by {|k,v| v}
    end
    @team_best.to_a.flatten[0].to_s
  end
end
