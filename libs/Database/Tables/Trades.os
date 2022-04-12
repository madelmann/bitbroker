
import System.Collections.Vector;

public object TTradesRecord {
	public string AccountId;
	public double Amount;
	public int Id;
	public string OrderId;
	public double Price;
	public string TradeId;

	public void Constructor( int databaseHandle ) {
		DB = databaseHandle;
	}

	public void Constructor( int databaseHandle, string query ) {
		DB = databaseHandle;

		loadByQuery( query );
	}

	public void insert() modify throws {
		string query = "INSERT INTO trades ( `account_id`, `amount`, `id`, `order_id`, `price`, `trade_id` ) VALUES ( '" + AccountId + "', '" + Amount + "', '" + Id + "', '" + OrderId + "', '" + Price + "', '" + TradeId + "' )";

		int error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insertOrUpdate() modify throws {
		string query = "INSERT INTO trades ( `account_id`, `amount`, `id`, `order_id`, `price`, `trade_id` ) VALUES ( '" + AccountId + "', '" + Amount + "', '" + Id + "', '" + OrderId + "', '" + Price + "', '" + TradeId + "' ) ON DUPLICATE KEY UPDATE `account_id` = '" + AccountId + "', `amount` = '" + Amount + "', `order_id` = '" + OrderId + "', `price` = '" + Price + "', `trade_id` = '" + TradeId + "'";

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

		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Amount = cast<double>( mysql_get_field_value( result, "amount" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		TradeId = cast<string>( mysql_get_field_value( result, "trade_id" ) );
	}

	public void loadByPrimaryKey( int id ) modify throws {
		string query = "SELECT * FROM trades WHERE id = '" + id + "'";

		int error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}

		int result = mysql_store_result( DB );
		if ( !mysql_fetch_row( result ) ) {
			throw "no result found";
		}

		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Amount = cast<double>( mysql_get_field_value( result, "amount" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		TradeId = cast<string>( mysql_get_field_value( result, "trade_id" ) );
	}

	public void loadByResult( int result ) modify {
		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Amount = cast<double>( mysql_get_field_value( result, "amount" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		TradeId = cast<string>( mysql_get_field_value( result, "trade_id" ) );
	}

	public void update() modify {
		// UPDATE: not yet implemented
	}

	public bool operator==( TTradesRecord other const ) const {
		return Id == other.Id;
	}

	public string =operator( string ) const {
		return "TTradesRecord { '" + AccountId + "', '" + Amount + "', '" + Id + "', '" + OrderId + "', '" + Price + "', '" + TradeId + "' }";
	}

	private int DB const;
}


public object TTradesCollection {
	public void Constructor( int databaseHandle, string query = "" ) {
		Collection = new Vector<TTradesRecord>();
		DB = databaseHandle;

		if ( query ) {
			loadByQuery( query );
		}
	}

	public TTradesRecord at( int index ) const throws {
		return Collection.at( index );
	}

	public Iterator<TTradesRecord> getIterator() const {
		return new Iterator<TTradesRecord>( ICollection Collection );
	}

	public void loadByQuery( string query ) modify throws {
		int error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}

		Collection.clear();

		int result = mysql_store_result( DB );
		while ( mysql_fetch_row( result ) ) {
			var record = new TTradesRecord( DB );
			record.loadByResult( result );

			Collection.push_back( record );
		}
	}

	private Vector<TTradesRecord> Collection;
	private int DB const;
}

