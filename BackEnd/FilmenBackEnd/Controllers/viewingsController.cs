using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using FilmenBackEnd.Models;
using FilmenBackEnd.MovieDB;

namespace FilmenBackEnd.Controllers
{
    public class ViewingsController : ApiController
    {
        private FilmenEntities db = new FilmenEntities();

        // GET: api/viewings
        public List<ViewingViewModel> GetViewings()
        {
            var listOfViewings = db.viewings.Include(v => v.lounge).OrderBy(v => v.date);
            var listOfMovies = new List<ViewingViewModel>();

            foreach(var viewing in listOfViewings)
            {
                 var movie = MovieFetcher.GetMovie(viewing.moviedbid);

                listOfMovies.Add(new ViewingViewModel
                {
                    MovieName = movie.Title,
                    Length = movie.Runtime ?? 0,
                    Adult = movie.Adult,
                    LoungeName = viewing.lounge.name,
                    ViewingDate = viewing.date,
                    TotalSeats = viewing.lounge.seats.Count()
                });
            }
            
            return listOfMovies;
        }

        // GET: api/viewings/5
        [ResponseType(typeof(viewing))]
        public IHttpActionResult Getviewing(int id)
        {
            viewing viewing = db.viewings.Find(id);
            if (viewing == null)
            {
                return NotFound();
            }

            return Ok(viewing);
        }

        // PUT: api/viewings/5
        [ResponseType(typeof(void))]
        public IHttpActionResult Putviewing(int id, viewing viewing)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != viewing.id)
            {
                return BadRequest();
            }

            db.Entry(viewing).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!viewingExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/viewings
        [ResponseType(typeof(viewing))]
        public IHttpActionResult Postviewing(viewing viewing)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.viewings.Add(viewing);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = viewing.id }, viewing);
        }

        // DELETE: api/viewings/5
        [ResponseType(typeof(viewing))]
        public IHttpActionResult Deleteviewing(int id)
        {
            viewing viewing = db.viewings.Find(id);
            if (viewing == null)
            {
                return NotFound();
            }

            db.viewings.Remove(viewing);
            db.SaveChanges();

            return Ok(viewing);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool viewingExists(int id)
        {
            return db.viewings.Count(e => e.id == id) > 0;
        }
    }
}