require 'rails_helper'

RSpec.describe StripeSession, type: :model do
  describe 'Stripe Sessions table' do
    it { is_expected.to have_db_column :session_id }
    it { is_expected.to have_db_column :customer_id }
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :status}
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:stripe_session)).to be_valid
    end
  end
end
