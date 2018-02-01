require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  setup do
    @sub_tit_url = submissions(:one)
    @sub_text = submissions(:two)
    @sub_tit_text = submissions(:three)
    @sub_tit = submissions(:four)
    @sub_url = submissions(:five)
  end

  test "submission with url and title is valid" do
    assert @sub_tit_url.valid?
  end

  test "submission with text is valid" do
    assert @sub_text.valid?
  end

  test "submission with title and text is invalid" do
    assert_not @sub_tit_text.valid?
  end

  test "submission with title only invalid" do
    assert_not @sub_tit_text.valid?
  end

  test "submission with url only invalid" do
    assert_not @sub_url.valid?
  end
end
