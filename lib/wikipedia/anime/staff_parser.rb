# -*- coding: utf-8 -*-

require 'wikipedia/anime/tag_remover'

module Wikipedia
  module Anime
    # アニメスタッフパーサー
    #
    # アニメページのwikiテキストからスタッフ情報をパースします。
    #
    # Examples
    #
    #   page = Wikipedia.find('けいおん!')
    #   parser = Wikipedia::Anime::StaffParser.new(page.content).execute
    #   # => [#<Wikipedia::Anime::Staff ..>]
    #
    class StaffParser
      include TagRemover

      # アクセサー
      attr_accessor :staffs, :staff_texts, :page, :content

      # クラス定数
      STAFF_SCAN_REGEXP = /^\|(#{Staff::POSITIONS.join('|')})=(.*)/
      NAME_GSUB_REGEXP  = /{{.*\||}}|\[\[.*?\||\[\[|\]\]/

      # Public: 新しいインスタンスを生成します。
      #
      # page - Wikipedia::Page オブジェクト
      def initialize(page)
        @page        = page
        @content     = page.content
        @staffs      = []
        @staff_texts = @content.scan(STAFF_SCAN_REGEXP)
      end

      # Public: キャラクターをパースします。
      # Wikiページのコンテンツからキャラクターをパースします。
      #
      # Wikipedia::Anime::StaffParser オブジェクトを返します。
      def execute
        @staff_texts.each do |position, name|
          next if name.empty?
          @staffs << parsed_staff(position, name)
        end
        self
      end

      private

      # Internal: スタッフをパースして返します。
      #
      # position - String "脚本"
      # name     - String "[[虚淵玄]]"
      #
      # Wikipedia::Anime::Staff オブジェクトを返します。
      def parsed_staff(position, name)
        position = position.strip
        name = parsed_name(name)
        Staff.new(position: position, name: name)
      end

      # Internal: 名前を返します。
      #
      # name - String
      #
      # String を返します。
      def parsed_name(name)
        remove_tag(name).gsub(NAME_GSUB_REGEXP, '').gsub(/ /, '')
      end
    end
  end
end
