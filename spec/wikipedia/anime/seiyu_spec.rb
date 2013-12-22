# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::Seiyu do
  before do
    @seiyu = Wikipedia::Anime::Seiyu.new(name: '日笠陽子',
                                         kana: 'ひかさ ようこ',
                                         gender: '女性')
  end

  describe '#values' do
    it { expect(@seiyu.values).to eq(['日笠陽子', 'ひかさ ようこ', '女性', nil, nil]) }
  end
end
