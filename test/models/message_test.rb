require "test_helper"

class MessageTest < ActiveSupport::TestCase
  setup do
    Current.session = sessions(:david)
  end

  test "updating bubble counter" do
    assert_difference "bubbles(:logo).comments_count", 1 do
      bubbles(:logo).capture Comment.new(body: "I'd prefer something more rustic")
    end

    assert_difference "bubbles(:logo).comments_count", -1 do
      bubbles(:logo).messages.comments.last.destroy
    end

    assert_no_difference "bubbles(:logo).comments_count" do
      bubbles(:logo).capture EventSummary.new
    end

    assert_no_difference "bubbles(:logo).comments_count" do
      bubbles(:logo).messages.event_summaries.last.destroy
    end
  end
end
