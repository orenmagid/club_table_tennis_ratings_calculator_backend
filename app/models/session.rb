class Session < ApplicationRecord
  include Calculable
  include CalculableWithOldMethod

  has_many :matches, -> { order(created_at: :asc) }
  has_many :ratings

  default_scope { order(date: :asc) }
  scope :from_most_recent, -> { reorder(date: :desc) }

  def log_ratings()
    self.ratings.sort { |a, b| a.value <=> b.value }.each do |rating|
      player = Player.find { |p| p.id == rating.player_id }
      puts("#{player.name}: #{rating.value} #{rating.adjustment ? "(adjusted: " + rating.adjustment.to_s + ")" : nil}")
    end
  end
end
