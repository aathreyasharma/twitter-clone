class Comment < Post
  include Discard::Model
  self.discard_column = :deleted_at
  self.default_scopes = []
  default_scope -> { kept }
  acts_as_favoritable

  belongs_to :post, foreign_key: :parent_id
  belongs_to :user
  # has_many :favorites, as: :favoritable

  validates_presence_of :parent_id
  before_save :confirm

  def confirm
    self.status = 'published'
  end

end
