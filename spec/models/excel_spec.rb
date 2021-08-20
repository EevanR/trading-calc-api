require 'rails_helper'

RSpec.describe Excel, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :Comm }
    it { is_expected.to have_db_column :Currency }
    it { is_expected.to have_db_column :ECNAdd }
    it { is_expected.to have_db_column :ECNRemove }
    it { is_expected.to have_db_column :ExecTime }
    it { is_expected.to have_db_column :GrossProceeds }
    it { is_expected.to have_db_column :Liq }
    it { is_expected.to have_db_column :NSCC }
    it { is_expected.to have_db_column :Nasdaq }
    it { is_expected.to have_db_column :NetProceeds }
    it { is_expected.to have_db_column :Price }
    it { is_expected.to have_db_column :Qty }
    it { is_expected.to have_db_column :SD }
    it { is_expected.to have_db_column :SEC }
    it { is_expected.to have_db_column :Side }
    it { is_expected.to have_db_column :Symbol }
    it { is_expected.to have_db_column :TD }
  end

  it 'should have valid Factory' do
    expect(create(:excel)).to be_valid
  end
end