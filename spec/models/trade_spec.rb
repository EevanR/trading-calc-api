require 'rails_helper'

RSpec.describe Trade, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :ticker }
    it { is_expected.to have_db_column :entry }
    it { is_expected.to have_db_column :shares }
    it { is_expected.to have_db_column :stop }
    it { is_expected.to have_db_column :setup }
    it { is_expected.to have_db_column :date }
    it { is_expected.to have_db_column :profit }
    it { is_expected.to have_db_column :trade_id }
  end

  it 'should have valid Factory' do
    expect(create(:trade)).to be_valid
  end
end
