class Submission < ApplicationRecord
  belongs_to :user

  has_many :comments, class_name: "Submission", foreign_key: :post_id
  belongs_to :post, class_name: "Submission", optional: true

  validates :user, presence: true
  validates :title, :url, presence: true, if: :url_submission?

  validate :can_only_be_one_submission_type
  validate :at_least_one_field_present

  private

    def url_submission?
      url.present? || title.present?
    end

    def text_submission?
      text.present?
    end

    def can_only_be_one_submission_type
      if text_submission? && url_submission?
        errors.add(:base, "You may submit either text content OR a url link, NOT both")
      end
    end

    def at_least_one_field_present
      if text.blank? && url.blank? && title.blank?
        errors.add(:base, "You must submit text content OR a url link")
      end
    end
end
