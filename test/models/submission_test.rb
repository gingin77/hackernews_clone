require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  test "submission requires a user_id" do
    sub_w_user = build(:text_submission)
    sub_no_user = build(:text_submission, user: nil)
    assert sub_w_user.valid?
    assert_not sub_no_user.valid?
  end

  test "submission with url and title is valid" do
    sub = build(:url_submission)
    assert sub.valid?
  end

  test "submission with text is valid" do
    sub = build(:text_submission)
    assert sub.valid?
  end

  test "submission with title and text is invalid" do
    sub = build(:text_submission, title: "A title")
    assert_not sub.valid?
    assert_includes sub.errors[:base], "You may submit either text content OR a url link, NOT both"
  end

  test "submission with url and text is invalid" do
    sub = build(:text_submission, url: "https://www.nytimes.com/2018/02/02/science/plants-consciousness-anesthesia")
    assert_not sub.valid?
    assert_includes sub.errors[:base], "You may submit either text content OR a url link, NOT both"
  end

  test "submission with title only invalid" do
    sub = build(:url_submission, url: nil)
    assert_not sub.valid?
    assert_includes sub.errors[:url], "can't be blank"
  end

  test "submission with url only invalid" do
    sub = build(:url_submission, title: nil)
    assert_not sub.valid?
    assert_includes sub.errors[:title], "can't be blank"
  end

  test "submission without text, title or url is invalid" do
    sub = build(:text_submission, text: nil)
    assert_not sub.valid?
    assert_includes sub.errors[:base], "You must submit text content OR a url link"
  end
end
