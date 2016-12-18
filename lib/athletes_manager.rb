#
# Manages athletes.
#
class AthletesManager
  # Initializer that takes a list of athletes.
  # @param athletes [Array] list of athletes
  def initialize(athletes)
    @athletes = athletes || []
  end

  # Returns all non-injured athletes by position.
  # @param position [String] position of the player
  # @return [Array]
  def players_by_position(position)
    non_injured.select{ |athlete| athlete['position'] == position }
  end

  private

  def non_injured
    @non_injured ||= @athletes.reject{ |athlete| athlete['is_injured'] }
  end
end
