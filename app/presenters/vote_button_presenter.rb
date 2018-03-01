class VoteButtonPresenter < ApplicationPresenter
  presents :parent

  def vote
    @vote ||= Vote.find_by(user_id: h.current_user, voteable_id: parent)
  end

  def buttons
    if !h.user_signed_in?
      static_icons
    else
      if vote.blank?
        new_vote_sequence
      elsif vote&.up_vote?
        up_vote_sequence
      elsif vote&.down_vote?
        down_vote_sequence
      end
    end
  end

  def static_icons
    render_partial("static_icons", nil)
  end

  def new_vote_sequence
    active_up_button + active_down_button + cancel_icon
  end

  def up_vote_sequence
    up_icon + active_down_button + active_delete_button
  end

  def down_vote_sequence
    active_up_button + down_icon + active_delete_button
  end

  def active_up_button
    render_partial("up", { parent: parent })
  end

  def active_down_button
    render_partial("down", { parent: parent })
  end

  def active_delete_button
    render_partial("cancel", { vote: vote })
  end

  def up_icon
    icon_temp("chevron-circle-up")
  end

  def down_icon
    icon_temp("chevron-circle-down")
  end

  def cancel_icon
    icon_temp("times-circle")
  end

  private

  def render_partial(name, locals)
    h.render partial: ["shared/vote", name].join('/'), locals: locals
  end

  def icon_temp(icon_type)
    h.content_tag :i, "", class: "fa fa-#{icon_type} not-clickable"
  end
end
