namespace Admin_website.Model
{
	public class Station
	{
		public string Id { get; set; }
		public string Name { get; set; }
		public int Platforms { get; set; }
		public string Departure { get; set; }

        public Station(string id, string name, int platforms, string departure)
        {
            this.Id = id;
			this.Name = name;
			this.Platforms = platforms;
			this.Departure = departure;
        }
    }
}
