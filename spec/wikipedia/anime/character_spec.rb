# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::Character do
  before do
    @character = Wikipedia::Anime::Character.new(name: '秋山澪',
                                                 kana: 'あきやま みお',
                                                 seiyu: '日笠陽子')
  end

  describe '#values' do
    it { expect(@character.values).to eq(['秋山澪', 'あきやま みお', '日笠陽子']) }
  end
end
