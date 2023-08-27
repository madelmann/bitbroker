
import System.Collections.Vector;

public object TAccountRecord {
	public string Created;
	public string Deleted;
	public string Id;
	public string Source;

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
		var query = "DELETE FROM account WHERE id = '" + id + "'";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insert() modify throws {
		var query = "INSERT INTO account ( `created`, `deleted`, `id`, `source` ) VALUES ( NULLIF('" + Created + "', ''), NULLIF('" + Deleted + "', ''), '" + Id + "', '" + Source + "' )";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insertOrUpdate() modify throws {
		var query = "INSERT INTO account ( `created`, `deleted`, `id`, `source` ) VALUES ( NULLIF('" + Created + "', ''), NULLIF('" + Deleted + "', ''), '" + Id + "', '" + Source + "' ) ON DUPLICATE KEY UPDATE `created` = NULLIF('" + Created + "', ''), `deleted` = NULLIF('" + Deleted + "', ''), `source` = '" + Source + "'";

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

		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		Deleted = cast<string>( mysql_get_field_value( result, "deleted" ) );
		Id = cast<string>( mysql_get_field_value( result, "id" ) );
		Source = cast<string>( mysql_get_field_value( result, "source" ) );
	}

	public void loadByPrimaryKey( string id ) modify throws {
		var query = "SELECT * FROM account WHERE id = '" + id + "'";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}

		var result = mysql_store_result( DB );
		if ( !mysql_fetch_row( result ) ) {
			throw "no result found";
		}

		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		Deleted = cast<string>( mysql_get_field_value( result, "deleted" ) );
		Id = cast<string>( mysql_get_field_value( result, "id" ) );
		Source = cast<string>( mysql_get_field_value( result, "source" ) );
	}

	public void loadByResult( int result ) modify {
		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		Deleted = cast<string>( mysql_get_field_value( result, "deleted" ) );
		Id = cast<string>( mysql_get_field_value( result, "id" ) );
		Source = cast<string>( mysql_get_field_value( result, "source" ) );
	}

	public void update() modify {
		// UPDATE: not yet implemented
	}

	public bool operator==( TAccountRecord other const ) const {
		return Id == other.Id;
	}

	public string =operator( string ) const {
		return "TAccountRecord { NULLIF('" + Created + "', ''), NULLIF('" + Deleted + "', ''), '" + Id + "', '" + Source + "' }";
	}

	private int DB const;
}


public object TAccountCollection implements ICollection { //<TAccountRecord> {
	public void Constructor( int databaseHandle, string query = "" ) {
		Collection = new Vector<TAccountRecord>();
		DB = databaseHandle;

		if ( query ) {
			loadByQuery( query );
		}
	}

	public TAccountRecord at( int index ) const throws {
		return Collection.at( index );
	}

	public bool empty() const {
		return Collection.empty();
	}

	public TAccountRecord first() const {
		return Collection.first();
	}

	public Iterator<TAccountRecord> getIterator() const {
		return Collection.getIterator();
	}

	public TAccountRecord last() const {
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
			var record = new TAccountRecord( DB );
			record.loadByResult( result );

			Collection.push_back( record );
		}
	}

	public void loadByResult( int result ) modify throws {
		Collection.clear();

		while ( mysql_fetch_row( result ) ) {
			var record = new TAccountRecord( DB );
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

	public void push_back( TAccountRecord item ) modify {
		Collection.push_back( item );
	}

	private Vector<TAccountRecord> Collection;
	private int DB const;
}


