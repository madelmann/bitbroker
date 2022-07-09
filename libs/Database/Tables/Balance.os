
import System.Collections.Vector;

public object TBalanceRecord {
	public string AccountId;
	public double Available;
	public string CurrencyCode;
	public int Id;
	public double Locked;
	public string Time;

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
		var query = "DELETE FROM balance WHERE id = '" + id + "'";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insert() modify throws {
		var query = "INSERT INTO balance ( `account_id`, `available`, `currency_code`, `id`, `locked`, `time` ) VALUES ( '" + AccountId + "', '" + Available + "', '" + CurrencyCode + "', '" + Id + "', '" + Locked + "', NULLIF('" + Time + "', '') )";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insertOrUpdate() modify throws {
		var query = "INSERT INTO balance ( `account_id`, `available`, `currency_code`, `id`, `locked`, `time` ) VALUES ( '" + AccountId + "', '" + Available + "', '" + CurrencyCode + "', '" + Id + "', '" + Locked + "', NULLIF('" + Time + "', '') ) ON DUPLICATE KEY UPDATE `account_id` = '" + AccountId + "', `available` = '" + Available + "', `currency_code` = '" + CurrencyCode + "', `locked` = '" + Locked + "', `time` = NULLIF('" + Time + "', '')";

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

		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Available = cast<double>( mysql_get_field_value( result, "available" ) );
		CurrencyCode = cast<string>( mysql_get_field_value( result, "currency_code" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		Locked = cast<double>( mysql_get_field_value( result, "locked" ) );
		Time = cast<string>( mysql_get_field_value( result, "time" ) );
	}

	public void loadByPrimaryKey( int id ) modify throws {
		var query = "SELECT * FROM balance WHERE id = '" + id + "'";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}

		var result = mysql_store_result( DB );
		if ( !mysql_fetch_row( result ) ) {
			throw "no result found";
		}

		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Available = cast<double>( mysql_get_field_value( result, "available" ) );
		CurrencyCode = cast<string>( mysql_get_field_value( result, "currency_code" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		Locked = cast<double>( mysql_get_field_value( result, "locked" ) );
		Time = cast<string>( mysql_get_field_value( result, "time" ) );
	}

	public void loadByResult( int result ) modify {
		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Available = cast<double>( mysql_get_field_value( result, "available" ) );
		CurrencyCode = cast<string>( mysql_get_field_value( result, "currency_code" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		Locked = cast<double>( mysql_get_field_value( result, "locked" ) );
		Time = cast<string>( mysql_get_field_value( result, "time" ) );
	}

	public void update() modify {
		// UPDATE: not yet implemented
	}

	public bool operator==( TBalanceRecord other const ) const {
		return Id == other.Id;
	}

	public string =operator( string ) const {
		return "TBalanceRecord { '" + AccountId + "', '" + Available + "', '" + CurrencyCode + "', '" + Id + "', '" + Locked + "', NULLIF('" + Time + "', '') }";
	}

	private int DB const;
}


public object TBalanceCollection implements ICollection { //<TBalanceRecord> {
	public void Constructor( int databaseHandle, string query = "" ) {
		Collection = new Vector<TBalanceRecord>();
		DB = databaseHandle;

		if ( query ) {
			loadByQuery( query );
		}
	}

	public TBalanceRecord at( int index ) const throws {
		return Collection.at( index );
	}

	public bool empty() const {
		return Collection.empty();
	}

	public TBalanceRecord first() const {
		return Collection.first();
	}

	public Iterator<TBalanceRecord> getIterator() const {
		return Collection.getIterator();
	}

	public TBalanceRecord last() const {
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
			var record = new TBalanceRecord( DB );
			record.loadByResult( result );

			Collection.push_back( record );
		}
	}

	public void loadByResult( int result ) modify throws {
		Collection.clear();

		while ( mysql_fetch_row( result ) ) {
			var record = new TBalanceRecord( DB );
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

	public void push_back( TBalanceRecord item ) modify {
		Collection.push_back( item );
	}

	private Vector<TBalanceRecord> Collection;
	private int DB const;
}


