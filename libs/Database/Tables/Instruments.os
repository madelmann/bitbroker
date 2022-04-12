
import System.Collections.Vector;

public object TInstrumentsRecord {
	public int AmountPrecision;
	public string Code;
	public int Id;
	public int MarketPrecision;

	public void Constructor( int databaseHandle ) {
		DB = databaseHandle;
	}

	public void Constructor( int databaseHandle, string query ) {
		DB = databaseHandle;

		loadByQuery( query );
	}

	public void insert() modify throws {
		string query = "INSERT INTO instruments ( `amount_precision`, `code`, `id`, `market_precision` ) VALUES ( '" + AmountPrecision + "', '" + Code + "', '" + Id + "', '" + MarketPrecision + "' )";

		int error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insertOrUpdate() modify throws {
		string query = "INSERT INTO instruments ( `amount_precision`, `code`, `id`, `market_precision` ) VALUES ( '" + AmountPrecision + "', '" + Code + "', '" + Id + "', '" + MarketPrecision + "' ) ON DUPLICATE KEY UPDATE `amount_precision` = '" + AmountPrecision + "', `code` = '" + Code + "', `market_precision` = '" + MarketPrecision + "'";

		int error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void loadByQuery( string query ) modify throws {
		int error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}

		int result = mysql_store_result( DB );
		if ( !mysql_fetch_row( result ) ) {
			throw "no result found";
		}

		AmountPrecision = cast<int>( mysql_get_field_value( result, "amount_precision" ) );
		Code = cast<string>( mysql_get_field_value( result, "code" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		MarketPrecision = cast<int>( mysql_get_field_value( result, "market_precision" ) );
	}

	public void loadByPrimaryKey( int id ) modify throws {
		string query = "SELECT * FROM instruments WHERE id = '" + id + "'";

		int error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}

		int result = mysql_store_result( DB );
		if ( !mysql_fetch_row( result ) ) {
			throw "no result found";
		}

		AmountPrecision = cast<int>( mysql_get_field_value( result, "amount_precision" ) );
		Code = cast<string>( mysql_get_field_value( result, "code" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		MarketPrecision = cast<int>( mysql_get_field_value( result, "market_precision" ) );
	}

	public void loadByResult( int result ) modify {
		AmountPrecision = cast<int>( mysql_get_field_value( result, "amount_precision" ) );
		Code = cast<string>( mysql_get_field_value( result, "code" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		MarketPrecision = cast<int>( mysql_get_field_value( result, "market_precision" ) );
	}

	public void update() modify {
		// UPDATE: not yet implemented
	}

	public bool operator==( TInstrumentsRecord other const ) const {
		return Id == other.Id;
	}

	public string =operator( string ) const {
		return "TInstrumentsRecord { '" + AmountPrecision + "', '" + Code + "', '" + Id + "', '" + MarketPrecision + "' }";
	}

	private int DB const;
}


public object TInstrumentsCollection {
	public void Constructor( int databaseHandle, string query = "" ) {
		Collection = new Vector<TInstrumentsRecord>();
		DB = databaseHandle;

		if ( query ) {
			loadByQuery( query );
		}
	}

	public TInstrumentsRecord at( int index ) const throws {
		return Collection.at( index );
	}

	public Iterator<TInstrumentsRecord> getIterator() const {
		return new Iterator<TInstrumentsRecord>( ICollection Collection );
	}

	public void loadByQuery( string query ) modify throws {
		int error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}

		Collection.clear();

		int result = mysql_store_result( DB );
		while ( mysql_fetch_row( result ) ) {
			var record = new TInstrumentsRecord( DB );
			record.loadByResult( result );

			Collection.push_back( record );
		}
	}

	private Vector<TInstrumentsRecord> Collection;
	private int DB const;
}

