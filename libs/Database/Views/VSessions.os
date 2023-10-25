
import System.Collections.Vector;

public object VSessionsRecord {
	public string Created;
	public int CreateUsers;
	public int DeleteUsers;
	public string Expires;
	public string Id;
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
		CreateUsers = cast<int>( mysql_get_field_value( result, "create_users" ) );
		DeleteUsers = cast<int>( mysql_get_field_value( result, "delete_users" ) );
		Expires = cast<string>( mysql_get_field_value( result, "expires" ) );
		Id = cast<string>( mysql_get_field_value( result, "id" ) );
		Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
		UpdateUsers = cast<int>( mysql_get_field_value( result, "update_users" ) );
    }

    public void loadByPrimaryKey( string id ) modify throws {
        var query = "SELECT * FROM v_sessions WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !mysql_fetch_row( result ) ) {
            throw "no result found";
        }

		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		CreateUsers = cast<int>( mysql_get_field_value( result, "create_users" ) );
		DeleteUsers = cast<int>( mysql_get_field_value( result, "delete_users" ) );
		Expires = cast<string>( mysql_get_field_value( result, "expires" ) );
		Id = cast<string>( mysql_get_field_value( result, "id" ) );
		Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
		UpdateUsers = cast<int>( mysql_get_field_value( result, "update_users" ) );
    }

    public void loadByResult( int result ) modify {
		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		CreateUsers = cast<int>( mysql_get_field_value( result, "create_users" ) );
		DeleteUsers = cast<int>( mysql_get_field_value( result, "delete_users" ) );
		Expires = cast<string>( mysql_get_field_value( result, "expires" ) );
		Id = cast<string>( mysql_get_field_value( result, "id" ) );
		Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
		UpdateUsers = cast<int>( mysql_get_field_value( result, "update_users" ) );
    }

    public bool operator==( VSessionsRecord other const ) const {
        return Id == other.Id;
    }

    public string =operator( string ) const {
        return "VSessionsRecord { NULLIF('" + Created + "', ''), '" + CreateUsers + "', '" + DeleteUsers + "', NULLIF('" + Expires + "', ''), '" + Id + "', '" + Identifier + "', '" + UpdateUsers + "' }";
    }

    private int DB const;
}


public object VSessionsCollection implements ICollection /*<VSessionsRecord>*/ {
    public void Constructor( int databaseHandle, string query = "" ) {
        Collection = new Vector<VSessionsRecord>();
        DB = databaseHandle;

        if ( query ) {
            loadByQuery( query );
        }
    }

    public VSessionsRecord at( int index ) const throws {
        return Collection.at( index );
    }

    public bool empty() const {
        return Collection.empty();
    }

    public VSessionsRecord first() const {
        return Collection.first();
    }

    public Iterator<VSessionsRecord> getIterator() const {
        return Collection.getIterator();
    }

    public VSessionsRecord last() const {
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
            var record = new VSessionsRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void loadByResult( int result ) modify throws {
        Collection.clear();

        while ( mysql_fetch_row( result ) ) {
            var record = new VSessionsRecord( DB );
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

    public void push_back( VSessionsRecord item ) modify {
        Collection.push_back( item );
    }

    private Vector<VSessionsRecord> Collection;
    private int DB const;
}

