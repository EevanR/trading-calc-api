require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it 'should have valid Factory' do
    expect(create(:tweet)).to be_valid
  end

  describe 'Tweet table' do
    it { is_expected.to have_db_column :name }
  end
end
