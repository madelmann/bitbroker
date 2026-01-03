
// Library imports
import libJsonBuilder;

// Project imports
import HttpResponseCodes;


public namespace API {
    public namespace Response {

        public void Finalize() {
            print( "Content-Type: " + ContentType );
            print( "Status: " + StatusCode );
            print( "" );
            print( Json.GetString() );
        }

        public string GetContentType() const {
            return getenv( "CONTENT_TYPE" );
        }

        public void SetContentType( string type ) {
            ContentType = type;
        }

        public void SetStatus( HttpResponseCode status ) {
            StatusCode = status;
        }

        private string ContentType = "application/json";
        private int    StatusCode  = 200;

    }
}

