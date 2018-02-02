require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(name: "text", email: "test@email.com", password: "secret")
  end

  test "submission requires a user_id" do
    sub_w_user = Submission.new(user: @user, text: 'text')
    sub_no_user = Submission.new(user: nil, text: 'text')
    assert sub_w_user.valid?
    assert_not sub_no_user.valid?
  end

  test "submission with url and title is valid" do
    sub = Submission.new(user: @user, url: 'text', title: 'text')
    assert sub.valid?
  end

  test "submission with text is valid" do
    sub = Submission.new(user: @user, text: 'text')
    assert sub.valid?
  end

  test "submission with title and text is invalid" do
    sub = Submission.new(user_id: 1, title: 'text', text: 'text')
    assert_not sub.valid?
    assert_includes sub.errors[:base], "You may submit either text content OR a url link, NOT both"
  end

  test "submission with url and text is invalid" do
    sub = Submission.new(user_id: 1, url: 'text', text: 'text')
    assert_not sub.valid?
    assert_includes sub.errors[:base], "You may submit either text content OR a url link, NOT both"
  end

  test "submission with title only invalid" do
    sub = Submission.new(user_id: 1, title: 'text')
    assert_not sub.valid?
    assert_includes sub.errors[:url], "can't be blank"
  end

  test "submission with url only invalid" do
    sub = Submission.new(user_id: 1, url: 'text')
    assert_not sub.valid?
    assert_includes sub.errors[:title], "can't be blank"
  end

  test "submission without text, title or url is invalid" do
    sub = Submission.new(user_id: 1)
    assert_not sub.valid?
    assert_includes sub.errors[:base], "You must submit either text content OR a url link with a title"
  end
end
