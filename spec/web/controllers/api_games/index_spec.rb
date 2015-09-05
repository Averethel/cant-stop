require 'spec_helper'
require_relative '../../../../apps/web/controllers/api_games/index'

describe Web::Controllers::ApiGames::Index do
  let(:action) { Web::Controllers::ApiGames::Index.new }
  let(:params) { Hash[] }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
