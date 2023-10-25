
import System.Collections.Vector;

public object TCurrencyRecord {
	public string Code;
	public int Id;
	public int Precision;

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
        var query = "DELETE FROM currency WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insert() modify throws {
        var query = "INSERT INTO currency ( `code`, `id`, `precision` ) VALUES ( '" + Code + "', '" + Id + "', '" + Precision + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insertOrUpdate() modify throws {
        var query = "INSERT INTO currency ( `code`, `id`, `precision` ) VALUES ( '" + Code + "', '" + Id + "', '" + Precision + "' ) ON DUPLICATE KEY UPDATE `code` = '" + Code + "', `precision` = '" + Precision + "'";

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

		Code = cast<string>( mysql_get_field_value( result, "code" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		Precision = cast<int>( mysql_get_field_value( result, "precision" ) );
    }

    public void loadByPrimaryKey( int id ) modify throws {
        var query = "SELECT * FROM currency WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !mysql_fetch_row( result ) ) {
            throw "no result found";
        }

		Code = cast<string>( mysql_get_field_value( result, "code" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		Precision = cast<int>( mysql_get_field_value( result, "precision" ) );
    }

    public void loadByResult( int result ) modify {
		Code = cast<string>( mysql_get_field_value( result, "code" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		Precision = cast<int>( mysql_get_field_value( result, "precision" ) );
    }

    public void update() modify {
		// UPDATE: not yet implemented
    }

    public bool operator==( TCurrencyRecord other const ) const {
        return Id == other.Id;
    }

    public string =operator( string ) const {
        return "TCurrencyRecord { '" + Code + "', '" + Id + "', '" + Precision + "' }";
    }

    private int DB const;
}


public object TCurrencyCollection implements ICollection { //<TCurrencyRecord> {
    public void Constructor( int databaseHandle, string query = "" ) {
        Collection = new Vector<TCurrencyRecord>();
        DB = databaseHandle;

        if ( query ) {
            loadByQuery( query );
        }
    }

    public TCurrencyRecord at( int index ) const throws {
        return Collection.at( index );
    }

    public bool empty() const {
        return Collection.empty();
    }

    public TCurrencyRecord first() const {
        return Collection.first();
    }

    public Iterator<TCurrencyRecord> getIterator() const {
        return Collection.getIterator();
    }

    public TCurrencyRecord last() const {
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
            var record = new TCurrencyRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void loadByResult( int result ) modify throws {
        Collection.clear();

        while ( mysql_fetch_row( result ) ) {
            var record = new TCurrencyRecord( DB );
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

    public void push_back( TCurrencyRecord item ) modify {
        Collection.push_back( item );
    }

    private Vector<TCurrencyRecord> Collection;
    private int DB const;
}


