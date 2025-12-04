module SubscriptionsHelper
  def subscription_period_end_action(subscription)
    if subscription.canceled?
      subscription.cancel_at.past? ? "Ended" : "Ends"
    else
      "Renews"
    end
  end
end
