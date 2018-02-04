class Submission < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :title, :url, presence: true, if: :url_submission?

  validate :text_submission
  validate :at_least_one_field_present

  def limit_text
    ary = self.text.chars.shift(80)
    shift_pos = 0
    ary.reverse.each_with_index do |val, index|
      shift_pos = index + 1 if val.blank?
      break if shift_pos > 0
    end
    "#{ary.shift(ary.count - shift_pos).join}..."
  end

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
