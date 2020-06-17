class DataPoint {
  double pickupLat;
  double dropoffLat;
  double pickupLong;
  double dropoffLong;
  int hourOfDay;
  int dayOfWeek; //0-6 Mon to Sat

  double duration;
  int order;

  DataPoint(this.pickupLat, this.pickupLong, this.dropoffLat, this.dropoffLong,
      this.duration, this.dayOfWeek, this.hourOfDay);
  setOrder(int o) {
    this.order = o;
  }
}
