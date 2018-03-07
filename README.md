# MLB Roster

## Summary
This app uses a Tab Bar to show two sections:

### MLB Teams
In the first tab, selecting a team displays their roster. You have the option to open a detailed view of each player with stats.

### Player Search
In the second tab, you can search by a player's name or position. At least one name or position must be provided, and at least two letters for a name.
The search listing allows you to select a player to view a detailed view with player stats.


## Choices Made

### XIBs vs Storyboards
I used a mix of storyboards and XIBs, as well as segues, dependency injection, and delegation throughout the app.
This was not to be inconsistent, but to show the many ways to accomplish the same task.
I use storyboards often, but many of my apps are also built entirely without them.
 
 ### **Table Views** vs **Collection Views** vs **Custom Views**
 I used table views for most views because of the organization a table view provides.
 In the future, it may be nice to provide a collection view option for the teams with a team logo for each cell.

### Search Restrictions
Instead of limiting name searches to four characters, I limited to two.
This was because there are three names in the database with two characters:
Hu, Ty, and Yu

### Third-Party Libraries
I chose not to use any third-party libraries because I did have a specific use for one in this situation.


## Future Updates

1. Organize team roster by positions. Each position has its own section with relevant players in it.
2. Finish adding Core Data
2. 1. Add a third tab for saved players, access from Core Data
2. 2. Save teams with Core Data, use this to display a user's team throughout the app
3. Add Activity Indicator to Table View footers when network requests are in progress
4. Style: Create custom activity indicator based off of a baseball diamond



### Notes:

This is a coding challenge. I own no right to any MLB names, terms, or images.
