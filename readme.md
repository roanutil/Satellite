# Satellite - A Code Challenge
## Browse the NASA TLE API while enjoying mediocre animations

Satellite displays a paginated list of satellites orbiting earth over a view of earth from space. When you select a satellite from the list, it zooms in on earth with a subtle parallax effect on the background stars and displays the two-line element data for that satellite. Obviously, there's a little satellite orbitting the earth in this view.

The architecture used is ComposableArchitecture which is my preferrence. It allows effortless composition of features and scenes in a functional reactive paradigm. 

## Challenge
#### Time limit - 48 Hours
### Description
Build a simple SwiftUI application with the following requirements:
1. Your are limited to a maximum of 3 Views
2. Your views should be linked creatively with some kind of button, Toggle, or BOOL.
3. Use SwiftUI's animations to transition between the pages of your Views.
4. Build one model in Swift that stores the data structure represented in your Views.

The content and data used is your choice.

You will be graded on:
1. Design and creativity: Animations, style, and design should be given a high priority.
2. User experience: How it feels navigating the app.
3. Code clarity: The code should be clean, lack redundancies, and readable.


### Extra Credit
Incorporate an API of your choice into your project

## Assumptions
The limit of 3 views is really saying 3 'scenes'

## API Key
Go to https://api.nasa.gov for your own API key. The demo key which has more severe rate limiting is hard coded into the APIService.

## Reference
https://tle.ivanstanojevic.me
https://spaceflight.nasa.gov/realdata/sightings/SSapplications/Post/JavaSSOP/SSOP_Help/tle_def.html

## Attribution
earth
<div>Icons made by <a href="https://www.flaticon.com/authors/turkkub" title="turkkub">turkkub</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>

satellite
<div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>