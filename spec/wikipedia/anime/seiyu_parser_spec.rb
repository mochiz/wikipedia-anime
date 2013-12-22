# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::SeiyuParser do
  before do
    json = File.read(File.expand_path(File.dirname(__FILE__) + '../../../fixtures/yoko_hikasa.json'))
    allow(Wikipedia).to receive(:find) { Wikipedia::Page.new(json) }
  end

  describe '#execute' do
    before do
      page = Wikipedia.find('日笠陽子')
      @parser = Wikipedia::Anime::SeiyuParser.new(page).execute
    end
    it { expect(@parser.seiyu.name).to eq('日笠陽子') }
    it { expect(@parser.seiyu.kana).to eq('ひかさ ようこ') }
    it { expect(@parser.seiyu.gender).to eq('女性') }
    it { expect(@parser.seiyu.twitter_username).to eq('hikasayokoSP') }
    it { expect(@parser.seiyu.wikipedia_url).to eq(URI.encode('http://ja.wikipedia.org/wiki/日笠陽子')) }
  end
end
