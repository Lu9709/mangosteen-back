require 'rails_helper'

RSpec.describe User, type: :model do
  it 'have email' do
    user = User.new email: 'baizhe@qq.com'
    expect(user.email).to eq('baizhe@qq.com')
  end
end
