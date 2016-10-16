class Item < ActiveRecord::Base
  validates :name, presence: true
  validates :rank, numericality: { greater_than_or_equal_to: 0 }
  validates :kind, presence: true

  validate :type_must_be_limited

  def type_must_be_limited
    if kind != "Movie" && kind != "Book" && kind != "Album"
      errors.add(:kind, "Must be a Book, Movie or Album")
    end
  end

  def upvote
    self.rank += 1
    self.save
  end

  def equivalent? (other)
    return false if other.class != Item
    return name == other.name && kind == other.kind && rank == other.rank && author == other.author && description == other.description
  end

end
