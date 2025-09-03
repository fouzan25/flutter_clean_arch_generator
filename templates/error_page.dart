import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.error, this.stackTrace});

  final Object? error;
  final StackTrace? stackTrace;

  static BeamPage beamLocation = const BeamPage(
    child: ErrorPage(),
    key: ValueKey('error'),
  );

  static const path = '/error';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 600 : size.width * 0.9),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Error Icon
                  Container(
                    width: isDesktop ? 120 : 100,
                    height: isDesktop ? 120 : 100,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.error.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      size: isDesktop ? 60 : 50,
                      color: theme.colorScheme.error,
                    ),
                  ),
                  
                  SizedBox(height: isDesktop ? 32 : 24),
                  
                  // Error Title
                  Text(
                    'Oops! Something went wrong',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: isDesktop ? 16 : 12),
                  
                  // Error Description
                  Text(
                    'We encountered an unexpected error. Please try again or contact support if the problem persists.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  if (error != null) ...[
                    SizedBox(height: isDesktop ? 24 : 16),
                    
                    // Error Details (Expandable)
                    ExpansionTile(
                      title: Text(
                        'Error Details',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.colorScheme.error.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            error.toString(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                              color: theme.colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                  SizedBox(height: isDesktop ? 40 : 32),
                  
                  // Action Buttons
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      // Go Back Button
                      ElevatedButton.icon(
                        onPressed: () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          } else {
                            Beamer.of(context).beamToNamed('/');
                          }
                        },
                        icon: const Icon(Icons.arrow_back_rounded),
                        label: const Text('Go Back'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 24 : 20,
                            vertical: isDesktop ? 16 : 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      
                      // Home Button
                      OutlinedButton.icon(
                        onPressed: () => Beamer.of(context).beamToNamed('/'),
                        icon: const Icon(Icons.home_rounded),
                        label: const Text('Go Home'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          side: BorderSide(color: theme.colorScheme.primary),
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 24 : 20,
                            vertical: isDesktop ? 16 : 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      
                      // Refresh Button
                      TextButton.icon(
                        onPressed: () {
                          // Force refresh by re-beaming to current location
                          final currentPath = Beamer.of(context).configuration.location;
                          Beamer.of(context).beamToNamed(currentPath ?? '/');
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Retry'),
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.onSurfaceVariant,
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 24 : 20,
                            vertical: isDesktop ? 16 : 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: isDesktop ? 32 : 24),
                  
                  // Help Text
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 16,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'If this error persists, please contact our support team',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}