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
    it { is_expected.to have_db_column :open }
    it { is_expected.to have_db_column :high }
    it { is_expected.to have_db_column :low }
    it { is_expected.to have_db_column :close }
    it { is_expected.to have_db_column :vol }
    it { is_expected.to have_db_column :prevClose }
    it { is_expected.to have_db_column :volAvg }
    it { is_expected.to have_db_column :mktCap }
    it { is_expected.to have_db_column :company }
    it { is_expected.to have_db_column :industry }
    it { is_expected.to have_db_column :user_id }
  end

  it 'should have valid Factory' do
    expect(create(:trade)).to be_valid
  end
end
