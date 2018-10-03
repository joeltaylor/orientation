class ArticleEndorsement < ApplicationRecord
  include Dateable

  belongs_to :article, counter_cache: :endorsements_count
  belongs_to :user

  after_create :send_endorsement

  validates :user_id, uniqueness: {
    scope: :article_id, message: "has already endorsed this article"
  }

  def send_endorsement
    ArticleEndorsementWorker.perform_async(id)
  end

  def endorser
    user
  end
end
