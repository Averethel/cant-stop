require 'spec_helper'
require_relative '../../../../apps/web/controllers/games/show'

describe Web::Controllers::Games::Show do
  let(:action) { Web::Controllers::Games::Show.new }
  let(:params) { Hash[] }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
