class Submission < ApplicationRecord
  # belongs_to :user

  validates :title, presence: true, if: ->(submission){submission.url.present?}
  validates :url, presence: true, if: ->(submission){submission.title.present?}

  # validates_numericality_of :title, :url, allow_nil: true
  # validates_numericality_of :text, allow_nil: true
  #
  # validate :title_and_url_together
  # validate :text_or_title_and_url

  private

    # def title_and_url_together
    #   if !title.blank?
    #
    #   end
    # end
    #
    # def text_or_title_and_url
    #   unless
end
