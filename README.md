## 1. Jakiego typu danych użyjesz do przechowywania poszczególnych wartości w bazie danych?

### Order

| Kolumna   | Opis                      | Typ SQL       |
| --------- | ------------------------- | ------------- |
| net_total | wartość netto zamówienia  | NUMERIC(10,2) |
| tax       | całkowita kwota podatku   | NUMERIC(10,2) |
| total     | wartość brutto zamówienia | NUMERIC(10,2) |

### Order Item

| Kolumna   | Opis                       | Typ SQL       |
| --------- | -------------------------- | ------------- |
| net_price | cena netto 1 sztuki towaru | NUMERIC(10,2) |
| quantity  | ilość sztuk                | INTEGER       |
| net_total | wartość netto pozycji      | NUMERIC(10,2) |
| total     | wartość brutto pozycji     | NUMERIC(10,2) |
