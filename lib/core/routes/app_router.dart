import 'package:flutter/material.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/features/quote/quote_detail_screen.dart';
import 'package:quote_builder_app_meru_technosoft_pvt_ltd/presentation/widgets/error_screen.dart';

import '../../data/models/business_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/temp_model.dart';
import '../../data/models/terms_model.dart';
import '../../presentation/features/business/business_detail_screen.dart';
import '../../presentation/features/business/create_business_screen.dart';
import '../../presentation/features/business/edit_business_screen.dart';
import '../../presentation/features/business/manage_business_screen.dart';
import '../../presentation/features/client/client_detail_screen.dart';
import '../../presentation/features/client/create_client_screen.dart';
import '../../presentation/features/client/delete_client_widget.dart';
import '../../presentation/features/client/edit_client_screen.dart';
import '../../presentation/features/client/manage_client_screen.dart';
import '../../presentation/features/home/home_screen.dart';
import '../../presentation/features/product/create_product_screen.dart';
import '../../presentation/features/product/delete_product_widget.dart';
import '../../presentation/features/product/edit_product_screen.dart';
import '../../presentation/features/product/manage_product_screen.dart';
import '../../presentation/features/product/product_detail_screen.dart';
import '../../presentation/features/quote/create_quote_screen.dart';
import '../../presentation/features/quote/delete_quote_widget.dart';
import '../../presentation/features/quote/edit_quote_screen.dart';
import '../../presentation/features/quote/manage_quotes_screen.dart';
import '../../presentation/features/splash/splash_screen.dart';
import '../../presentation/features/terms/create_terms_screen.dart';
import '../../presentation/features/terms/delete_terms_widget.dart';
import '../../presentation/features/terms/edit_terms_screen.dart';
import '../../presentation/features/terms/manage_terms_screen.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );

      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case RouteNames.manageBusiness:
        return MaterialPageRoute(
          builder: (_) => const ManageBusinessScreen(),
          settings: settings,
        );
      case RouteNames.businessDetail:
        return MaterialPageRoute(
          builder: (_) => const BusinessDetailScreen(),
          settings: settings,
        );
      case RouteNames.createBusiness:
        return MaterialPageRoute(
          builder: (_) => const CreateBusinessScreen(),
          settings: settings,
        );
      case RouteNames.editBusiness:
        final business = settings.arguments as BusinessModel;
        return MaterialPageRoute(
          builder: (_) => EditBusinessScreen(business: business),
          settings: settings,
        );

      case RouteNames.manageQuotes:
        return MaterialPageRoute(
          builder: (_) => const ManageQuotesScreen(),
          settings: settings,
        );
      case RouteNames.createQuote:
        return MaterialPageRoute(
          builder: (_) => const CreateQuoteScreen(),
          settings: settings,
        );
      case RouteNames.editQuote:
        return MaterialPageRoute(
          builder: (_) => const EditQuoteScreen(),
          settings: settings,
        );
      case RouteNames.deleteQuote:
        return MaterialPageRoute(
          builder: (_) => const DeleteQuoteWidget(),
          settings: settings,
        );

      case RouteNames.manageClients:
        return MaterialPageRoute(
          builder: (_) => const ManageClientScreen(),
          settings: settings,
        );
      case RouteNames.createClient:
        return MaterialPageRoute(
          builder: (_) => const CreateClientScreen(),
          settings: settings,
        );
      case RouteNames.editClient:
        final client = settings.arguments as ClientModel;
        return MaterialPageRoute(
          builder: (_) => EditClientScreen(client: client),
          settings: settings,
        );

      case RouteNames.clientDetail:
        final clientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ClientDetailScreen(clientId: clientId),
          settings: settings,
        );

      case RouteNames.deleteClient:
        return MaterialPageRoute(
          builder: (_) => const DeleteClientWidget(),
          settings: settings,
        );

      case RouteNames.manageTerms:
        return MaterialPageRoute(
          builder: (_) => const ManageTermsScreen(),
          settings: settings,
        );
      case RouteNames.createTerm:
        return MaterialPageRoute(
          builder: (_) => const CreateTermsScreen(),
          settings: settings,
        );
      case RouteNames.editTerm:
        final term = settings.arguments as TermsModel;
        return MaterialPageRoute(
          builder: (_) => EditTermsScreen(term: term),
          settings: settings,
        );
      case RouteNames.deleteTerm:
        return MaterialPageRoute(
          builder: (_) => const DeleteTermsWidget(),
          settings: settings,
        );

      case RouteNames.manageProducts:
        return MaterialPageRoute(
          builder: (_) => const ManageProductScreen(),
          settings: settings,
        );
      case RouteNames.createProduct:
        return MaterialPageRoute(
          builder: (_) => const CreateProductScreen(),
          settings: settings,
        );

      case RouteNames.editProduct:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => EditProductScreen(product: product),
          settings: settings,
        );
      case RouteNames.productDetail:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(productId: productId),
          settings: settings,
        );

      case RouteNames.deleteProduct:
        return MaterialPageRoute(
          builder: (_) => const DeleteProductWidget(),
          settings: settings,
        );

      case RouteNames.quoteDetail:
        final quoteId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => QuoteDetailScreen(quoteId: quoteId),
          settings: settings,
        );

      case RouteNames.errorScreen:
        return MaterialPageRoute(
          builder: (_) => ErrorScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }
}
