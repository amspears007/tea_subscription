require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'realationships' do
  it { should belong_to :customer }
  it { should belong_to :tea }
  end
end