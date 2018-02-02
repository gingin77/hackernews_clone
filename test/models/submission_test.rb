require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  setup do
    @sub_title_url = submissions(:one)
    @sub_text = submissions(:two)
    @sub_title_text = submissions(:three)
    @sub_url_text = submissions(:four)
    @sub_title = submissions(:five)
    @sub_url = submissions(:six)
    @sub_blank = submissions(:seven)
  end

  test "submission with url and title is valid" do
    assert @sub_title_url.valid?
  end

  test "submission with text is valid" do
    assert @sub_text.valid?
  end

  test "submission with title and text is invalid" do
    assert_not @sub_title_text.valid?
  end

  test "submission with url and text is invalid" do
    assert_not @sub_url_text.valid?
  end

  test "submission with title only invalid" do
    assert_not @sub_title.valid?
  end

  test "submission with url only invalid" do
    assert_not @sub_url.valid?
  end

  test "submission without text, title or url is invalid" do
    assert_not @sub_blank.valid?
  end
end
