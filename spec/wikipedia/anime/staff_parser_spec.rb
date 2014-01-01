# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::StaffParser do
  before do
    json = File.read(File.expand_path(File.dirname(__FILE__) + '../../../fixtures/k_on.json'))
    allow(Wikipedia).to receive(:find) { Wikipedia::Page.new(json) }
  end

  describe '#execute' do
    before do
      @page = Wikipedia.find('けいおん!')
      @parser = Wikipedia::Anime::StaffParser.new(@page).execute
    end
    it { expect(@parser.staffs.first.position).to eq('監督') }
    it { expect(@parser.staffs.first.name).to eq('山田尚子') }
    it { expect(@parser.staffs.last.position).to eq('音楽') }
    it { expect(@parser.staffs.last.name).to eq('百石元（F.M.F）') }

    context '役職はあるが担当者名がない場合' do
      before do
        @page.stub(:content).and_return("|監督=\n|脚本=\n")
        @parser = Wikipedia::Anime::StaffParser.new(@page).execute
      end
      it { expect(@parser.staffs.count).to eq(0) }
    end

  end
end
