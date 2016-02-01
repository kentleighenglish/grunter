# grunter
#### A bash CLI for easy Gruntfile.js management

Trying to switch to a new project or run multiple instances of a grunt compiler can be slow when all the local grunt files are located in different folders.
So I've made `grunter` to store, manage, and run grunt locals all from one CLI.

###Why is this helpful?
If I were working on a project with multiple sites (say an install of Wordpress and Magento), and each has a separate setup of grunt.

Then if I wanted to run the grunt compilers in both sites, I'd have to first navigate through the Wordpress installation to the Gruntfile.js; run my grunt compiler; then I'd need to open another terminal window; navigate through the Magento installation; and run the compiler there.

With grunter, I'd type `grunter r coolwebsite`


Ultimately grunter aims to make running multiple grunt compilers (as well as being aware of their status), a simple process that requires little or no action on the users part.

---

#Notice!
This shell script is still heavily in progress, and as such many vital functions have not yet been implemented.
If you would like to contribute, or have any requests; feel free to get in touch, I love hearing new ideas.

##Installation

Installing grunter is quite simple.

1. [Download grunter](https://github.com/kentleighenglish/grunter/archive/master.zip)
2. Unpack the archive in the location of your choosing
3. Run `grunter`
4. Set up your projects

That's it!

##Planned functions

###Main
- ~~Project listing with table display~~
- ~~Adding projects, and sub-projects~~
- Run grunt projects (and sub-projects)
- Managing running projects
- Remove projects command
- User configurations
- Set up help information for commands
- Basic parameter functionality for commands

---

###Future
- Create update script
- Convert project data storage from shell array to JSON object
- System tray icon for running grunt projects
- Sound notifications for grunt compiler status
- Webroot search functionality