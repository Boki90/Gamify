require "gamify/version"

module Gamify

  def set_points(points)
    @points = points
    update_model_point_balance
  end

  def total_points
    get_points
  end

  def add_points(points)
    @points = total_points + points
    update_model_point_balance
    level
  end

  def percent_level_complete
    base_points = rounded_maximum_points_for_level(level - 1)
    earned_in_level = @points - base_points
    total_in_level = rounded_maximum_points_for_level(level) - base_points
    ((earned_in_level.to_f / total_in_level) * 100).to_i
  end

  def points_to_next_level
    rounded_maximum_points_for_level(level) - @points
  end

  #Iterative approach is used so that the exp points for each
  #level can be rounded.
  def level
    level = 0
    while get_points >= rounded_maximum_points_for_level(level)
      level += 1
    end
    level
  end

  private

    def get_points
      if @points.nil?
        @points = self.respond_to?('points') ? self.points : 0
      end
      @points = 0 if @points.nil?
      @points
    end

    def update_model_point_balance
      if self.respond_to?('points')
        self.update_attributes(points: total_points)
      end
    end

    def rounded_maximum_points_for_level(level)
      round_to_nearest_hundred(maximum_points_for_level(level).to_i)
    end

    def maximum_points_for_level(level)
      if level < 11
        40 * ( level**2 ) + 360 * level
      elsif level < 27
        -0.4*(level**3) + 40.4*(level**2) + 396 * level
      else
        (65*(level**2) - (165*level) - 6750) * 0.82
      end
    end

    def round_to_nearest_hundred(n)
      (n + 50) / 100 * 100
    end

end
