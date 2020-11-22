# College Portfolio

Incomplete portfolio of projects completed at [University of Texas at Dallas](https://www.utdallas.edu/), 2015-2019. More projects will be added soon.

These projects showcase my abilities in software planning, design, development, and testing in a collaborative environment. More recent projects also demonstrate my growth in utilizing problem-solving techniques, programming principles, and coding best practices.

## Music Player Database for Android
Using [SQLite](https://www.sqlite.org/index.html), an SQL database engine built into all mobile phones, I developed a Java utility class that allows standardized CRUD functions to be performed on the application database. Exposed functions take into account application knowledge (music player) which facilitates integration with the rest of the app and allows other teammembers to ignore implementation details.

### Example code of CRUD functions:
##### Create/Insert Playlist
```Java
    //Insert playlist to Playlist table
    public boolean insertPlaylist(Playlist inPlaylist){
        //Check if playlist already exists in Playlist table and exit if it does
        String playlistID = getPlaylistID(inPlaylist);
        if(!playlistID.equals(ID_NOT_FOUND))
            return true;

        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();

        contentValues.put(DBContract.PlaylistEntry.COL_TITLE, inPlaylist.getPlaylistName());
        long result = db.insert(DBContract.PlaylistEntry.TABLE_NAME, null, contentValues);

        //Database no longer needed
        db.close();

        if(result == -1)
            return false;
        else
            return true;
    }
```

##### Read/Get Playlists
```Java
    //Returns ArrayList with all the playlists in the Playlist table along with their songs
    public ArrayList<Playlist> getPlaylists(){
        SQLiteDatabase db = this.getReadableDatabase();

        //May cause problems with cursor.getColumnIndexOrThrow() since rawQuery, but maybe not
        Cursor cursor = db.rawQuery("SELECT * FROM " + DBContract.PlaylistEntry.TABLE_NAME, null);

        //Setup
        ArrayList<Playlist> playlists = new ArrayList<Playlist>();
        String id = "";
        String name = "";

        //Creates a playlist for every entry in the Playlist table
        //Gets playlist name from query, gets playlist songs using playlist ID from query and running getSongsInPlaylist()
        while(cursor.moveToNext()){
            id = cursor.getString(cursor.getColumnIndexOrThrow(DBContract.PlaylistEntry._ID));
            name = cursor.getString(cursor.getColumnIndexOrThrow(DBContract.PlaylistEntry.COL_TITLE));
            playlists.add(new Playlist(name, getSongsInPlaylist(id, db)));
        }

        //Database no longer needed
        db.close();

        return playlists;
    }
```

##### Update Playlists
```Java
    public void updatePlaylist(Playlist inPlaylist){
        SQLiteDatabase db = this.getWritableDatabase();

        //Delete former playlist links if playlist already existed in Playlist table, create a new playlist otherwise
        String playlistID = getPlaylistID(db, inPlaylist);
        if(!playlistID.equals(ID_NOT_FOUND)){
            //Delete all the links connecting songs to this playlist in PlaylistSong table
            String playlistSongSelection = DBContract.PlaylistSongEntry.COL_PLAYLIST_ID + " LIKE ?";
            String[] selectionArgs = {playlistID};
            db.delete(DBContract.PlaylistSongEntry.TABLE_NAME, playlistSongSelection, selectionArgs);
        }
        else{
            insertPlaylist(inPlaylist);
        }

        //Add new songs to playlist in PlaylistSong table
        for(Song s: inPlaylist.getSongs())
            addSongToPlaylist(s, inPlaylist);

        //SQL database no longer needed
        db.close();
    }
```

##### Delete Playlist
```Java
      public boolean deletePlaylist(Playlist inPlaylist){
        String playlistID = getPlaylistID(inPlaylist);
        if(playlistID.equals(ID_NOT_FOUND))
            return false;

        SQLiteDatabase db = this.getWritableDatabase();

        //Delete all the links connecting songs to this playlist in PlaylistSong table
        String playlistSongSelection = DBContract.PlaylistSongEntry.COL_PLAYLIST_ID + " LIKE ?";
        String[] selectionArgs = {playlistID};
        db.delete(DBContract.PlaylistSongEntry.TABLE_NAME, playlistSongSelection, selectionArgs);

        //Delete actual playlist from Playlist table
        String playlistSelection = DBContract.PlaylistEntry._ID + " LIKE ?";
        db.delete(DBContract.PlaylistEntry.TABLE_NAME, playlistSelection, selectionArgs);

        //Database no longer needed
        db.close();

        return true;
    }
```

I also designed the database schema for the class. Principles of normalization were followed except for one instance: song path is an attribute in both song table and note table. This decision was made to simplify implementation.

### Database Schema Visualized:

##### Playlist Table
Playlist ID|Playlist Title
-----------|--------------

##### Song Table
Song ID|Song Title|Song Path|Song Artist|Song Duration
-------|----------|---------|-----------|-------------

##### Playlist-Song Table
Playlist_Song ID|Playlist ID|Song ID
----------------|-----------|-------

##### Note Table
Note ID|Song ID|Song Path|Note Title|Note Content
-------|-------|---------|----------|------------

