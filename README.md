books-and-movies
================

A simple master-detail app that pulls books and movies from a JSON feed, lists them in a table view, and shows a lil' detail about them. Built for those who are new to iOS, it uses a few key technologies that you'll use in almost any app you build.

![Main view](Main screen.png)


## Technologies

Most of the apps you build will use UIKit, which is the built-in widget library for iOS. Additionally, if you do any sort of networking in an app, you'll likely be using NSURLSession. And if that networking is pulling JSON from a server (or sending JSON *to* a server), you'll probably use NSJSONSerialization. From UIKit to NSURLSession to NSJSONSerialization, you can't go wrong with [books-and-movies](https://github.com/iOSDevTraining/books-and-movies). :)

### UIKit

![Main view](Main screen.png)

**The Master view** uses two key elements of UIKit: UITableView and UISegmentedControl. UITableView is used in tons of apps on the App Store, plus many of Apple's built-in apps, like Mail, Contacts, and Settings. And UISegmentedControl (that blue control that says "Movies" and "Books" in the top of the master screen shot above) is used almost as frequently. It can be seen in apps like Maps (hit the info button to see Standard | Hybrid | Satellite in a segmented control) and Safari (on the Bookmarks screen, it's the Bookmarks | Reading List control at the top).

![Detail view](Detail screen.png)

**The Detail view** shows examples of UIImageView and UILabel, both part of UIKit. The UIImageView is the view that displays the book/movie cover art. All of the text elements on the detail screen are UILabels.

Basically everything that starts with "UI" is part of UIKit, so that makes it easy to remember what's in UIKit and what's not.

### NSURLSession

The data for the table view is fetched with the help of NSURLSession, which is a wonderful new class in iOS 7 that makes HTTP requests so much nicer than with NSURLConnection, its nasty predecessor. (It's only nasty *now* because we have NSURLSession - note that it wasn't all that awful before we knew any better.) See IDTViewController for more on how to make HTTP requests with NSURLSession.

### NSJSONSerialization

JSON serialization in iOS is really quite simple thanks to NSJSONSerialization which turns plain ol' JSON into instances of NSDictionary, NSArray, NSString, NSNumber, and everybody's favorite: NSNull. The example here shows that, but NSJSONSerialization can also go the other way, turning your NSDictionary, NSArray, NSString, NSNumber, and NSNull objects into a lovely chunk of UTF-8 encoded data (NSData).
