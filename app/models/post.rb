class Post < ApplicationRecord
  include Discard::Model
  self.discard_column = :deleted_at
  default_scope -> { where(deleted_at: nil, type: nil) }
  acts_as_favoritable

  has_one_attached :media
  belongs_to :user
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  # has_many :favorites, as: :favoritable

  scope :published, -> { where(status: :published) }
  scope :drafted, -> { where(status: :draft) }

  enum status: {
    draft: 'draft',
    published: 'published'
  }
end
