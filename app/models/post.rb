class Post < ApplicationRecord
  include Discard::Model
  self.discard_column = :deleted_at
  default_scope -> { kept }

  has_one_attached :media
  belongs_to :user

  scope :published, -> { where(status: :published) }

  enum status: {
    draft: 'draft',
    published: 'published'
  }
end
