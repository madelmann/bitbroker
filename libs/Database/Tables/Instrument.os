
import System.Collections.Vector;

public object TInstrumentRecord {
   public int AmountPrecision;
   public string Base;
   public string Code;
   public int Id;
   public int MarketPrecision;
   public double MinSize;
   public string Quote;
   public string State;

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
        var query = "DELETE FROM instrument WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insert( bool reloadAfterInsert = false ) modify throws {
        var query = "INSERT INTO instrument ( `amount_precision`, `base`, `code`, `id`, `market_precision`, `min_size`, `quote`, `state` ) VALUES ( '" + AmountPrecision + "', '" + Base + "', '" + Code + "', '" + Id + "', '" + MarketPrecision + "', '" + MinSize + "', '" + Quote + "', '" + State + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        if ( reloadAfterInsert ) {
            if ( !Id ) {
                Id = getLastInsertId();
            }

            loadByPrimaryKey( Id );
        }
    }

    public void insertIgnore( bool reloadAfterInsert = false ) modify throws {
        var query = "INSERT IGNORE INTO instrument ( `amount_precision`, `base`, `code`, `id`, `market_precision`, `min_size`, `quote`, `state` ) VALUES ( '" + AmountPrecision + "', '" + Base + "', '" + Code + "', '" + Id + "', '" + MarketPrecision + "', '" + MinSize + "', '" + Quote + "', '" + State + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        if ( reloadAfterInsert ) {
            if ( !Id ) {
                Id = getLastInsertId();
            }

            loadByPrimaryKey( Id );
        }
    }

    public void insertOrUpdate( bool reloadAfterInsert = false ) modify throws {
        var query = "INSERT INTO instrument ( `amount_precision`, `base`, `code`, `id`, `market_precision`, `min_size`, `quote`, `state` ) VALUES ( '" + AmountPrecision + "', '" + Base + "', '" + Code + "', '" + Id + "', '" + MarketPrecision + "', '" + MinSize + "', '" + Quote + "', '" + State + "' ) ON DUPLICATE KEY UPDATE `amount_precision` = '" + AmountPrecision + "', `base` = '" + Base + "', `code` = '" + Code + "', `market_precision` = '" + MarketPrecision + "', `min_size` = '" + MinSize + "', `quote` = '" + Quote + "', `state` = '" + State + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        if ( reloadAfterInsert ) {
            if ( !Id ) {
                Id = getLastInsertId();
            }

            loadByPrimaryKey( Id );
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

       AmountPrecision = cast<int>( mysql_get_field_value( result, "amount_precision" ) );
       Base = cast<string>( mysql_get_field_value( result, "base" ) );
       Code = cast<string>( mysql_get_field_value( result, "code" ) );
       Id = cast<int>( mysql_get_field_value( result, "id" ) );
       MarketPrecision = cast<int>( mysql_get_field_value( result, "market_precision" ) );
       MinSize = cast<double>( mysql_get_field_value( result, "min_size" ) );
       Quote = cast<string>( mysql_get_field_value( result, "quote" ) );
       State = cast<string>( mysql_get_field_value( result, "state" ) );
    }

    public void loadByPrimaryKey( int id ) modify throws {
        var query = "SELECT * FROM instrument WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !mysql_fetch_row( result ) ) {
            throw "no result found";
        }

       AmountPrecision = cast<int>( mysql_get_field_value( result, "amount_precision" ) );
       Base = cast<string>( mysql_get_field_value( result, "base" ) );
       Code = cast<string>( mysql_get_field_value( result, "code" ) );
       Id = cast<int>( mysql_get_field_value( result, "id" ) );
       MarketPrecision = cast<int>( mysql_get_field_value( result, "market_precision" ) );
       MinSize = cast<double>( mysql_get_field_value( result, "min_size" ) );
       Quote = cast<string>( mysql_get_field_value( result, "quote" ) );
       State = cast<string>( mysql_get_field_value( result, "state" ) );
    }

    public void loadByResult( int result ) modify {
       AmountPrecision = cast<int>( mysql_get_field_value( result, "amount_precision" ) );
       Base = cast<string>( mysql_get_field_value( result, "base" ) );
       Code = cast<string>( mysql_get_field_value( result, "code" ) );
       Id = cast<int>( mysql_get_field_value( result, "id" ) );
       MarketPrecision = cast<int>( mysql_get_field_value( result, "market_precision" ) );
       MinSize = cast<double>( mysql_get_field_value( result, "min_size" ) );
       Quote = cast<string>( mysql_get_field_value( result, "quote" ) );
       State = cast<string>( mysql_get_field_value( result, "state" ) );
    }

    public void update( bool reloadAfterUpdate = false ) modify throws {
        var query = "UPDATE instrument SET `amount_precision` = '" + AmountPrecision + "', `base` = '" + Base + "', `code` = '" + Code + "', `market_precision` = '" + MarketPrecision + "', `min_size` = '" + MinSize + "', `quote` = '" + Quote + "', `state` = '" + State + "' WHERE id = '" + Id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        if ( reloadAfterUpdate ) {
            loadByPrimaryKey( Id );
        }
    }

    public bool operator==( TInstrumentRecord other const ) const {
        return Id == other.Id;
    }

    public string =operator( string ) const {
        return "TInstrumentRecord { '" + AmountPrecision + "', '" + Base + "', '" + Code + "', '" + Id + "', '" + MarketPrecision + "', '" + MinSize + "', '" + Quote + "', '" + State + "' }";
    }

    private int getLastInsertId() const throws {
        var query = "SELECT LAST_INSERT_ID() AS id;";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !result ) {
            throw mysql_error( DB );
        }

        if ( !mysql_fetch_row( result ) ) {
            throw mysql_error( DB );
        }

        return cast<int>( mysql_get_field_value( result, "id" ) );
    }

    private int DB const;
}


public object TInstrumentCollection implements ICollection { //<TInstrumentRecord> {
    public void Constructor( int databaseHandle, string query = "" ) {
        Collection = new Vector<TInstrumentRecord>();
        DB = databaseHandle;

        if ( query ) {
            loadByQuery( query );
        }
    }

    public TInstrumentRecord at( int index ) const throws {
        return Collection.at( index );
    }

    public bool empty() const {
        return Collection.empty();
    }

    public TInstrumentRecord first() const {
        return Collection.first();
    }

    public Iterator<TInstrumentRecord> getIterator() const {
        return Collection.getIterator();
    }

    public TInstrumentRecord last() const {
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
            var record = new TInstrumentRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void loadByResult( int result ) modify throws {
        Collection.clear();

        while ( mysql_fetch_row( result ) ) {
            var record = new TInstrumentRecord( DB );
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

    public void push_back( TInstrumentRecord item ) modify {
        Collection.push_back( item );
    }

    private Vector<TInstrumentRecord> Collection;
    private int DB const;
}


