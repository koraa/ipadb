ipadb
=====

A one-file DB definition and query tool specialized in IPA querying.
NOT FIT FOR PRODUCTiVE WORK (unless you know quite well what you do).

Licensed under LGPL >= 3.0

Running
=======

You will need to use coffescript (http://coffeescript.org/) and Node.js (http://nodejs.org/) to run IPADB.
If you have installed both, switch to the Repo directory and type this into your command prompt:

    $ coffee ipadb.coffee

If you want to extend the database, see the *data* dict.
If you want to add more properties, see the *P* dict.
If you want to change the querys, scroll to the bottom of the file
and change the querys (the stuff beginning with the $ sign).

It's certainly possible to load this stuff in an interactive console or in the browser,
currently there are no scripts for that, but if you know what you're doing: GO FOR IT!
