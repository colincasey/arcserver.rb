# encoding: utf-8

module ArcServer
  module Identifiable
    def identify(attrs)
      raise Exception, "#{url} is not defined" unless url
      REST::Identify.new(attrs).execute(url)
    end
  end
end
