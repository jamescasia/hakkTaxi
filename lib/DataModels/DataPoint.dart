class DataPoint {
  double pickupLat;
  double dropoffLat;
  double pickupLong;
  double dropoffLong;
  double duration;
  int order;

  DataPoint(this.pickupLat, this.pickupLong, this.dropoffLat, this.dropoffLong,
      this.duration);
  setOrder(int o) {
    this.order = o;
  }
}
