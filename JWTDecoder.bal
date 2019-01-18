import ballerina/internal;
import ballerina/io;
import ballerina/mime;

public function decode(string value, string part){
    io:println("---------"+part+"---------");
    match mime:base64DecodeString(value, charset = "utf-8")
    {
        string decodedBody => {
            match (internal:parseJson(decodedBody)){
                json j => {
                    
                    io:println(j);
                }
                error e => io:println("error");
            }
            }
        error er => {io:println(er);}
    }
}
public function main() {
    string rawJWT = ""; // JWT 
    string[] split_string = rawJWT.split("\\."); // Split the string
    string base64EncodedHeader = split_string[0]; // Header part
    string base64EncodedBody = split_string[1]; // Payload part
    string base64EncodedSignature = split_string[2]; // Signature

    decode(base64EncodedHeader, "HEADER");
    decode(base64EncodedBody, "PAYLOARD");
}