# Arcserver.rb

Arcserver.rb is an interface for interacting with ESRI ArcGIS Server  REST APIs from Ruby.

[![Build Status](https://travis-ci.org/lukefx/arcserver.rb.png?branch=master)](https://travis-ci.org/lukefx/arcserver.rb)
[![Code Climate](https://codeclimate.com/github/lukefx/arcserver.rb.png)](https://codeclimate.com/github/lukefx/arcserver.rb)

## Installation

    [sudo] gem install arcserver.rb

If you want to use it in with Bundler add to your Gemfile

    gem 'arcserver.rb', '~> 0.1.5'

## Quick Example

```ruby
require 'arcserver'
```

Connect to a map server instance using either its REST url

```ruby
map_server = ArcServer::MapServer.new('http://sampleserver1.arcgisonline.com/ArcGIS/services/Portland/ESRI_LandBase_WebMercator/MapServer')
```

and export an image

```ruby
puts map_server.export
```

Query for retreive some features, the result will be a FeatureSet, which is a wrapper for the layer information and the features found

```ruby
query = ArcServer::REST::Query.new({ where: "district='4'", outFields: "*" })
feature_set = query.execute('0', "http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")

puts feature_set.features
```

Or directly within a MapServer or FeatureServer and his Layer number

```ruby
feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
feature_set = feature_server.query('0', { where: "district='Lugano'", outFields: "*" })
```

Query is possible in different ways, like through geometry

```ruby
feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
feature_set = feature_server.query('0', { geometryType: 'esriGeometryEnvelope', geometry: '{"xmin":997878.8354556253,"ymin":5783588.635939264,"xmax":998147.5593831083,"ymax":5783767.785224252,"spatialReference":{"wkid":102100}}', outFields: "*", inSR: 102100, outSR: 102100 })

puts feature_set.features
```

An Identify operation is a query but applied to all layers in the MapServer

```ruby
map_server = ArcServer::MapServer.new("http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Specialty/ESRI_StateCityHighway_USA/MapServer")
results = map_server.identify({ geometryType: "esriGeometryPoint", geometry: "-120,40", tolerance: "10", mapExtent: "-119,38,-121,41", imageDisplay: "400,300,96" })

puts results # each results has its own feature and metadata
```

A feature is a simple class with Geometry and attributes, create one is easy

```ruby
f = ArcServer::Graphics::Feature.new({ geometry: { x: 997986.5006082746, y: 5783631.06234916, spatialReference: { wkid: 102100 }}, attributes: {status:1,req_id:"12345",req_type:"Graffiti Complaint – Private Property",req_date:"30.09.2013",req_time:"14:00",address:"via dei matti 0",district:"4"} })
```

Once you have a feature, it's ready to be saved on a feature layer

```ruby
fs = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
results = fs.applyEdits('0', [ f ], [], []) # adds, updates, deletes
```

You can simply edit a feature if you have an objectId, maybe retrieved with a Query

```ruby
f = ArcServer::Graphics::Feature.new({ attributes: { objectId: 12345, address: "via dei matti 0", district: "4"} })
results = fs.applyEdits('0', [], [ f ], []) # adds, updates, deletes
```

And if you want to delete some features?

```ruby
feature_server = ArcServer::FeatureServer.new("http://sampleserver3.arcgisonline.com/ArcGIS/rest/services/SanFrancisco/311Incidents/FeatureServer")
feature_set = feature_server.query('0', { geometryType: 'esriGeometryEnvelope', geometry: '{"xmin":997878.8354556253,"ymin":5783588.635939264,"xmax":998147.5593831083,"ymax":5783767.785224252,"spatialReference":{"wkid":102100}}', outFields: "*", inSR: 102100, outSR: 102100 })
# we have to create an array of ids like this: '80012, 93002'
deletes = feature_set.features.map { |f| f.attributes[:objectid] }.join(',')
results = feature_server.applyEdits('0', [], [], deletes)
```

## Contributors

This is a fork of arcserver.rb originally written by:

* Colin Casey
* Glenn Goodrich

## Contribute

If you'd like to hack on arcserver.rb, start by forking my repo on GitHub:

  http://github.com/lukefx/arcserver.rb

To get all of the dependencies, install the gem first. The best way to get your changes merged back into core is as follows:

1. Clone your fork
2. Create a thoughtfully named topic branch to contain your change
3. Hack away
4. Add tests and make sure everything still passes by running rake
5. If you are adding new functionality, document it in the README
6. Do not change the version number, I will do that on my end
7. If necessary, rebase your commits into logical chunks, without errors
8. Push the branch up to GitHub
9. Send me a pull request for your branch

## Copyright

Copyright (c) 2010 Colin Casey. See LICENSE for details.
