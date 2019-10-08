using FilmenBackEnd.MovieDB.DTO;
using Newtonsoft.Json;
using System;
using System.Configuration;
using System.IO;
using System.Net;

namespace FilmenBackEnd.MovieDB
{
    // Create a class that holds functions that "talk" to the MovieDB API
    public static class MovieFetcher
    {
        // This functions takes a Id, used in MovieDB but stored in our Db for a viewing, and returns a object with the information
        public static MovieDBMovieInformation GetMovie(string id)
        {
            // Get the ApiKey and the Url for the EndPoint from the Webconfig file
            var apiKey = ConfigurationManager.AppSettings["MovieDBAPIKey"];
            var movieEndPoint = ConfigurationManager.AppSettings["MovieDBMovieEndPoint"];
            
            // Using String Format function, add both the Api Key and the Movie Id to the Endpoint Url string, done with {} string placeholders
            string apiPath = String.Format(movieEndPoint, id, apiKey);

            // Make a normal WebRequest, this is equal to Fetch in JavaScript
            HttpWebRequest apiRequest = WebRequest.Create(apiPath) as HttpWebRequest;

            // Set up the response variable and the Security setting of the call (just Googled it)
            var apiResponse = String.Empty;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3
                        | SecurityProtocolType.Tls
                        | SecurityProtocolType.Tls11
                        | SecurityProtocolType.Tls12;
            
            // Using a Try/Catch statement to make the acctual call to the MovieDB
            try
            {
                using (HttpWebResponse response = apiRequest.GetResponse() as HttpWebResponse) // Using statement so we don't need to close the connection
                {
                    StreamReader reader = new StreamReader(response.GetResponseStream()); // Create a reader for the data we will get in return from the MovieDB Api
                    apiResponse = reader.ReadToEnd(); // Read to the end of the data we get and put in the variable apiResponse
                }

                // This takes the response, apiresponse string, and deserialize it to a object, MovieDBMovieInformation
                // The deserialization will match the names of the data attributes to the names of the properties/attributes of the object as best at is can
                MovieDBMovieInformation returnMovie = JsonConvert.DeserializeObject<MovieDBMovieInformation>(apiResponse);

                return returnMovie; // Return the object that we deserialzied from the response of the Api call

            } catch (System.Net.WebException ex)
            {
                // If someting goes wrong with the Web Api call (Fetch) we just throw a error
                throw new MovieDBFetchError("Error Fetching Movie info from MovieDB", ex.InnerException);
            }
        }
    }
}