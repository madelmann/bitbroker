#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.Plugins.RenderPlugin;


public object RenderPlugin implements IRenderPlugin {
	public void Render() {
		pre( "
<h1>BitBroker</h1>

<p>
This is just a DEMO project and will never evolve into an actual broker. Nevertheless BitBroker should behave like a real (crypto) broker.
Within the 'demo' service path you can create an account at any time and also delete it after you have played around with BitBroker. Its also possible to deposit or withdraw assets from there.
The complete broker has been implemented in the Slang programming language.
</p>

<h2>API Documentation</h2>

<h3>Read first</h3>

<p>
POST requests require a JSON payload, GET requests use URL encoded parameters. All requests return JSON data.
Errors are reported in a 'message' field.
</p>

<h3>Authentication</h3>

<p>
All private API calls require providing an account_id with your request.
</p>

<h3>Demo</h3>

<p>
<h4>Create Account</h4>
<p>
Request: <a href='/api/v1/demo/account/create'>GET /api/v1/demo/account/create/</a>
</p>

<p>
Response:
<pre>
{
	\"account_id\": \"3ad99c176956667e2c3252f82e8c290c32d82c3c8c13f7f43ba45c6549362ad8\"
}
</pre>
</p>
</p>

<p>
<h4>Delete Account</h4>
<p>
Request: <a href='/api/v1/demo/account/delete'>GET /api/v1/demo/account/delete/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>account_id</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"result\": \"success\"
}
</pre>
</p>
</p>

<p>
<h4>Query Account</h4>
<p>
Request: <a href='/api/v1/demo/account/query'>GET /api/v1/demo/account/query/</a>
</p>

<p>
Response:
<pre>
{
	\"accounts\": [{
		\"account_id\": \"362cd92f7cc7b5895c3319a528a5831c1c0960efec8fefaf79760e5d38eb3da4\",
		\"time\": \"2021-01-09 12:49:01\"
	}, {
		\"account_id\": \"3ad99c176956667e2c3252f82e8c290c32d82c3c8c13f7f43ba45c6549362ad8\",
		\"time\": \"2021-01-09 12:30:52\"
	}, {
		\"account_id\": \"6b86b273ff34fce19d6b804eff5a3f57\",
		\"time\": \"2021-01-09 12:20:53\"
	}]
}
</pre>
</p>
</p>

<p>
<h4>Deposit</h4>
<p>
Request: <a href='/api/v1/demo/account/deposit'>GET /api/v1/demo/account/deposit/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>account_id</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>currency_code</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>amount</td>
		<td>float</td>
		<td>Yes</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"result\": \"success\"
}
</pre>
</p>
</p>

<p>
<h4>Withdraw</h4>
<p>
Request: <a href='/api/v1/demo/account/withdraw'>GET /api/v1/demo/account/withdraw/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>account_id</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>currency_code</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>amount</td>
		<td>float</td>
		<td>Yes</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"result\": \"success\"
}
</pre>
</p>
</p>


<h3>Public</h3>

<p>
<h4>Currencies</h4>

<p>
Request: <a href='/api/v1/currencies/'>GET /api/v1/currencies/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>currency_code</td>
		<td>string</td>
		<td>No</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"currencies\": [{
		\"code\": \"BTC\",
		\"precision\": 8
	}, {
		\"code\": \"ETH\",
		\"precision\": 8
	}, {
		\"code\": \"EUR\",
		\"precision\": 2
	}]
}
</pre>
</p>
</p>

<p>
<h4>Instruments</h4>

<p>
Request: <a href='/api/v1/instruments/'>GET /api/v1/instruments/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>instrument_code</td>
		<td>string</td>
		<td>No</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"instruments\": [{
		\"instrument_code\": \"BTC_EUR\",
		\"base\": \"BTC\",
		\"quote\": \"EUR\",
		\"amount_precision\": 2,
		\"market_precision\": 8,
		\"min_size\": 10
	}, {
		\"instrument_code\": \"ETH_EUR\",
		\"base\": \"ETH\",
		\"quote\": \"EUR\",
		\"amount_precision\": 2,
		\"market_precision\": 8,
		\"min_size\": 10
	}]
}
</pre>
</p>
</p>

<p>
<h4>Market Ticker</h4>

<p>
Request: <a href='/api/v1/marketticker/'>GET /api/v1/marketticker/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>instrument_code</td>
		<td>string</td>
		<td>No</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"instruments\": [{
		\"instrument_code\": \"ETH_EUR\",
		\"best_ask\": 1000,
		\"best_bid\": 900,
		\"last_price\": 900,
		\"time\": \"2021-01-09T11:27:00\"
	}]
}
</pre>
</p>
</p>

<p>
<h4>Order Book</h4>

<p>
Request: <a href='/api/v1/orderbook/'>GET /api/v1/orderbook/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>instrument_code</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"instrument_code\": \"ETH_EUR\",
	\"time\": \"2021-01-09T11:29:40\",
	\"asks\": [{
		\"amount\": 5,
		\"filled_amount\": 0.2,
		\"price\": 900
	}],
	\"bids\": [{
		\"amount\": 2,
		\"filled_amount\": 0.1,
		\"price\": 997
	}, {
		\"amount\": 0.5,
		\"filled_amount\": 0,
		\"price\": 999
	}]
}
</pre>
</p>
</p>

