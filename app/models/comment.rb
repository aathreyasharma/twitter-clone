class Comment < Post
  include Discard::Model
  self.discard_column = :deleted_at
  default_scope -> { kept }

  belongs_to :post, foreign_key: :parent_id
  belongs_to :user

  validates_presence_of :parent_id
  before_save :confirm

  def confirm
    self.status = 'published'
  end

end
