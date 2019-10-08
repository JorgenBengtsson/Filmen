using FilmenBackEnd.MovieDB.DTO;
using Newtonsoft.Json;
using System;
using System.Configuration;
using System.IO;
using System.Net;

namespace FilmenBackEnd.MovieDB
{
    public static class MovieFetcher
    {
        public static MovieDBMovieInformation GetMovie(string id)
        {
            var apiKey = ConfigurationManager.AppSettings["MovieDBAPIKey"];
            var movieEndPoint = ConfigurationManager.AppSettings["MovieDBMovieEndPoint"];
            
            string apiPath = String.Format(movieEndPoint, id, apiKey);

            HttpWebRequest apiRequest = WebRequest.Create(apiPath) as HttpWebRequest;

            var apiResponse = String.Empty;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3
                        | SecurityProtocolType.Tls
                        | SecurityProtocolType.Tls11
                        | SecurityProtocolType.Tls12;
            try
            {
                using (HttpWebResponse response = apiRequest.GetResponse() as HttpWebResponse)
                {
                    StreamReader reader = new StreamReader(response.GetResponseStream());
                    apiResponse = reader.ReadToEnd();
                }

                MovieDBMovieInformation returnMovie = JsonConvert.DeserializeObject<MovieDBMovieInformation>(apiResponse);

                return returnMovie;

            } catch (System.Net.WebException ex)
            {
                throw new MovieDBFetchError("Error Fetching Movie info from MovieDB", ex.InnerException);
            }
        }
    }
}