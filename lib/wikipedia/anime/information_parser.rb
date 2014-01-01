# -*- coding: utf-8 -*-

require 'wikipedia/anime/tag_remover'

module Wikipedia
  module Anime
    # アニメ関連情報パーサー
    #
    # アニメページのwikiテキストから関連情報をパースします。
    #
    # Examples
    #
    #   page = Wikipedia.find('けいおん!')
    #   parser = Wikipedia::Anime::InformationParser.new(page.content).execute
    #   # => [#<Wikipedia::Anime::Information ..>]
    #
    class InformationParser
      include TagRemover

      # アクセサー
      attr_accessor :informations, :information_texts, :page, :content

      # クラス定数
      KEYS = %w(.*制作 .*製作 放送局 放送開始 話数)
      INFORMATION_SCAN_REGEXP = /^\|(#{KEYS.join('|')})=(.*)/
      NAME_GSUB_REGEXP  = /{{.*\||}}|\[\[.*?\||\[\[|\]\]/

      # Public: 新しいインスタンスを生成します。
      #
      # page - Wikipedia::Page オブジェクト
      def initialize(page)
        @page              = page
        @content           = page.content
        @informations      = {}
        @information_texts = @content.scan(INFORMATION_SCAN_REGEXP)
      end

      # Public: 関連情報をパースします。
      # Wikiページのコンテンツから関連情報をパースします。
      #
      # Wikipedia::Anime::InformationParser オブジェクトを返します。
      def execute
        @information_texts.each do |key, value|
          next if value.empty?
          @informations.merge!(parsed_information(key, value))
        end
        self
      end

      private

      # Internal: 関連情報をパースして返します。
      #
      # key   - String "アニメーション制作"
      # value - String "[[シャフト]]"
      #
      # Hash を返します。
      def parsed_information(key, value)
        { "#{key.strip}" => parsed_value(value) }
      end

      # Internal: 名前を返します。
      #
      # value - String
      #
      # String を返します。
      def parsed_value(value)
        remove_tag(value).gsub(NAME_GSUB_REGEXP, '').gsub(/ /, '')
      end
    end
  end
end
