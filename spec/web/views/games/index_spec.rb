require 'spec_helper'
require_relative '../../../../apps/web/views/games/index'

describe Web::Views::Games::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Lotus::View::Template.new('apps/web/templates/games/index.html.erb') }
  let(:view)      { Web::Views::Games::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it "exposes #foo" do
    expect(view.foo).to eq exposures.fetch(:foo)
  end
end
