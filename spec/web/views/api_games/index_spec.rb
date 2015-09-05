require 'spec_helper'
require_relative '../../../../apps/web/views/api_games/index'

describe Web::Views::ApiGames::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Lotus::View::Template.new('apps/web/templates/api_games/index.html.erb') }
  let(:view)      { Web::Views::ApiGames::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it "exposes #foo" do
    expect(view.foo).to eq exposures.fetch(:foo)
  end
end
