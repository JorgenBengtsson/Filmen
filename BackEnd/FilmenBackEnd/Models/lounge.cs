//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FilmenBackEnd.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class lounge
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public lounge()
        {
            this.seats = new HashSet<seat>();
            this.viewings = new HashSet<viewing>();
        }
    
        public int id { get; set; }
        public int cinemaid { get; set; }
        public string name { get; set; }
        public System.DateTime created { get; set; }
    
        public virtual cinema cinema { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<seat> seats { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<viewing> viewings { get; set; }
    }
}
