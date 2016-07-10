require 'rails_helper'

RSpec.describe AuthTokenExpiryJob, type: :job do

  describe '#perform' do
    it 'destroys all expired auth tokens' do
      active = FactoryGirl.create_list(:auth_token, 2)
      expired = FactoryGirl.create_list(:auth_token, 2, :expired)

      worker = AuthTokenExpiryJob.new
      expect{ worker.perform }.to change{ AuthToken.count }.by(-2)

      expired.each do |token|
        expect(AuthToken.exists?(token.id)).to eq(false)
      end
    end
  end

end
