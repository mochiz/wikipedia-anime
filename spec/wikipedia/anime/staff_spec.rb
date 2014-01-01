# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::Staff do
  before do
    @staff = Wikipedia::Anime::Staff.new(position: '監督', name: '山田尚子')
  end

  describe '#values' do
    it { expect(@staff.values).to eq(['監督', '山田尚子']) }
  end
end
