class Submission < ApplicationRecord
  belongs_to :user

  scope :posts, -> { where(post_id: nil) }

  has_many :comments, class_name: "Submission", foreign_key: :post_id
  belongs_to :post, class_name: "Submission", optional: true

  validates :user, presence: true
  validates :title, :url, presence: true, if: :url_post_submission?
  validates :text, presence: { if: :comment_submission?, message: 'The comment you submitted was blank' }

  validate :a_post_submission_can_only_be_one_type
  validate :at_least_one_field_present

  def url_post_submission?
    url.present? || title.present?
  end

  def text_post_submission?
    text.present? && !comment_submission?
  end

  def comment_submission?
    post_id.present?
  end

  private

  def a_post_submission_can_only_be_one_type
    if text_post_submission? && url_post_submission?
      errors.add(:base, "You may submit either text content OR a url link, NOT both")
    end
  end

  def at_least_one_field_present
    if text.blank? && url.blank? && title.blank?
      errors.add(:base, "You must submit a url link OR text content")
    end
  end
end
