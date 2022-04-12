#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.Database.Tables.BotTransaction;
import libs.Plugins.ExecutePlugin;


public object ExecutePlugin {
	public bool Execute( int argc, string args ) modify throws {
		if ( !isSet( "amount" ) ) {
			throw "missing amount!";
		}
		if ( !isSet( "average_course" ) ) {
			throw "missing average_course!";
		}
		if ( !isSet( "bot_id" ) ) {
			throw "missing bot_id!";
		}
		if ( !isSet( "created" ) ) {
			throw "missing created!";
		}
		if ( !isSet( "instrument_code" ) ) {
			throw "missing instrument_code!";
		}
		if ( !isSet( "side" ) ) {
			throw "missing side!";
		}

		var amount = cast<double>( mysql_real_escape_string( Database.Handle, get( "amount" ) ) );
		var averageCourse = cast<double>( mysql_real_escape_string( Database.Handle, get( "average_course" ) ) );
		var botId = cast<int>( mysql_real_escape_string( Database.Handle, get( "bot_id" ) ) );
		var created = mysql_real_escape_string( Database.Handle, get( "created" ) );
		var fee = cast<double>( mysql_real_escape_string( Database.Handle, get( "fee" ) ) );
		var instrumentCode = mysql_real_escape_string( Database.Handle, get( "instrument_code" ) );
		var side = mysql_real_escape_string( Database.Handle, get( "side" ) );

		var transaction = new TBotTransactionRecord( Database.Handle );

		transaction.Amount = amount;
		transaction.AverageCourse = averageCourse;
		transaction.BotId = botId;
		transaction.Created = created;
		transaction.Fee = fee;
		transaction.InstrumentCode = instrumentCode;
		transaction.Side = side;

		transaction.insertOrUpdate();

		return true;
	}
}

