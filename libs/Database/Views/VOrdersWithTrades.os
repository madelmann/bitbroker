
import System.Collections.Vector;

public object VOrdersWithTradesRecord {
	public string AccountId;
	public double Amount;
	public string Created;
	public double FilledAmount;
	public string Finished;
	public string Id;
	public string InstrumentCode;
	public string LastModified;
	public string OrderId;
	public double Price;
	public string Side;
	public int StatusId;
	public double TradeAmount;
	public string TradeId;
	public double TradePrice;
	public string TradeTime;
	public string Type;

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

		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Amount = cast<double>( mysql_get_field_value( result, "amount" ) );
		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		FilledAmount = cast<double>( mysql_get_field_value( result, "filled_amount" ) );
		Finished = cast<string>( mysql_get_field_value( result, "finished" ) );
		Id = cast<string>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		LastModified = cast<string>( mysql_get_field_value( result, "last_modified" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		Side = cast<string>( mysql_get_field_value( result, "side" ) );
		StatusId = cast<int>( mysql_get_field_value( result, "status_id" ) );
		TradeAmount = cast<double>( mysql_get_field_value( result, "trade_amount" ) );
		TradeId = cast<string>( mysql_get_field_value( result, "trade_id" ) );
		TradePrice = cast<double>( mysql_get_field_value( result, "trade_price" ) );
		TradeTime = cast<string>( mysql_get_field_value( result, "trade_time" ) );
		Type = cast<string>( mysql_get_field_value( result, "type" ) );
	}

	public void loadByPrimaryKey( string id ) modify throws {
		var query = "SELECT * FROM v_orders_with_trades WHERE id = '" + id + "'";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}

		var result = mysql_store_result( DB );
		if ( !mysql_fetch_row( result ) ) {
			throw "no result found";
		}

		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Amount = cast<double>( mysql_get_field_value( result, "amount" ) );
		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		FilledAmount = cast<double>( mysql_get_field_value( result, "filled_amount" ) );
		Finished = cast<string>( mysql_get_field_value( result, "finished" ) );
		Id = cast<string>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		LastModified = cast<string>( mysql_get_field_value( result, "last_modified" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		Side = cast<string>( mysql_get_field_value( result, "side" ) );
		StatusId = cast<int>( mysql_get_field_value( result, "status_id" ) );
		TradeAmount = cast<double>( mysql_get_field_value( result, "trade_amount" ) );
		TradeId = cast<string>( mysql_get_field_value( result, "trade_id" ) );
		TradePrice = cast<double>( mysql_get_field_value( result, "trade_price" ) );
		TradeTime = cast<string>( mysql_get_field_value( result, "trade_time" ) );
		Type = cast<string>( mysql_get_field_value( result, "type" ) );
	}

	public void loadByResult( int result ) modify {
		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Amount = cast<double>( mysql_get_field_value( result, "amount" ) );
		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		FilledAmount = cast<double>( mysql_get_field_value( result, "filled_amount" ) );
		Finished = cast<string>( mysql_get_field_value( result, "finished" ) );
		Id = cast<string>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		LastModified = cast<string>( mysql_get_field_value( result, "last_modified" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		Side = cast<string>( mysql_get_field_value( result, "side" ) );
		StatusId = cast<int>( mysql_get_field_value( result, "status_id" ) );
		TradeAmount = cast<double>( mysql_get_field_value( result, "trade_amount" ) );
		TradeId = cast<string>( mysql_get_field_value( result, "trade_id" ) );
		TradePrice = cast<double>( mysql_get_field_value( result, "trade_price" ) );
		TradeTime = cast<string>( mysql_get_field_value( result, "trade_time" ) );
		Type = cast<string>( mysql_get_field_value( result, "type" ) );
	}

	public bool operator==( VOrdersWithTradesRecord other const ) const {
		return Id == other.Id;
	}

	public string =operator( string ) const {
		return "VOrdersWithTradesRecord { '" + AccountId + "', '" + Amount + "', NULLIF('" + Created + "', ''), '" + FilledAmount + "', NULLIF('" + Finished + "', ''), '" + Id + "', '" + InstrumentCode + "', NULLIF('" + LastModified + "', ''), '" + OrderId + "', '" + Price + "', '" + Side + "', '" + StatusId + "', '" + TradeAmount + "', '" + TradeId + "', '" + TradePrice + "', NULLIF('" + TradeTime + "', ''), '" + Type + "' }";
	}

	private int DB const;
}


public object VOrdersWithTradesCollection implements ICollection /*<VOrdersWithTradesRecord>*/ {
	public void Constructor( int databaseHandle, string query = "" ) {
		Collection = new Vector<VOrdersWithTradesRecord>();
		DB = databaseHandle;

		if ( query ) {
			loadByQuery( query );
		}
	}

	public VOrdersWithTradesRecord at( int index ) const throws {
		return Collection.at( index );
	}

	public bool empty() const {
		return Collection.empty();
	}

	public VOrdersWithTradesRecord first() const {
		return Collection.first();
	}

	public Iterator<VOrdersWithTradesRecord> getIterator() const {
		return Collection.getIterator();
	}

	public VOrdersWithTradesRecord last() const {
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
			var record = new VOrdersWithTradesRecord( DB );
			record.loadByResult( result );

			Collection.push_back( record );
		}
	}

	public void loadByResult( int result ) modify throws {
		Collection.clear();

		while ( mysql_fetch_row( result ) ) {
			var record = new VOrdersWithTradesRecord( DB );
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

	public void push_back( VOrdersWithTradesRecord item ) modify {
		Collection.push_back( item );
	}

	private Vector<VOrdersWithTradesRecord> Collection;
	private int DB const;
}

