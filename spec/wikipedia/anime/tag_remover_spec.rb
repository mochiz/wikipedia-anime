# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::TagRemover do
  it do
    @object = Object.new
    @object.extend(Wikipedia::Anime::TagRemover)
    expect(@object.remove_reference_tag('hogehoge<ref>fugafuga</ref>')).to eq('hogehoge')
  end
end
