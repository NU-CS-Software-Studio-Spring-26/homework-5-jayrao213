class Todo < ApplicationRecord
  scope :ordered, -> { order(position: :asc, id: :asc) }

  before_create :set_default_position

  private

  def set_default_position
    self.position = (Todo.maximum(:position) || 0) + 1 if self.position.blank? || self.position == 0
  end
end
