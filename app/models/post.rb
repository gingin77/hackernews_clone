class Post < ApplicationRecord
  belongs_to :submitter,
             class_name:  :User,
             foreign_key: :user_id,
             dependent:   :destroy

  has_many :comments,
           as: :commentable

  has_many :votes,
           as: :voteable

  validates :title, :url,
            presence: true,
            if:       :url_post?

  validates :title, :url,
            absence: true,
            if:      :text_post?

  validate :at_least_one_field_present
  validate :a_post_can_only_be_one_type

  def url_post?
    url.present? || title.present?
  end

  def text_post?
    text.present?
  end

  def users_vote(user)
    self.votes.find_by(user_id: user.id)
  end

  private

  def a_post_can_only_be_one_type
    if text_post? && url_post?
      errors.add(:base, "You may submit either text content OR a url link, NOT both")
    end
  end

  def at_least_one_field_present
    if text.blank? && url.blank? && title.blank?
      errors.add(:base, "You must submit a url link OR text content")
    end
  end
end
