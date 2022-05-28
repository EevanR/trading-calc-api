# frozen_string_literal: true

module StripeTestHelper
  def stripe_event_signature(payload)
    time = Time.now
    secret = "whsec_99cee02f9b8aaedf6d0cda04cf20b137537239806b9979a9a1159bae0d1943d0"
    signature = Stripe::Webhook::Signature.compute_signature(time, payload, secret)
    Stripe::Webhook::Signature.generate_header(
      time,
      signature,
      scheme: Stripe::Webhook::Signature::EXPECTED_SCHEME
    )
  end
end