# WodLeader - A multi-event Crossfit scorekeeping app

Note: Wodleader is no longer hosted or maintained.

### Getting Started Guide

[See how WodLeader works with the Getting Started Guide](https://github.com/briandoll/wodleader/wiki)

## Data Entry

All data entry occurs at `/admin`.  The admin section is protected, so you'll need to know the username and password to continue.

### Competition

A multi-event crossfit competition is referred to as a `Competition` in wodleader.  Set up a `Competition` with basic information about where and when it will be held, and a description.

### Competition Categories

`Competition Categories` segment athletes into groups.  Examples include 'RX Men', 'RX Women', 'Scaled Women', etc.

### Events

A `Competition` can have one or more `Events`.  Set up an `Event` for each individually scored event of your competition.  In the event description, add all details of the event for all levels (RX, Scaled, etc.)  `Events` can be marked as lowest-wins (time-based) or highest-wins (max reps, max weight, etc.).  `Events` can also be weighted proportionally.  By default, each `Event` is counted fully (1.0).  To create two smaller events that are worth half as much, set the event weighting to 0.5 each.

### Athletes

`Athletes` participate in `Competitions`, and participate in each `Event` of that `Competition`.  You may enter athlete numbers and gym affiliations.  `Athletes` must have a specified `Competition Category` that they are competing in and this must stay consistent throughout the competition.

### Athlete Scores

This is where the magic happens.  Once the competition and events are set up and the athletes are all registered, updating scores is the name of the game.

`Athlete Scores` can be entered as whole numbers, decimals or in time format, eg. 7:16 for seven minutes and 16 seconds.

*Note: For time-based events, make sure to use the same number of segments in all time-based results.  For example if someone finished a workout in under a minute it should be entered with a leading zero: 0:58.  If results only use minutes and seconds and a competitor takes over an hour, enter it thusly: 63:34*

## How the scoring works

WodLeader uses standard Crossfit scoring.  Each athlete is ranked among their group's peers (all RX women, for example) for each event.  Their ranking is multiplied by that events weighting (default of 1).  For the competition leaderboard, each athlete category contains ranked athletes determined by the sum of their rankings across all events with the lowest score at the top.

## Hackery!

This is an insanely quick hack of an app using rails admin to do manage scoring of multi-event crossfit competitions.

I wrote [crossfit\_scorekeeping\_generator](https://github.com/briandoll/crossfit_scorekeeping_generator), which generates excel files for tracking multi-event crossfit competitions.  It served a handful of events, but was a pain to use.  I wanted to see how quickly I could port that logic to a rails app.  The goal was to complete the app on a 5 hour flight.  Unfortunately it took about 2 more hours.  Bummer.

Again, this app is a hack.  It's an exercise in writing shit as fast as possible.  There are infinite areas to improve performance, security and functionality.  For now, I'll be giving away access to a few gyms to use, and see what happens from there.
