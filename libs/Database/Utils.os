
import Database;

public namespace Database {

	////////////////////////////////////////////////////////////////////////////////
	// Query utils

	public bool Execute( string query ) throws {
		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		return true;
	}

	public int Query( string query ) throws {
		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		int result = mysql_store_result( Database.Handle );
		if ( !result ) {
			throw mysql_error( Database.Handle );
		}

		return result;
	}

	// Query utils
	////////////////////////////////////////////////////////////////////////////////

	public int getLastInsertId() const throws {
		string query = "SELECT LAST_INSERT_ID() AS id;";

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		int result = mysql_store_result( Database.Handle );
		if ( !result ) {
			throw mysql_error( Database.Handle );
		}

		if ( !mysql_fetch_row( result ) ) {
			throw mysql_error( Database.Handle );
		}

		return cast<int>( mysql_get_field_value( result, "id" ) );
	}

	public string retrieveField( string table, string field, string id ) throws {
		if ( !field || !id || !table ) {
			throw "invalid query data provided!";
		}

		string query = "SELECT " + field + " FROM " + table + " WHERE id = " + id;

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		int result = mysql_store_result( Database.Handle );
		if ( !mysql_fetch_row( result ) ) {
			throw mysql_error( Database.Handle );
		}

		return mysql_get_field_value( result, field );
	}

	public bool updateField( string table, string field, string id, string value ) throws {
		if ( !field || !id || !table ) {
			return false;
		}

		string query = "UPDATE " + table + " SET " + field + " = '" + value + "' WHERE id = " + id;

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		return true;
	}

}

