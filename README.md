# SongSwap

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
**SongSwap** is an application that allows users to maintain a social media feed explicitly for music via the Spotify API. It will allow users to post songs they enjoy, see and comment on the songs that their friends have posted and see their friends' top songs! All music will be streamed natively in the application and the music found on the platform can be added to playlists natively as well. Additionally, we hope to implement a "Song of the Day" feature to further showcase the design team's love of music. 

- **Category:** Social, Entertainment, Music
- **Mobile:** This app would be originally developed on mobile, much like other social media applications (Instagram, Twitter, etc.)
- **Story:** Music is a large part of building relationships and connecting with others. Our app will allow people to easily share music with their friends rather than using a messaging app where they can only send links. 
- **Market:** Any Spotify user can use this app. Ability to follow friends and view their suggested songs allows the users to socially connect with others through music.
- **Habit:** This app can be used as often as the user would like, depending on when they want to view their friends' suggested songs and share their current music interests. We assume there will be a wide range of potential rates of viewing as we hope to make our platform similar to many other social media platforms. 
- **Scope:** First we would start with building the posting ability and a feed to see and comment music your friends have shared. Then we would add extra features like generating a playlist based off of your friends' recent songs, listing your current top 10 songs on your profile, and getting a random song of the day.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User searches for and adds friends
* User customizes their profile page with favorite songs
* User searches for and posts a song they like to share with their friends
* User comments on a friend's post
* User plays a song their friend shared natively in the app
* User adds a song their friend shared to their own playlist
* User can view a feed of all the songs their friends have shared

**Optional Nice-to-have Stories**

* User generates playlist based off of their friends recent songs
* User views current top 10 songs on their profile (public) - Using Spotify API
* User can be recommended a random song of the day!
* User sends a song they want to recommend to a friend
* User can edit their app-wide and profile settings

### 2. Screen Archetypes

* Login/Register Screen
    * User signs up or logs into their account
* Find Friends Screen
    * User can search for friends to follow
* Create Post
    * Search Screen
        * User can search for a song to post
    * Details Screen
        * User can write a caption and share it to their followers
* Friend Feed Screen
    * User can scroll through their feed and play songs
    * User can save posts
    * User can add songs to a playlist
    * User can open song on Spotify
* Post Details Screen
    * User can comment on their friends post
    * User can scroll through comments on their friends' post
    * User can play full song instead of snippet
* Profile Screen
    * User can view their music profile
    * User can see their saved posts
    * User can see their shared posts
    * User can see their top 10 song
    * User can see their followers and following
* Settings Screen
    * User can edit their app-wide and profile settings

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Friend Feed
* Find Friends
* Profile

**Flow Navigation** (Screen to Screen)

* Friend Feed
    * Create Post
        * Search
        * Details
    * Post Details
    * Open song on Spotify
    * Add to playlist
* Profile
    * Followers
    * Following
    * Shared posts
    * Top 10 Songs
    * Saved posts

## Wireframes
<img src="wireframes/wireframe.png" width=700>


## Schema 
<img width="719" alt="Screen Shot 2021-05-09 at 7 27 32 PM" src="https://user-images.githubusercontent.com/29528135/117598470-b7fd2580-b0fc-11eb-9c09-788d7f15b060.png">


### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
