require 'spec_helper'
require_relative '../../../../apps/web/views/api_games/show'

describe Web::Views::ApiGames::Show do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Lotus::View::Template.new('apps/web/templates/api_games/show.html.erb') }
  let(:view)      { Web::Views::ApiGames::Show.new(template, exposures) }
  let(:rendered)  { view.render }

  it "exposes #foo" do
    expect(view.foo).to eq exposures.fetch(:foo)
  end
end
