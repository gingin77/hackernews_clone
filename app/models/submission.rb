class Submission < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :title, :url, presence: true, if: :url_submission?

  validate :text_submission
  validate :at_least_one_field_present

  private

    def url_submission?
      url.present? || title.present?
    end

    def text_submission
      if text.present? && (url.present? || title.present?)
        errors.add(:base, "You may submit either text content OR a url link, NOT both")
      end
    end

    def at_least_one_field_present
      if text.blank? && url.blank? && title.blank?
        errors.add(:base, "You must submit text content OR a url link")
      end
    end
end
