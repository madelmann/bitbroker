
import System.Collections.Vector;

public object TOrderStatusRecord {
	public string Description;
	public int Id;
	public string Token;

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

    public void deleteByPrimaryKey( int id ) modify throws {
        var query = "DELETE FROM order_status WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insert() modify throws {
        var query = "INSERT INTO order_status ( `description`, `id`, `token` ) VALUES ( '" + Description + "', '" + Id + "', '" + Token + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insertOrUpdate() modify throws {
        var query = "INSERT INTO order_status ( `description`, `id`, `token` ) VALUES ( '" + Description + "', '" + Id + "', '" + Token + "' ) ON DUPLICATE KEY UPDATE `description` = '" + Description + "', `token` = '" + Token + "'";

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

		Description = cast<string>( mysql_get_field_value( result, "description" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		Token = cast<string>( mysql_get_field_value( result, "token" ) );
    }

    public void loadByPrimaryKey( int id ) modify throws {
        var query = "SELECT * FROM order_status WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !mysql_fetch_row( result ) ) {
            throw "no result found";
        }

		Description = cast<string>( mysql_get_field_value( result, "description" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		Token = cast<string>( mysql_get_field_value( result, "token" ) );
    }

    public void loadByResult( int result ) modify {
		Description = cast<string>( mysql_get_field_value( result, "description" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		Token = cast<string>( mysql_get_field_value( result, "token" ) );
    }

    public void update() modify {
		// UPDATE: not yet implemented
    }

    public bool operator==( TOrderStatusRecord other const ) const {
        return Id == other.Id;
    }

    public string =operator( string ) const {
        return "TOrderStatusRecord { '" + Description + "', '" + Id + "', '" + Token + "' }";
    }

    private int DB const;
}


public object TOrderStatusCollection implements ICollection { //<TOrderStatusRecord> {
    public void Constructor( int databaseHandle, string query = "" ) {
        Collection = new Vector<TOrderStatusRecord>();
        DB = databaseHandle;

        if ( query ) {
            loadByQuery( query );
        }
    }

    public TOrderStatusRecord at( int index ) const throws {
        return Collection.at( index );
    }

    public bool empty() const {
        return Collection.empty();
    }

    public TOrderStatusRecord first() const {
        return Collection.first();
    }

    public Iterator<TOrderStatusRecord> getIterator() const {
        return Collection.getIterator();
    }

    public TOrderStatusRecord last() const {
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
            var record = new TOrderStatusRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void loadByResult( int result ) modify throws {
        Collection.clear();

        while ( mysql_fetch_row( result ) ) {
            var record = new TOrderStatusRecord( DB );
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

    public void push_back( TOrderStatusRecord item ) modify {
        Collection.push_back( item );
    }

    private Vector<TOrderStatusRecord> Collection;
    private int DB const;
}


