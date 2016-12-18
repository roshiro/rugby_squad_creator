require_relative './athletes_manager'

#
# Contains methods related to Team.
#
class TeamManager
  # Initializer
  # @param athletes [Array] list of athletes
  def initialize(athletes)
    @athletes = athletes
  end

  # Creates a new rugby union team.
  # @return [Array]
  def create_new_team
    new_team = build_union_team
    new_team.map do |member|
      {
        name: member['name'],
        position: member['position']
      }
    end
  end

  private

  def build_union_team
    formation = [
      *manager.players_by_position('prop'         ).sample(2),
      *manager.players_by_position('hooker'       ).sample(1),
      *manager.players_by_position('lock'         ).sample(2),
      *manager.players_by_position('flanker'      ).sample(2),
      *manager.players_by_position('number-eight' ).sample(1),
      *manager.players_by_position('scrum-half'   ).sample(1),
      *manager.players_by_position('out-half'     ).sample(1),
      *manager.players_by_position('centre'       ).sample(2),
      *manager.players_by_position('winger'       ).sample(2),
      *manager.players_by_position('full-back'    ).sample(1)
    ]
    if formation.length == 15
      formation
    else
      raise "It was not possible to build a rugby union team."
    end
  end

  def manager
    raise "Athletes list needs to be informed" if @athletes.nil?
    @manager ||= ::AthletesManager.new(@athletes)
  end

end
