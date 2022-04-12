
import System.Collections.Vector;

public object TOrdersRecord {
	public string AccountId;
	public double Amount;
	public string Created;
	public double FilledAmount;
	public string Finished;
	public int Id;
	public string InstrumentCode;
	public string OrderId;
	public double Price;
	public string Side;
	public int StatusId;
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

	public void deleteByPrimaryKey( int id ) modify throws {
		var query = "DELETE FROM orders WHERE id = '" + id + "'";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insert() modify throws {
		var query = "INSERT INTO orders ( `account_id`, `amount`, `created`, `filled_amount`, `finished`, `id`, `instrument_code`, `order_id`, `price`, `side`, `status_id`, `type` ) VALUES ( '" + AccountId + "', '" + Amount + "', NULLIF('" + Created + "', ''), '" + FilledAmount + "', NULLIF('" + Finished + "', ''), '" + Id + "', '" + InstrumentCode + "', '" + OrderId + "', '" + Price + "', '" + Side + "', '" + StatusId + "', '" + Type + "' )";

		var error = mysql_query( DB, query );
		if ( error ) {
			throw mysql_error( DB );
		}
	}

	public void insertOrUpdate() modify throws {
		var query = "INSERT INTO orders ( `account_id`, `amount`, `created`, `filled_amount`, `finished`, `id`, `instrument_code`, `order_id`, `price`, `side`, `status_id`, `type` ) VALUES ( '" + AccountId + "', '" + Amount + "', NULLIF('" + Created + "', ''), '" + FilledAmount + "', NULLIF('" + Finished + "', ''), '" + Id + "', '" + InstrumentCode + "', '" + OrderId + "', '" + Price + "', '" + Side + "', '" + StatusId + "', '" + Type + "' ) ON DUPLICATE KEY UPDATE `account_id` = '" + AccountId + "', `amount` = '" + Amount + "', `created` = NULLIF('" + Created + "', ''), `filled_amount` = '" + FilledAmount + "', `finished` = NULLIF('" + Finished + "', ''), `instrument_code` = '" + InstrumentCode + "', `order_id` = '" + OrderId + "', `price` = '" + Price + "', `side` = '" + Side + "', `status_id` = '" + StatusId + "', `type` = '" + Type + "'";

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
		Amount = cast<double>( mysql_get_field_value( result, "amount" ) );
		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		FilledAmount = cast<double>( mysql_get_field_value( result, "filled_amount" ) );
		Finished = cast<string>( mysql_get_field_value( result, "finished" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		Side = cast<string>( mysql_get_field_value( result, "side" ) );
		StatusId = cast<int>( mysql_get_field_value( result, "status_id" ) );
		Type = cast<string>( mysql_get_field_value( result, "type" ) );
	}

	public void loadByPrimaryKey( int id ) modify throws {
		var query = "SELECT * FROM orders WHERE id = '" + id + "'";

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
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		Side = cast<string>( mysql_get_field_value( result, "side" ) );
		StatusId = cast<int>( mysql_get_field_value( result, "status_id" ) );
		Type = cast<string>( mysql_get_field_value( result, "type" ) );
	}

	public void loadByResult( int result ) modify {
		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Amount = cast<double>( mysql_get_field_value( result, "amount" ) );
		Created = cast<string>( mysql_get_field_value( result, "created" ) );
		FilledAmount = cast<double>( mysql_get_field_value( result, "filled_amount" ) );
		Finished = cast<string>( mysql_get_field_value( result, "finished" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		Side = cast<string>( mysql_get_field_value( result, "side" ) );
		StatusId = cast<int>( mysql_get_field_value( result, "status_id" ) );
		Type = cast<string>( mysql_get_field_value( result, "type" ) );
	}

	public void update() modify {
		// UPDATE: not yet implemented
	}

	public bool operator==( TOrdersRecord other const ) const {
		return Id == other.Id;
	}

	public string =operator( string ) const {
		return "TOrdersRecord { '" + AccountId + "', '" + Amount + "', NULLIF('" + Created + "', ''), '" + FilledAmount + "', NULLIF('" + Finished + "', ''), '" + Id + "', '" + InstrumentCode + "', '" + OrderId + "', '" + Price + "', '" + Side + "', '" + StatusId + "', '" + Type + "' }";
	}

	private int DB const;
}


public object TOrdersCollection implements ICollection { //<TOrdersRecord> {
	public void Constructor( int databaseHandle, string query = "" ) {
		Collection = new Vector<TOrdersRecord>();
		DB = databaseHandle;

		if ( query ) {
			loadByQuery( query );
		}
	}

	public TOrdersRecord at( int index ) const throws {
		return Collection.at( index );
	}

	public bool empty() const {
		return Collection.empty();
	}

	public TOrdersRecord first() const {
		return Collection.first();
	}

	public Iterator<TOrdersRecord> getIterator() const {
		return new Iterator<TOrdersRecord>( cast<ICollection>( Collection ) );
	}

	public TOrdersRecord last() const {
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
			var record = new TOrdersRecord( DB );
			record.loadByResult( result );

			Collection.push_back( record );
		}
	}

	public void loadByResult( int result ) modify throws {
		Collection.clear();

		while ( mysql_fetch_row( result ) ) {
			var record = new TOrdersRecord( DB );
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

	public void push_back( TOrdersRecord item ) modify {
		Collection.push_back( item );
	}

	private Vector<TOrdersRecord> Collection;
	private int DB const;
}


