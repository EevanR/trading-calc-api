require 'rails_helper'

RSpec.describe Excel, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :grossData }
    it { is_expected.to have_db_column :netData }
  end

  it 'should have valid Factory' do
    expect(create(:excel)).to be_valid
  end
end
