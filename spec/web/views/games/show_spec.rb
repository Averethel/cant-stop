require 'spec_helper'
require_relative '../../../../apps/web/views/games/show'

describe Web::Views::Games::Show do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Lotus::View::Template.new('apps/web/templates/games/show.html.erb') }
  let(:view)      { Web::Views::Games::Show.new(template, exposures) }
  let(:rendered)  { view.render }

  it "exposes #foo" do
    expect(view.foo).to eq exposures.fetch(:foo)
  end
end
