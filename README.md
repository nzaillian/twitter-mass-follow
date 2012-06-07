A Twitter mass-following script

A dead simple little script to mass follow Twitter users whose account names match a given search term.  Pleas don't use it for evil.

You'll need to have API credentails to use the script.  Go to https://dev.twitter.com and register an application (fictitious or otherwise).  Make sure the application has read/write access.

Open api_credentials.rb and populate the 4 API credential fields with the appropriate values.

The script accepts 3 parameters (2 are optional).  The required parameter is your search term.  This must be preceded with the "-t" flag.  The Twitter API paginates user search results, and the script therefore also accepts -s/--start and -m/--max-pages options which indicate, respectively, the page of results to start on and the maximum number of pages to iterate over.  There are 10 users to a page so if I wanted to follow the first 100 users matching the term "disco", I'd run the script with the following options:

  ruby mass_follow.rb -t disco -s 0 -m 10
  
Dependencies:
  this script depends on the twitter ruby gem v 2.5.0 (http://rubygems.org/gems/twitter).