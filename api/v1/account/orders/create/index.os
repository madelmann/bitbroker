#!/usr/local/bin/webscript

// Library imports
import libJson.Reader;

// Project imports
import libs.API.Utils;
import libs.MainProcessJsonDB;
import libs.OrderEngine.OrderEngine;


public void Process( int argc, string args ) modify throws {
	if ( getenv( "CONTENT_TYPE" ) != "application/json" ) {
		throw "wrong content type";
	}

	API.VerifyAccount();

	var requestStr = post( "REQUEST" );
	//print( "Request: '" + requestStr + "'" );

	if ( !requestStr ) {
		throw "empty request";
	}

	var reader = new JsonReader();
	var request = JsonObject reader.parse( requestStr );

	if ( !request.isMember( "amount" ) ) {
		throw "amount missing";
	}
	if ( !request.isMember( "instrument_code" ) ) {
		throw "instrument_code missing";
	}
	if ( !request.isMember( "side" ) ) {
		throw "side missing";
	}
	if ( !request.isMember( "type" ) ) {
		throw "type missing";
	}

	var account_id = mysql_real_escape_string( Database.Handle, get( "account_id" ) );
	var amount = request[ "amount" ].asDouble();
	var instrument_code = request[ "instrument_code" ].asString();
	var side = request[ "side" ].asString();
	var type = request[ "type" ].asString();

	double price;
	if ( type == "LIMIT" ) {
		if ( !request.isMember( "price" ) ) {
			throw "price missing";
		}

		price = request[ "price" ].asDouble();
	}


	// either a valid order is returned or an exception will be thrown
	var order = OrderEngine.CreateOrder( account_id, amount, instrument_code, price, side, type );

	Json.AddElement( "order_id", order.OrderId );
	Json.AddElement( "account_id", order.AccountId );
	Json.AddElement( "amount", order.Amount );
	Json.AddElement( "filled_amount", order.FilledAmount );
	Json.AddElement( "instrument_code", order.InstrumentCode );
	Json.AddElement( "price", order.Price );
	Json.AddElement( "side", order.Side );
	Json.AddElement( "time", order.Created );
	Json.AddElement( "type", order.Type );
}

