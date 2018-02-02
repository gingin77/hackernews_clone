class Submission < ApplicationRecord
  belongs_to :user

  validates :title, presence: true,
            if: :url_present? && :text_absent?

  validates :url, presence: true,
            if: :title_present? && :text_absent?

  validates :text, presence: true,
            unless: :url_present? || :title_present?

  validate :title_and_text_not_together
  validate :url_and_text_not_together

  private
  
    def url_present?
      url != nil
    end

    def title_present?
      title != nil
    end

    def text_absent?
      text == nil
    end

    def title_and_text_not_together
      unless text.blank? ^ title.blank?
        errors.add(:text, "You may submit either text content OR a link with a title, NOT both")
      end
    end

    def url_and_text_not_together
      unless url.blank? ^ text.blank?
        errors.add(:text, "You may submit either text content OR a link with a title, NOT both")
      end
    end

    def title_and_url_together
      if (!title.blank? && text.blank?) || (!url.blank? && text.blank?)
        errors.add(:base, "Missing field")
      end
    end

end
