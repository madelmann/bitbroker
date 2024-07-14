
import System.Collections.Vector;

public object TUserDataRecord {
   public string Email;
   public int Id;
   public string Identifier;
   public string Prename;
   public string Surname;

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
        var query = "DELETE FROM user_data WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insert( bool reloadAfterInsert = false ) modify throws {
        var query = "INSERT INTO user_data ( `email`, `id`, `identifier`, `prename`, `surname` ) VALUES ( '" + Email + "', '" + Id + "', '" + Identifier + "', '" + Prename + "', '" + Surname + "' )";

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
        var query = "INSERT IGNORE INTO user_data ( `email`, `id`, `identifier`, `prename`, `surname` ) VALUES ( '" + Email + "', '" + Id + "', '" + Identifier + "', '" + Prename + "', '" + Surname + "' )";

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
        var query = "INSERT INTO user_data ( `email`, `id`, `identifier`, `prename`, `surname` ) VALUES ( '" + Email + "', '" + Id + "', '" + Identifier + "', '" + Prename + "', '" + Surname + "' ) ON DUPLICATE KEY UPDATE `email` = '" + Email + "', `identifier` = '" + Identifier + "', `prename` = '" + Prename + "', `surname` = '" + Surname + "'";

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

       Email = cast<string>( mysql_get_field_value( result, "email" ) );
       Id = cast<int>( mysql_get_field_value( result, "id" ) );
       Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
       Prename = cast<string>( mysql_get_field_value( result, "prename" ) );
       Surname = cast<string>( mysql_get_field_value( result, "surname" ) );
    }

    public void loadByPrimaryKey( int id ) modify throws {
        var query = "SELECT * FROM user_data WHERE id = '" + id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !mysql_fetch_row( result ) ) {
            throw "no result found";
        }

       Email = cast<string>( mysql_get_field_value( result, "email" ) );
       Id = cast<int>( mysql_get_field_value( result, "id" ) );
       Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
       Prename = cast<string>( mysql_get_field_value( result, "prename" ) );
       Surname = cast<string>( mysql_get_field_value( result, "surname" ) );
    }

    public void loadByResult( int result ) modify {
       Email = cast<string>( mysql_get_field_value( result, "email" ) );
       Id = cast<int>( mysql_get_field_value( result, "id" ) );
       Identifier = cast<string>( mysql_get_field_value( result, "identifier" ) );
       Prename = cast<string>( mysql_get_field_value( result, "prename" ) );
       Surname = cast<string>( mysql_get_field_value( result, "surname" ) );
    }

    public void update( bool reloadAfterUpdate = false ) modify throws {
        var query = "UPDATE user_data SET `email` = '" + Email + "', `identifier` = '" + Identifier + "', `prename` = '" + Prename + "', `surname` = '" + Surname + "' WHERE id = '" + Id + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        if ( reloadAfterUpdate ) {
            loadByPrimaryKey( Id );
        }
    }

    public bool operator==( TUserDataRecord other const ) const {
        return Id == other.Id;
    }

    public string =operator( string ) const {
        return "TUserDataRecord { '" + Email + "', '" + Id + "', '" + Identifier + "', '" + Prename + "', '" + Surname + "' }";
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


public object TUserDataCollection implements ICollection { //<TUserDataRecord> {
    public void Constructor( int databaseHandle, string query = "" ) {
        Collection = new Vector<TUserDataRecord>();
        DB = databaseHandle;

        if ( query ) {
            loadByQuery( query );
        }
    }

    public TUserDataRecord at( int index ) const throws {
        return Collection.at( index );
    }

    public bool empty() const {
        return Collection.empty();
    }

    public TUserDataRecord first() const {
        return Collection.first();
    }

    public Iterator<TUserDataRecord> getIterator() const {
        return Collection.getIterator();
    }

    public TUserDataRecord last() const {
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
            var record = new TUserDataRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void loadByResult( int result ) modify throws {
        Collection.clear();

        while ( mysql_fetch_row( result ) ) {
            var record = new TUserDataRecord( DB );
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

    public void push_back( TUserDataRecord item ) modify {
        Collection.push_back( item );
    }

    private Vector<TUserDataRecord> Collection;
    private int DB const;
}


