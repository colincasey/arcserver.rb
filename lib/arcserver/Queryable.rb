# encoding: utf-8

module ArcServer
  module Queryable
    def query(attrs)
      raise Exception, "#{url} is not defined" unless url
      REST::Query.new(attrs).execute(url)
    end
  end
end
