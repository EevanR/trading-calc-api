# frozen_string_literal: true

module StripeTestHelper
  def stripe_event_signature(payload)
    time = Time.now
    secret = "whsec_5q5HfgFpL6Xmsl4yEke9NFLMy6twRTlB"
    signature = Stripe::Webhook::Signature.compute_signature(time, payload, secret)
    Stripe::Webhook::Signature.generate_header(
      time,
      signature,
      scheme: Stripe::Webhook::Signature::EXPECTED_SCHEME
    )
  end
end