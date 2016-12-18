# Rugby Union Squad Creator

Library that, given a JSON file with athletes list and a squad ID, it generates
a new rugby union squad and prints it in the console.

The entry point class to generate a new squad is `SquadCreator`.

## Creating and outputting new Squad

In the terminal:
```
$ cd rugby_squad_creator
$ irb
> require_relative 'lib/squad_creator'
> creator = SquadCreator.new('rugby_athletes.json')
> creator.create_and_output_as_string(10)
Squad ID: 10
Squad Name: Squad 10
Athletes:
 - Mercedes Whitehead - prop
 - Jessica Morton - prop
 - Elinor Brennan - hooker
 - Courtney Wells - lock
 - Calderon Byrd - lock
 - Kaufman Ferrell - flanker
 - Brianna Knapp - flanker
 - Edwards Robinson - number-eight
 - Cohen David - scrum-half
 - Mccullough Sosa - out-half
 - Fitzgerald Gonzalez - centre
 - Loraine Stevenson - centre
 - Diana Wiley - winger
 - Dominguez Dean - winger
 - Hillary Wiggins - full-back
```

## Running Specs

In the terminal, run the following commands:
```
$ cd rugby_squad_creator
$ bundle install
$ bundle exec rspec spec/
```
