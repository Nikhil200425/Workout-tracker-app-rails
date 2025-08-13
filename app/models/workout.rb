class Workout < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  validates :title, :description, :start_time, :end_time, presence: true
  validate :end_after_start
  validate :no_overlapping_workouts
  validate :min_duration
  validate :min_gap

  pg_search_scope :search_by_title_and_description,
    against: [:title, :description],
    using: {
      tsearch: { prefix: true, any_word: true}
    }
    
  def status
    Time.current < end_time ? "Completed" : "Ongoing"
  end

  private
  def min_duration
    if (start_time && end_time && ((end_time - start_time)/60)) < 15
      errors.add(:base, "Workout minimum duration is 15 min")
    end
  end

  def min_gap
    return unless start_time && end_time
    nearby = Workout.where(user_id: user_id).where.not(id: id)
    nearby.each do |w|
      gap_before = ((start_time) - w.end_time)/60.abs
      gap_after = (w.start_time - (end_time))/60.abs
      if gap_before < 2 && gap_after < 2
        errors.add(:base, "Maintain atleast 2 min gap between workout")
      end
    end
  end

  def end_after_start
    return if start_time.blank? || end_time.blank?
    if end_time <= start_time
      errors.add(:base, "Enter valid end time")
    end
  end

  def no_overlapping_workouts
    return if start_time.blank? || end_time.blank?
    overlap = Workout.where(user_id: user_id).where("(start_time < ? AND end_time > ?)", end_time, start_time)
    if overlap.exists?
      errors.add(:base, "Overlapping workout")
    end
  end
end
