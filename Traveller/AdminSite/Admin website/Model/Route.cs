namespace Admin_website.Model
{
	public class Route
	{
		public string ID { get; set; }
		public string TrainID { get; set; }

		public Station[] Stations { get; set; }

        public Route(string id, string tId, Station[] stations)
        {
			this.ID = id;
			this.TrainID = tId;
			this.Stations = stations;
        }
    }
}
