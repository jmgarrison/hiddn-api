shared_examples 'an authenticated controller' do
  it 'is authenticated' do
    expect(controller.class.ancestors.include?(Authenticated)).to eq(true)
  end
end

shared_context 'authenticated' do

  let(:user) { FactoryGirl.create(:user, :with_auth_token) }
  let(:auth_token) { user.auth_tokens.first }

  before(:each) do
    request.env['HTTP_AUTHORIZATION'] = "Token token=#{auth_token.value}"
  end

end
