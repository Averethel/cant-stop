require 'spec_helper'
require_relative '../../../../apps/web/controllers/games/create'

describe Web::Controllers::Games::Create do
  let(:action) { Web::Controllers::Games::Create.new }
  let(:params) { Hash[] }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
