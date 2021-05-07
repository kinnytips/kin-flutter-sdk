import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_base/base/tools/executor_service.dart';


abstract class InvoiceRepository {
  Future<Invoice> addInvoice(Invoice invoice);

  Future<List<Invoice>> addAllInvoices(List<Invoice> invoices);

  Observer<List<Invoice>> allInvoices();

  Future<Invoice> invoiceById(InvoiceId id);
}

class InMemoryInvoiceRepositoryImpl extends InvoiceRepository {

  final Map<InvoiceId, Invoice> _storage = <InvoiceId, Invoice>{} ;
  final ExecutorService _executorService = ExecutorService.createSequencial();

  final ValueSubject<List<Invoice>> _invoicesSubject = ValueSubject<List<Invoice>>();

  @override
  Future<Invoice> addInvoice(Invoice invoice) async {
    return _executorService.execute(() {
      _storage[invoice.id] = invoice;
      _invoicesSubject.onNext(_storage.values.toList());
      return invoice ;
    });
  }

  @override
  Future<List<Invoice>> addAllInvoices(List<Invoice> invoices) async {
    return _executorService.execute(() {
      for (var invoice in invoices) {
        _storage[invoice.id] = invoice;
      }
      _invoicesSubject.onNext(_storage.values.toList());
      return invoices ;
    });
  }

  Observer<List<Invoice>> allInvoices(){
    _invoicesSubject.onNext(_storage.values.toList());
    return _invoicesSubject ;
  }

  @override
  Future<Invoice> invoiceById(InvoiceId id) async {
    var invoice = _storage[id];
    return invoice;
  }

}
