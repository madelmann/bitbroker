#!/usr/bin/env webscript

// Library imports

// Project imports
import libs.API.Utils;
import libs.Database.Tables.Trade;
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) throws {
	API.VerifyAccount();

	var accountId = API.retrieve( "account_id" );
	var tradeId   = API.retrieve( "trade_id", "" );

	if ( tradeId ) {
		retrieveSingleTrade( accountId, tradeId );
	}
	else {
		retrieveAllTrades( accountId );
	}
}

private void retrieveAllTrades( string accountId ) throws {
	var collection = new TTradeCollection( Database.Handle );
	collection.loadByQuery( "SELECT * FROM trade WHERE account_id = '" + accountId + "'" );

	Json.BeginArray( "trades" );
	foreach ( TTradeRecord trade : collection ) {
		Json.BeginObject();
		Json.AddElement( "account_id", trade.AccountId );
		Json.AddElement( "trade_id", trade.TradeId );
		Json.AddElement( "order_id", trade.OrderId );
		Json.AddElement( "instrument_code", trade.InstrumentCode );
		Json.AddElement( "side", trade.Side );
		Json.AddElement( "amount", trade.Amount );
		Json.AddElement( "price", trade.Price );
		Json.AddElement( "time", trade.Time );
		Json.EndObject();
	}
	Json.EndArray();
}

private void retrieveSingleTrade( string accountId, string tradeId ) throws {
	var trade = new TTradeRecord( Database.Handle );
	trade.loadByQuery( "SELECT * FROM trade WHERE account_id = '" + accountId + "' AND trade_id = '" + tradeId + "' LIMIT 1" );

	Json.AddElement( "account_id", trade.AccountId );
	Json.AddElement( "trade_id", trade.TradeId );
	Json.AddElement( "order_id", trade.OrderId );
	Json.AddElement( "instrument_code", trade.InstrumentCode );
	Json.AddElement( "side", trade.Side );
	Json.AddElement( "amount", trade.Amount );
	Json.AddElement( "price", trade.Price );
	Json.AddElement( "time", trade.Time );
}