<p>
<h4>Ping</h4>

<p>
Request: <a href='/api/v1/ping/'>GET /api/v1/ping</a>
</p>

<p>
Request:
<pre>
{
	\"result\": \"pong\"
}
</pre>
</p>
</p>

<p>
<h4>Time</h4>

<p>
Request: <a href='/api/v1/time/'>GET /api/v1/time</a>
</p>

<p>
Response:
<pre>
{
	\"iso\": \"2021-01-09T11:31:32\",
	\"epoch\": 1610188292
}
</pre>
</p>
</p>


<h3>Private</h3>

<p>
<h4>Balances</h4>

<p>
Request: <a href='/api/v1/account/balances/'>GET /api/v1/account/balances/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>account_id</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>currency_code</td>
		<td>string</td>
		<td>No</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"account_id\": \"6b86b273ff34fce19d6b804eff5a3f57\",
	\"balances\": [{
		\"account_id\": \"6b86b273ff34fce19d6b804eff5a3f57\",
		\"currency_code\": \"EUR\",
		\"available\": 0,
		\"locked\": 0,
		\"time\": \"2021-01-08 12:32:56\"
	}]
}
</pre>
</p>
</p>

<p>
<h4>Cancel Order</h4>

<p>
Request: <a href='/api/v1/account/orders/cancel/'>GET /api/v1/account/orders/cancel/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>account_id</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>order_id</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"result\": \"success\"
}
</pre>
</p>
</p>

<p>
<h4>Create Order</h4>

<p>
Request: <a href='/api/v1/account/orders/create/'>POST /api/v1/account/orders/create/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>account_id</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>amount</td>
		<td>float</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>instrument_code</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>side</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>type</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>price</td>
		<td>float</td>
		<td>No</td>
	</tr>
</table>
</table>
</p>

<p>
Response:
<pre>
{
	\"account_id\": \"6b86b273ff34fce19d6b804eff5a3f57\",
	\"amount\": \"0.1\",
	\"filled_amount\": \"0.1\",
	\"instrument_code\": \"ETH_EUR\",
	\"price\": \"997\",
	\"order_id\": \"2021-01-09T01:29:00-1995522294\",
	\"side\": \"BUY\",
	\"status\": \"FILLED\",
	\"time\": \"2021-01-09T01:29:00\",
	\"type\": \"MARKET\"
}
</pre>
</p>
</p>

<p>
<h4>Query Order</h4>

<p>
Request: <a href='/api/v1/account/orders/query/'>GET /api/v1/account/orders/query/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>account_id</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>order_id</td>
		<td>string</td>
		<td>No</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"order\": {
		\"order_id\": \"2021-01-09T01:16:46-1889284441\",
		\"account_id\": \"6b86b273ff34fce19d6b804eff5a3f57\",
		\"last_updated\": \"\",
		\"price\": 900,
		\"amount\": 5,
		\"filled_amount\": 0.2,
		\"instrument_code\": \"ETH_EUR\",
		\"side\": \"BUY\",
		\"status\": \"CANCELLED\",
		\"time\": \"2021-01-09 01:16:46\",
		\"type\": \"LIMIT\",
		\"trades\": [{
			\"trade_id\": \"2021-01-09T01:17:43-978418446\",
			\"order_id\": \"2021-01-09T01:16:46-1889284441\",
			\"account_id\": \"6b86b273ff34fce19d6b804eff5a3f57\",
			\"instrument_code\": \"ETH_EUR\",
			\"side\": \"BUY\",
			\"amount\": 0.1,
			\"price\": 900,
			\"time\": \"2021-01-09 01:17:43\"
		}, {
			\"trade_id\": \"2021-01-09T01:28:26-2118600236\",
			\"order_id\": \"2021-01-09T01:16:46-1889284441\",
			\"account_id\": \"6b86b273ff34fce19d6b804eff5a3f57\",
			\"instrument_code\": \"ETH_EUR\",
			\"side\": \"BUY\",
			\"amount\": 0.1,
			\"price\": 900,
			\"time\": \"2021-01-09 01:28:26\"
		}]
	}
}
</pre>
</p>
</p>

<p>
<h4>Query Trade</h4>

<p>
Request: <a href='/api/v1/account/trades/query/'>GET /api/v1/account/trades/query/</a>

<table>
	<tr>
		<th>Parameter</th>
		<th>Type</th>
		<th>Required</th>
	</tr>
	<tr>
		<td>account_id</td>
		<td>string</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>trade_id</td>
		<td>string</td>
		<td>No</td>
	</tr>
</table>
</p>

<p>
Response:
<pre>
{
	\"trade_id\": \"2021-01-09T01:29:00-142763372\",
	\"order_id\": \"2021-01-09T01:29:00-1995522294\",
	\"account_id\": \"6b86b273ff34fce19d6b804eff5a3f57\",
	\"instrument_code\": \"ETH_EUR\",
	\"side\": \"BUY\",
	\"amount\": 0.1,
	\"price\": 997,
	\"time\": \"2021-01-09 01:29:00\"
}
</pre>
</p>
</p>

		" );
	}
}

