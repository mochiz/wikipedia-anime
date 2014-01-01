# -*- coding: utf-8 -*-

module Wikipedia
  module Anime
    # タグ除去に関するメソッドをまとめたモジュール
    # パーサーに include して使います。
    module TagRemover
      REFERENCE_TAG     = %r(<ref.*?</ref>|<REF.*?</REF>|<ref.*?/>)
      COMMENT_TAG       = /<!--.*-->/
      INTERNAL_LINK_TAG = /\[\[|\[\[.*?\||\]\]/
      SPAN_TAG = /<span.*?>|<\/span>/

      # Public: テキストからタグを除去します。
      #
      # string - String
      #
      # String を返します。
      def remove_tag(string)
        string = remove_reference_tag(string)
        string = remove_comment_tag(string)
        string = remove_internal_link_tag(string)
        string = remove_span_tag(string)
        string
      end

      # Publid: 文字列から参照タグを除去します。
      #
      # str - String
      #
      # String を返します。
      def remove_reference_tag(str)
        str.gsub(REFERENCE_TAG, '')
      end

      # Publid: 文字列からコメントタグを除去します。
      #
      # str - String
      #
      # String を返します。
      def remove_comment_tag(str)
        str.gsub(COMMENT_TAG, '')
      end

      # Publid: 文字列から内部リンクタグを除去します。
      #
      # str - String
      #
      # String を返します。
      def remove_internal_link_tag(str)
        str.gsub(INTERNAL_LINK_TAG, '')
      end

      # Publid: 文字列からspanタグを除去します。
      #
      # str - String
      #
      # String を返します。
      def remove_span_tag(str)
        str.gsub(SPAN_TAG, '')
      end
    end
  end
end
