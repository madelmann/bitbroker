
import System.Collections.Vector;

public object TMarketTickerRecord {
	public double BestAsk;
	public double BestBid;
	public int Id;
	public string InstrumentCode;
	public double LastPrice;
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
		var query = "DELETE FROM market_ticker WHERE id = '" + id + "'";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insert() modify throws {
		var query = "INSERT INTO market_ticker ( `best_ask`, `best_bid`, `id`, `instrument_code`, `last_price`, `time` ) VALUES ( '" + BestAsk + "', '" + BestBid + "', '" + Id + "', '" + InstrumentCode + "', '" + LastPrice + "', NULLIF('" + Time + "', '') )";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insertOrUpdate() modify throws {
		var query = "INSERT INTO market_ticker ( `best_ask`, `best_bid`, `id`, `instrument_code`, `last_price`, `time` ) VALUES ( '" + BestAsk + "', '" + BestBid + "', '" + Id + "', '" + InstrumentCode + "', '" + LastPrice + "', NULLIF('" + Time + "', '') ) ON DUPLICATE KEY UPDATE `best_ask` = '" + BestAsk + "', `best_bid` = '" + BestBid + "', `instrument_code` = '" + InstrumentCode + "', `last_price` = '" + LastPrice + "', `time` = NULLIF('" + Time + "', '')";

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

		BestAsk = cast<double>( mysql_get_field_value( result, "best_ask" ) );
		BestBid = cast<double>( mysql_get_field_value( result, "best_bid" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		LastPrice = cast<double>( mysql_get_field_value( result, "last_price" ) );
		Time = cast<string>( mysql_get_field_value( result, "time" ) );
	}

	public void loadByPrimaryKey( int id ) modify throws {
		var query = "SELECT * FROM market_ticker WHERE id = '" + id + "'";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}

		var result = mysql_store_result( DB );
		if ( !mysql_fetch_row( result ) ) {
			throw "no result found";
		}

		BestAsk = cast<double>( mysql_get_field_value( result, "best_ask" ) );
		BestBid = cast<double>( mysql_get_field_value( result, "best_bid" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		LastPrice = cast<double>( mysql_get_field_value( result, "last_price" ) );
		Time = cast<string>( mysql_get_field_value( result, "time" ) );
	}

	public void loadByResult( int result ) modify {
		BestAsk = cast<double>( mysql_get_field_value( result, "best_ask" ) );
		BestBid = cast<double>( mysql_get_field_value( result, "best_bid" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		LastPrice = cast<double>( mysql_get_field_value( result, "last_price" ) );
		Time = cast<string>( mysql_get_field_value( result, "time" ) );
	}

	public void update() modify {
		// UPDATE: not yet implemented
	}

	public bool operator==( TMarketTickerRecord other const ) const {
		return Id == other.Id;
	}

	public string =operator( string ) const {
		return "TMarketTickerRecord { '" + BestAsk + "', '" + BestBid + "', '" + Id + "', '" + InstrumentCode + "', '" + LastPrice + "', NULLIF('" + Time + "', '') }";
	}

	private int DB const;
}


public object TMarketTickerCollection implements ICollection { //<TMarketTickerRecord> {
	public void Constructor( int databaseHandle, string query = "" ) {
		Collection = new Vector<TMarketTickerRecord>();
		DB = databaseHandle;

		if ( query ) {
			loadByQuery( query );
		}
	}

	public TMarketTickerRecord at( int index ) const throws {
		return Collection.at( index );
	}

	public bool empty() const {
		return Collection.empty();
	}

	public TMarketTickerRecord first() const {
		return Collection.first();
	}

	public Iterator<TMarketTickerRecord> getIterator() const {
		return new Iterator<TMarketTickerRecord>( cast<ICollection>( Collection ) );
	}

	public TMarketTickerRecord last() const {
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
			var record = new TMarketTickerRecord( DB );
			record.loadByResult( result );

			Collection.push_back( record );
		}
	}

	public void loadByResult( int result ) modify throws {
		Collection.clear();

		while ( mysql_fetch_row( result ) ) {
			var record = new TMarketTickerRecord( DB );
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

	public void push_back( TMarketTickerRecord item ) modify {
		Collection.push_back( item );
	}

	private Vector<TMarketTickerRecord> Collection;
	private int DB const;
}


