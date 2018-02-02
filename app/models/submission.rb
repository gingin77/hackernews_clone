class Submission < ApplicationRecord
  belongs_to :user

  validates :title, presence: true,
            if: :url_present? && :text_absent?

  validates :url, presence: true,
            if: :title_present? && :text_absent?

  validates :text, presence: true,
            unless: Proc.new { |a| a.url.present? || a.title.present?}

  validate :title_and_text_not_together
  validate :url_and_text_not_together

  private

    def url_present?
      url.present?
    end

    def title_present?
      title.present?
    end

    def text_absent?
      text.blank?
    end

    def title_and_text_not_together
      if text.present? && title.present?
        errors.add(:base, "You may submit either text content OR a link with a title, NOT both")
      end
    end

    def url_and_text_not_together
      if url.present? && text.present?
        errors.add(:base, "You may submit either text content OR a link with a title, NOT both")
      end
    end
end
