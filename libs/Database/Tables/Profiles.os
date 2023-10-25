
import System.Collections.Vector;

public object TProfilesRecord {
	public int CreateUsers;
	public int DeleteUsers;
	public string Identifier;
	public int UpdateUsers;

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

    public void insert() modify throws {
        var query = "INSERT INTO profiles ( `create_users`, `delete_users`, `identifier`, `update_users` ) VALUES ( '" + CreateUsers + "', '" + DeleteUsers + "', '" + Identifier + "', '" + UpdateUsers + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insertOrUpdate() modify throws {
        var query = "INSERT INTO profiles ( `create_users`, `delete_users`, `identifier`, `update_users` ) VALUES ( '" + CreateUsers + "', '" + DeleteUsers + "', '" + Identifier + "', '" + UpdateUsers + "' ) ON DUPLICATE KEY UPDATE `create_users` = '" + CreateUsers + "', `delete_users` = '" + DeleteUsers + "', `identifier` = '" + Identifier + "', `update_users` = '" + UpdateUsers + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
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

		CreateUsers = cast<int>( mysql_get_field_value( result, "create_users" ) );
		DeleteUsers = cast<int>( mysql_get_field_value( result, "delete_users" ) );
		Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
		UpdateUsers = cast<int>( mysql_get_field_value( result, "update_users" ) );
    }

    public void loadByResult( int result ) modify {
		CreateUsers = cast<int>( mysql_get_field_value( result, "create_users" ) );
		DeleteUsers = cast<int>( mysql_get_field_value( result, "delete_users" ) );
		Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
		UpdateUsers = cast<int>( mysql_get_field_value( result, "update_users" ) );
    }

    public void update() modify {
		// UPDATE: not yet implemented
    }

    public string =operator( string ) const {
        return "TProfilesRecord { '" + CreateUsers + "', '" + DeleteUsers + "', '" + Identifier + "', '" + UpdateUsers + "' }";
    }

    private int DB const;
}


public object TProfilesCollection implements ICollection /*<TProfilesRecord>*/ {
    public void Constructor( int databaseHandle, string query = "" ) {
        Collection = new Vector<TProfilesRecord>();
        DB = databaseHandle;

        if ( query ) {
            loadByQuery( query );
        }
    }

    public TProfilesRecord at( int index ) const throws {
        return Collection.at( index );
    }

    public bool empty() const {
        return Collection.empty();
    }

    public TProfilesRecord first() const {
        return Collection.first();
    }

    public Iterator<TProfilesRecord> getIterator() const {
        return Collection.getIterator();
    }

    public TProfilesRecord last() const {
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
            var record = new TProfilesRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void loadByResult( int result ) modify throws {
        Collection.clear();

        while ( mysql_fetch_row( result ) ) {
            var record = new TProfilesRecord( DB );
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

    public void push_back( TProfilesRecord item ) modify {
        Collection.push_back( item );
    }

    private Vector<TProfilesRecord> Collection;
    private int DB const;
}

