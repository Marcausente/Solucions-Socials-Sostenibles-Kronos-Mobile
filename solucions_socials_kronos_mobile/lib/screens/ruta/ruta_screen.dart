import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/auth_service.dart';

class RutaScreen extends StatefulWidget {
  const RutaScreen({super.key});

  @override
  State<RutaScreen> createState() => _RutaScreenState();
}

class _RutaScreenState extends State<RutaScreen> {
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(Supabase.instance.client);
  }

  Future<void> _logout() async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF4CAF51);
    const Color primaryDark = Color(0xFF3C8E41);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[primary, primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        titleSpacing: 16,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hoja de Ruta',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Gestión de la hoja de ruta',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool wide = constraints.maxWidth > 700;
          final EdgeInsets padding = EdgeInsets.symmetric(
            horizontal: wide ? 32 : 16,
            vertical: 20,
          );
          return SingleChildScrollView(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Sección de acciones en tarjeta
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1F2227)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white10
                          : primary.withOpacity(0.15),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Acciones',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _ActionGrid(
                        primary: primary,
                        primaryDark: primaryDark,
                        onTapSubirCsv: () => _showSnack('Subir CSV'),
                        onTapEditar: () => _showSnack('Editar'),
                        onTapConfirmar: () =>
                            _showSnack('Confirmar Lista y material'),
                        onTapEliminar: () => _showSnack('Eliminar'),
                        onTapHistorico: () => _showSnack('Histórico'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({
    required this.primary,
    required this.primaryDark,
    required this.onTapSubirCsv,
    required this.onTapEditar,
    required this.onTapConfirmar,
    required this.onTapEliminar,
    required this.onTapHistorico,
  });

  final Color primary;
  final Color primaryDark;
  final VoidCallback onTapSubirCsv;
  final VoidCallback onTapEditar;
  final VoidCallback onTapConfirmar;
  final VoidCallback onTapEliminar;
  final VoidCallback onTapHistorico;

  @override
  Widget build(BuildContext context) {
    final List<_ActionItem> items = <_ActionItem>[
      _ActionItem(
        label: 'Subir CSV',
        icon: Icons.upload_file,
        onTap: onTapSubirCsv,
      ),
      _ActionItem(
        label: 'Editar',
        icon: Icons.edit_outlined,
        onTap: onTapEditar,
      ),
      _ActionItem(
        label: 'Confirmar Lista y material',
        icon: Icons.checklist_outlined,
        onTap: onTapConfirmar,
      ),
      _ActionItem(
        label: 'Eliminar',
        icon: Icons.delete_outline,
        onTap: onTapEliminar,
      ),
      _ActionItem(
        label: 'Histórico',
        icon: Icons.history,
        onTap: onTapHistorico,
      ),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: items
          .map(
            (_ActionItem it) => _ActionCard(
              label: it.label,
              icon: it.icon,
              primary: primary,
              primaryDark: primaryDark,
              onTap: it.onTap,
            ),
          )
          .toList(),
    );
  }
}

class _ActionItem {
  _ActionItem({required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.label,
    required this.icon,
    required this.primary,
    required this.primaryDark,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color primary;
  final Color primaryDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color fg = isDark ? Colors.white : Colors.black;
    final LinearGradient gradient = LinearGradient(
      colors: <Color>[primary, primaryDark],
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 150),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? const Color(0xFF1F2227) : Colors.white,
            border: Border.all(
              color: isDark ? Colors.white10 : primary.withOpacity(0.15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(color: fg, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
