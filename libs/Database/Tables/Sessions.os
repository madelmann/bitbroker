
import System.Collections.Vector;

public object TSessionsRecord {
   public string Created;
   public string Expires;
   public string Id;
   public string Identifier;

    public void Constructor( int databaseHandle ) {
        DB = databaseHandle;
    }

    public void Constructor( int databaseHandle, string query ) {
        DB = databaseHandle;

        loadByQuery( query );
    }

    public void Constructor( int databaseHandle, int result ) {
        DB = databaseHandle;

        loadByResult( result );
    }

    public void deleteByPrimaryKey( string id ) modify throws {
        var query = "DELETE FROM sessions WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insert( bool reloadAfterInsert = false ) modify throws {
        var query = "INSERT INTO sessions ( `created`, `expires`, `id`, `identifier` ) VALUES ( NULLIF('" + Created + "', ''), NULLIF('" + Expires + "', ''), '" + Id + "', '" + Identifier + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        if ( reloadAfterInsert ) {
            if ( !Id ) {
                Id = getLastInsertId();
            }

            loadByPrimaryKey( Id );
        }
    }

    public void insertIgnore( bool reloadAfterInsert = false ) modify throws {
        var query = "INSERT IGNORE INTO sessions ( `created`, `expires`, `id`, `identifier` ) VALUES ( NULLIF('" + Created + "', ''), NULLIF('" + Expires + "', ''), '" + Id + "', '" + Identifier + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        if ( reloadAfterInsert ) {
            if ( !Id ) {
                Id = getLastInsertId();
            }

            loadByPrimaryKey( Id );
        }
    }

    public void insertOrUpdate( bool reloadAfterInsert = false ) modify throws {
        var query = "INSERT INTO sessions ( `created`, `expires`, `id`, `identifier` ) VALUES ( NULLIF('" + Created + "', ''), NULLIF('" + Expires + "', ''), '" + Id + "', '" + Identifier + "' ) ON DUPLICATE KEY UPDATE `created` = NULLIF('" + Created + "', ''), `expires` = NULLIF('" + Expires + "', ''), `identifier` = '" + Identifier + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        if ( reloadAfterInsert ) {
            if ( !Id ) {
                Id = getLastInsertId();
            }

            loadByPrimaryKey( Id );
        }
    }

    public void loadByQuery( string query ) modify throws {
        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !mysql_fetch_row( result ) ) {
            throw "no result found";
        }

       Created = cast<string>( mysql_get_field_value( result, "created" ) );
       Expires = cast<string>( mysql_get_field_value( result, "expires" ) );
       Id = cast<string>( mysql_get_field_value( result, "id" ) );
       Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
    }

    public void loadByPrimaryKey( string id ) modify throws {
        var query = "SELECT * FROM sessions WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !mysql_fetch_row( result ) ) {
            throw "no result found";
        }

       Created = cast<string>( mysql_get_field_value( result, "created" ) );
       Expires = cast<string>( mysql_get_field_value( result, "expires" ) );
       Id = cast<string>( mysql_get_field_value( result, "id" ) );
       Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
    }

    public void loadByResult( int result ) modify {
       Created = cast<string>( mysql_get_field_value( result, "created" ) );
       Expires = cast<string>( mysql_get_field_value( result, "expires" ) );
       Id = cast<string>( mysql_get_field_value( result, "id" ) );
       Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
    }

    public void update( bool reloadAfterUpdate = false ) modify throws {
        var query = "UPDATE sessions SET `created` = NULLIF('" + Created + "', ''), `expires` = NULLIF('" + Expires + "', ''), `identifier` = '" + Identifier + "' WHERE id = '" + Id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        if ( reloadAfterUpdate ) {
            loadByPrimaryKey( Id );
        }
    }

    public bool operator==( TSessionsRecord other const ) const {
        return Id == other.Id;
    }

    public string =operator( string ) const {
        return "TSessionsRecord { NULLIF('" + Created + "', ''), NULLIF('" + Expires + "', ''), '" + Id + "', '" + Identifier + "' }";
    }

    private int getLastInsertId() const throws {
        var query = "SELECT LAST_INSERT_ID() AS id;";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !result ) {
            throw mysql_error( DB );
        }

        if ( !mysql_fetch_row( result ) ) {
            throw mysql_error( DB );
        }

        return cast<int>( mysql_get_field_value( result, "id" ) );
    }

    private int DB const;
}


public object TSessionsCollection implements ICollection { //<TSessionsRecord> {
    public void Constructor( int databaseHandle, string query = "" ) {
        Collection = new Vector<TSessionsRecord>();
        DB = databaseHandle;

        if ( query ) {
            loadByQuery( query );
        }
    }

    public TSessionsRecord at( int index ) const throws {
        return Collection.at( index );
    }

    public bool empty() const {
        return Collection.empty();
    }

    public TSessionsRecord first() const {
        return Collection.first();
    }

    public Iterator<TSessionsRecord> getIterator() const {
        return Collection.getIterator();
    }

    public TSessionsRecord last() const {
        return Collection.last();
    }

    public void loadByQuery( string query ) modify throws {
        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        Collection.clear();

        var result = mysql_store_result( DB );
        while ( mysql_fetch_row( result ) ) {
            var record = new TSessionsRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void loadByResult( int result ) modify throws {
        Collection.clear();

        while ( mysql_fetch_row( result ) ) {
            var record = new TSessionsRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void pop_back() modify {
        Collection.pop_back();
    }

    public void pop_front() modify {
        Collection.pop_front();
    }

    public int size() const {
        return Collection.size();
    }

    public void push_back( TSessionsRecord item ) modify {
        Collection.push_back( item );
    }

    private Vector<TSessionsRecord> Collection;
    private int DB const;
}


