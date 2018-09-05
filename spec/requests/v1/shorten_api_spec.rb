# frozen_string_literal: true
require 'rails_helper'

describe 'shorten url', type: :request do
  before(:all) { host! 'test.host' }

  before do
    user = FactoryGirl.create(:user)
  end
  
  let(:params) do 
    {
      user: 'vishnu@test.com',
      password: '1234',
      url: 'http://google.com'
    }
  end
  
  it 'should pass through API and return success' do
    post '/api/v1/shorten', params
    expect(response.status).to eq (200)
  end
end
