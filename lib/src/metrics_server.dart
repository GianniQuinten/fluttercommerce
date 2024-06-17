// import 'package:prometheus_client/prometheus_client.dart';
// import 'package:shelf/shelf.dart' as shelf;
// import 'package:shelf/shelf_io.dart' as shelf_io;
//
// void main() {
//   final registry = PrometheusClient().registry;
//
//   final counter = Counter(
//     'example_counter',
//     'An example counter metric',
//     labelNames: ['method'],
//   );
//
//   registry.register(counter);
//
//   // Increment counter on some action, for example, an API request
//   counter.labels(['get']).inc();
//
//   // Set up a shelf server to expose the metrics
//   final handler = shelf.Pipeline()
//       .addMiddleware(shelf.logRequests())
//       .addHandler((shelf.Request request) {
//     if (request.requestedUri.path == '/metrics') {
//       return shelf.Response.ok(
//         registry.collectMetricFamilySamples(),
//         headers: {'content-type': 'text/plain; version=0.0.4'},
//       );
//     }
//     return shelf.Response.notFound('Not Found');
//   });
//
//   // Start the server
//   shelf_io.serve(handler, '0.0.0.0', 8080).then((server) {
//     print('Server listening on port ${server.port}');
//   });
// }
