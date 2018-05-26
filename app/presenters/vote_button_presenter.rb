class VoteButtonPresenter < ApplicationPresenter
  presents :parent
  delegate :id, to: :parent

  def vote
    @vote ||= parent.votes.find_or_initialize_by(user_id: h.current_user.id)
  end

  def buttons
    return static_icons unless h.user_signed_in?
    case vote&.value
    when 1
      up_vote_sequence
    when -1
      down_vote_sequence
    else
      new_vote_sequence
    end
  end

  def static_icons
    render_partial("static_icons", nil)
  end

  def new_vote_sequence
    active_up_button + active_down_button + delete_icon
  end

  def up_vote_sequence
    up_icon + active_down_button + active_delete_button
  end

  def down_vote_sequence
    active_up_button + down_icon + active_delete_button
  end

  def active_up_button
    render_partial("up", { vote: vote })
  end

  def active_down_button
    render_partial("down", { vote: vote })
  end

  def active_delete_button
    render_partial("delete", { vote: vote })
  end

  def up_icon
    icon_temp("chevron-circle-up")
  end

  def down_icon
    icon_temp("chevron-circle-down")
  end

  def delete_icon
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
