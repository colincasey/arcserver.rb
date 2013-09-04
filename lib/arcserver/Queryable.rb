# encoding: utf-8

module ArcServer
  module Queryable
    def query(layer, attrs)
      raise Exception, "#{url} is not defined" unless url
      REST::Query.new(attrs).execute("#{url}/#{layer}")
    end
  end
end
