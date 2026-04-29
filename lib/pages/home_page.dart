import 'package:database_paml/bloc/user_bloc.dart';
import 'package:database_paml/bloc/user_event.dart';
import 'package:database_paml/bloc/user_state.dart';
import 'package:database_paml/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ── Palette ───────────────────────────────────────────────────────────────────
class _P {
  static const bg      = Color(0xFFF7F7FB);
  static const white   = Colors.white;
  static const dark    = Color(0xFF1A1A2E);
  static const grey    = Color(0xFF8E8E9A);
  static const yellow  = Color(0xFFFFE066);
  static const blue    = Color(0xFFBDE3FF);
  static const pink    = Color(0xFFFFCDD2);
  static const green   = Color(0xFFB5E8C9);
  static const peach   = Color(0xFFFFD6B5);
  static const lavender= Color(0xFFE0CCFF);
  static const cardColors = [
    Color(0xFFFFE066),
    Color(0xFFBDE3FF),
    Color(0xFFFFCDD2),
    Color(0xFFB5E8C9),
    Color(0xFFFFD6B5),
    Color(0xFFE0CCFF),
  ];
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _P.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (ctx, state) {
                  if (state is UserLoading) return _buildLoading();
                  if (state is UserLoaded && state.users.isNotEmpty) {
                    return _buildContent(ctx, state.users);
                  }
                  return _buildEmpty();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Halo, Selamat\nDatang! 👋',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: _P.dark,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Kelola pengguna dengan mudah',
                  style: TextStyle(
                    fontSize: 13,
                    color: _P.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          _IconBtn(icon: Icons.search_rounded, bg: _P.yellow),
          const SizedBox(width: 10),
          _IconBtn(icon: Icons.notifications_outlined, bg: _P.pink),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, List users) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        // Hero banner
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: _P.yellow,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Manajemen\nPengguna',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: _P.dark,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tambah, edit & hapus data\npengguna dengan mudah',
                      style: TextStyle(
                        fontSize: 13,
                        color: _P.dark.withOpacity(0.65),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.55),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.people_alt_rounded,
                  size: 36,
                  color: _P.dark,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Stats
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Total Pengguna',
                  value: '${users.length}',
                  icon: Icons.person_rounded,
                  color: _P.blue,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _StatCard(
                  label: 'Aktif Hari Ini',
                  value: '${users.length}',
                  icon: Icons.check_circle_rounded,
                  color: _P.green,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // List header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daftar Pengguna',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _P.dark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _P.lavender,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${users.length} orang',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _P.dark,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // Cards
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: users.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (ctx, i) => _UserCard(user: users[i], index: i),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: _P.yellow,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: CircularProgressIndicator(color: _P.dark, strokeWidth: 3),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Memuat data...',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _P.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: _P.yellow,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.people_outline_rounded,
                size: 60,
                color: _P.dark,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Belum ada pengguna',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: _P.dark,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap tombol + di bawah untuk\nmenambahkan pengguna baru',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: _P.grey, height: 1.6),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: _P.peach,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('👇', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 8),
                  Text(
                    'Tambah sekarang',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _P.dark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const UserFormPage()),
      ),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: _P.dark,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _P.dark.withOpacity(0.3),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
      ),
    );
  }
}

// ── Reusable widgets ───────────────────────────────────────────────────────────

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final Color bg;
  const _IconBtn({required this.icon, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: _P.dark, size: 22),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 26, color: _P.dark),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: _P.dark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _P.dark.withOpacity(0.65),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatefulWidget {
  final dynamic user;
  final int index;
  const _UserCard({required this.user, required this.index});

  @override
  State<_UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<_UserCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    Future.delayed(Duration(milliseconds: widget.index * 80), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String get _initials {
    final n = (widget.user.name as String).trim();
    if (n.isEmpty) return '?';
    return n
        .split(' ')
        .where((e) => e.isNotEmpty)
        .map((e) => e[0])
        .take(2)
        .join()
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final cardBg = _P.cardColors[widget.index % _P.cardColors.length];
    return FadeTransition(
      opacity: _ctrl,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.12),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _P.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: cardBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _initials,
                    style: const TextStyle(
                      color: _P.dark,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: _P.dark,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.user.email,
                      style: const TextStyle(fontSize: 13, color: _P.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.phone_rounded, size: 12, color: _P.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.user.noTelpon.isEmpty
                                ? '-'
                                : widget.user.noTelpon,
                            style: const TextStyle(fontSize: 12, color: _P.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded, size: 12, color: _P.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.user.alamat.isEmpty
                                ? '-'
                                : widget.user.alamat,
                            style: const TextStyle(fontSize: 12, color: _P.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _ActionBtn(
                icon: Icons.edit_rounded,
                color: _P.blue,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserFormPage(user: widget.user),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _ActionBtn(
                icon: Icons.delete_outline_rounded,
                color: _P.pink,
                onTap: () => _confirmDelete(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: _P.pink,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: _P.dark,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Hapus Pengguna?',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: _P.dark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Yakin ingin menghapus\n"${widget.user.name}"?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: _P.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _P.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<UserBloc>()
                            .add(DeleteUserEvent(widget.user.id));
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _P.pink,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'Hapus',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _P.dark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 18, color: _P.dark),
      ),
    );
  }
}