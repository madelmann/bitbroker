
import System.Collections.Vector;

public object TTradeRecord {
	public string AccountId;
	public double Amount;
	public int Id;
	public string InstrumentCode;
	public string OrderId;
	public double Price;
	public string Side;
	public string Time;
	public string TradeId;

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
        var query = "DELETE FROM trade WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insert() modify throws {
        var query = "INSERT INTO trade ( `account_id`, `amount`, `id`, `instrument_code`, `order_id`, `price`, `side`, `time`, `trade_id` ) VALUES ( '" + AccountId + "', '" + Amount + "', '" + Id + "', '" + InstrumentCode + "', '" + OrderId + "', '" + Price + "', '" + Side + "', NULLIF('" + Time + "', ''), '" + TradeId + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insertOrUpdate() modify throws {
        var query = "INSERT INTO trade ( `account_id`, `amount`, `id`, `instrument_code`, `order_id`, `price`, `side`, `time`, `trade_id` ) VALUES ( '" + AccountId + "', '" + Amount + "', '" + Id + "', '" + InstrumentCode + "', '" + OrderId + "', '" + Price + "', '" + Side + "', NULLIF('" + Time + "', ''), '" + TradeId + "' ) ON DUPLICATE KEY UPDATE `account_id` = '" + AccountId + "', `amount` = '" + Amount + "', `instrument_code` = '" + InstrumentCode + "', `order_id` = '" + OrderId + "', `price` = '" + Price + "', `side` = '" + Side + "', `time` = NULLIF('" + Time + "', ''), `trade_id` = '" + TradeId + "'";

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
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		Side = cast<string>( mysql_get_field_value( result, "side" ) );
		Time = cast<string>( mysql_get_field_value( result, "time" ) );
		TradeId = cast<string>( mysql_get_field_value( result, "trade_id" ) );
    }

    public void loadByPrimaryKey( int id ) modify throws {
        var query = "SELECT * FROM trade WHERE id = '" + id + "'";

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
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		Side = cast<string>( mysql_get_field_value( result, "side" ) );
		Time = cast<string>( mysql_get_field_value( result, "time" ) );
		TradeId = cast<string>( mysql_get_field_value( result, "trade_id" ) );
    }

    public void loadByResult( int result ) modify {
		AccountId = cast<string>( mysql_get_field_value( result, "account_id" ) );
		Amount = cast<double>( mysql_get_field_value( result, "amount" ) );
		Id = cast<int>( mysql_get_field_value( result, "id" ) );
		InstrumentCode = cast<string>( mysql_get_field_value( result, "instrument_code" ) );
		OrderId = cast<string>( mysql_get_field_value( result, "order_id" ) );
		Price = cast<double>( mysql_get_field_value( result, "price" ) );
		Side = cast<string>( mysql_get_field_value( result, "side" ) );
		Time = cast<string>( mysql_get_field_value( result, "time" ) );
		TradeId = cast<string>( mysql_get_field_value( result, "trade_id" ) );
    }

    public void update() modify {
		// UPDATE: not yet implemented
    }

    public bool operator==( TTradeRecord other const ) const {
        return Id == other.Id;
    }

    public string =operator( string ) const {
        return "TTradeRecord { '" + AccountId + "', '" + Amount + "', '" + Id + "', '" + InstrumentCode + "', '" + OrderId + "', '" + Price + "', '" + Side + "', NULLIF('" + Time + "', ''), '" + TradeId + "' }";
    }

    private int DB const;
}


public object TTradeCollection implements ICollection { //<TTradeRecord> {
    public void Constructor( int databaseHandle, string query = "" ) {
        Collection = new Vector<TTradeRecord>();
        DB = databaseHandle;

        if ( query ) {
            loadByQuery( query );
        }
    }

    public TTradeRecord at( int index ) const throws {
        return Collection.at( index );
    }

    public bool empty() const {
        return Collection.empty();
    }

    public TTradeRecord first() const {
        return Collection.first();
    }

    public Iterator<TTradeRecord> getIterator() const {
        return Collection.getIterator();
    }

    public TTradeRecord last() const {
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
            var record = new TTradeRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void loadByResult( int result ) modify throws {
        Collection.clear();

        while ( mysql_fetch_row( result ) ) {
            var record = new TTradeRecord( DB );
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

    public void push_back( TTradeRecord item ) modify {
        Collection.push_back( item );
    }

    private Vector<TTradeRecord> Collection;
    private int DB const;
}


