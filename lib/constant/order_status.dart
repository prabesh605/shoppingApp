enum OrderStatus { pending, processing, shipped, completed, cancelled }

OrderStatus getNextStatus(OrderStatus current) {
  switch (current) {
    case OrderStatus.pending:
      return OrderStatus.processing;
    case OrderStatus.processing:
      return OrderStatus.shipped;
    case OrderStatus.shipped:
      return OrderStatus.completed;
    // case OrderStatus.completed:
    case OrderStatus.cancelled:
      return current;

    case OrderStatus.completed:
      return OrderStatus.completed;
  }
}
