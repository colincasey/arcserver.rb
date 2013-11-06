# encoding: utf-8

require 'spec_helper'

describe 'GPServer' do

  it "should execute a Geo Processing Tool" do

    gp = ArcServer::GPServer.new("http://srvgispr001.lugano.ch:8399/arcgis/rest/services/GisWeb/GPServer/GWClip")

    particella = JSON.parse('{"geometryType":"","features":[{"geometry":{"rings":[[[717172.6070000008,95751.06210000068],[717158.6838999987,95784.61699999869],[717154.0441000015,95795.80009999871],[717154.5069999993,95795.98910000175],[717154.3260000013,95796.42799999937],[717163.7069999985,95800.2501000017],[717163.5260000005,95800.6950000003],[717173.6851000004,95804.83399999887],[717173.8660999984,95804.3898999989],[717183.257100001,95808.21599999815],[717183.4420999996,95807.77910000086],[717183.9050000012,95807.96810000017],[717202.3891000003,95763.03290000185],[717196.4549000002,95760.59910000116],[717196.6218999997,95760.18100000173],[717178.7580000013,95753.0540000014],[717178.5909999982,95753.47190000117],[717172.6070000008,95751.06210000068]]]},"attributes":{"OBJECTID":1058,"Keygis":"5960100237","Comune":596,"Quartiere":1,"Numero":"237","Superficie":1590,"Validita":0,"Genere":0,"Ubicazione":"Centro","Oggetto_Interlis":1154,"Sezione":59601,"TAG_Descrizione":"Rinnovamento","IdentAN":"1","Identificatore":"0","Data_in_vigore":"20050729","Data_iscrizione_RF":"20050729","Genere_Descr":"bene_immobile","SHAPE.area":1589.943749235,"SHAPE.len":164.17216370058608}}],"fieldAliases":null}')

    params = { Feature_Set: particella.to_json }

    gp.submitJob(params) do |features|
      puts features.inspect
    end

  end

end
