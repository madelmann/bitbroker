
// Library imports

// Project imports
import libs.Database.Tables.Orders;
import Consts;


public namespace OrderChecker {

    public bool IsOrderValid( TOrdersRecord order const ) const throws {
        if ( !order.AccountId ) {
            throw "invalid accountId";
        }
        if ( order.Amount <= 0d ) {
            throw "invalid amount";
        }
        if ( !order.InstrumentCode ) {
            throw "invalid instrument code";
        }
        if ( order.Side != BUY && order.Side != SELL ) {
            throw "invalid side";
        }
        if ( order.Type != LIMIT_ORDER && order.Type != MARKET_ORDER ) {
            throw "invalid type";
        }
        if ( order.Price <= 0d && order.Type == LIMIT_ORDER ) {
            throw "invalid price";
        }

        return true;
    }

}

