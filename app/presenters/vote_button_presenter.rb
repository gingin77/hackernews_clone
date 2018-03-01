class VoteButtonPresenter < ApplicationPresenter
  presents :parent

  def vote
    @vote ||= Vote.find_by(user_id: h.current_user, voteable_id: parent)
  end

  def up
    if vote&.up_vote?
      up_icon
    elsif vote&.down_vote? || vote.blank?
      h.render partial: "shared/vote/up", locals: { parent: parent }
    end
  end

  def down
    if vote&.down_vote?
      down_icon
    elsif vote&.up_vote?  || vote.blank?
      h.render partial: "shared/vote/down", locals: { parent: parent }
    end
  end

  def cancel
    if h.user_signed_in? && vote&.present?
      h.render partial: "shared/vote/cancel", locals: { vote: vote }
    else
      cancel_icon
    end
  end

  def up_icon
    h.content_tag :i, "", class: "fa fa-chevron-circle-up not-clickable"
  end

  def down_icon
    h.content_tag :i, "", class: "fa fa-chevron-circle-down not-clickable"
  end

  def cancel_icon
    h.content_tag :i, "", class: "fa fa-times-circle not-clickable"
  end

  def static_icons
    h.render partial: "shared/vote/static_icons"
  end
end
