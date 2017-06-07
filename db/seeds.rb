# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Vehicle.destroy_all
Feature.destroy_all

Vehicle.create! [
  {model: 'Fiesta', badge: 'ST', colour: 'Red'},
  {model: 'Fiesta', badge: 'ST', colour: 'Black'},
  {model: 'Fiesta', badge: 'ST', colour: 'Green'},
  {model: 'Falcon', badge: 'GT', colour: 'Pink'},
  {model: 'Mustang', badge: 'GT Fastback', colour: 'Red'},
  {model: 'Mustang', badge: 'GT Fastback', colour: 'Yellow'},
  {model: 'Unicorn', badge: 'XT Fastback', colour: 'Red'},
  {model: 'Mustang', badge: 'ST Fastback', colour: 'Red'},
  {model: 'Mustang', badge: 'GT', colour: 'Yellow'},
  {model: 'Focus', badge: 'GT', colour: 'Silver'},
  {model: 'Escape', badge: 'Fast', colour: 'Red'},
]

Feature.create! [
  {code: 'M', full_name: 'metallic'},
  {code: 'S', full_name: 'seat warmers'},
  {code: 'C', full_name: 'climate control'},
  {code: 'N', full_name: 'navigation'},
]
