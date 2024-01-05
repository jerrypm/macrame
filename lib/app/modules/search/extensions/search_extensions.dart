enum SearchByCatalog {
  wallHanging,
  plantHangers,
  macrameBags,
  macrameHomeDecor,
  macrameCloting,
}

extension SearchByCatalogExtensions on SearchByCatalog {
  String get name {
    switch (this) {
      case SearchByCatalog.wallHanging:
        return 'Wall Hanging';
      case SearchByCatalog.plantHangers:
        return 'Plant Hangers';
      case SearchByCatalog.macrameBags:
        return 'Macrame Bags';
      case SearchByCatalog.macrameHomeDecor:
        return 'macrame Home Decor';
      case SearchByCatalog.macrameCloting:
        return 'Macrame Clothing';
      default:
        return '';
    }
  }

  String get catalogType {
    switch (this) {
      case SearchByCatalog.wallHanging:
        return 'wall';
      case SearchByCatalog.plantHangers:
        return 'bags';
      case SearchByCatalog.macrameBags:
        return 'bag';
      case SearchByCatalog.macrameHomeDecor:
        return 'wall';
      case SearchByCatalog.macrameCloting:
        return 'wall';
      default:
        return 'wall';
    }
  }
}
