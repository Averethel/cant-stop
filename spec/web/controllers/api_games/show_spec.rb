require 'spec_helper'
require_relative '../../../../apps/web/controllers/api_games/show'

describe Web::Controllers::ApiGames::Show do
  let(:action) { Web::Controllers::ApiGames::Show.new }
  let(:params) { Hash[] }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
