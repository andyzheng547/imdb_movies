require 'spec_helper.rb'

describe ImdbMovies do
  it 'has a version number' do
  	expect(imdbMovies::VERSION).not_to be nil
  end
end