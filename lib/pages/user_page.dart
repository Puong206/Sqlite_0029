import 'package:database_paml/bloc/user_bloc.dart';
import 'package:database_paml/bloc/user_event.dart';
import 'package:database_paml/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFormPage extends StatefulWidget {
    final UserEntity? user;

    const UserFormPage({super.key, this.user});

    @override
    State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  final _phoneFocus = FocusNode();
  final _alamatFocus = FocusNode();

  bool _nameActive = false;
  bool _emailActive = false;
  bool _phoneActive = false;
  bool _alamatActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameCtrl.text = widget.user!.name;
      _emailCtrl.text = widget.user!.email;
      _phoneCtrl.text = widget.user!.noTelpon;
      _alamatCtrl.text = widget.user!.alamat;
    }
    _nameFocus.addListener(() =>
        setState(() => _nameActive = _nameFocus.hasFocus));
    _emailFocus.addListener(() =>
        setState(() => _emailActive = _emailFocus.hasFocus));
    _phoneFocus.addListener(() =>
        setState(() => _phoneActive = _phoneFocus.hasFocus));
    _alamatFocus.addListener(() =>
        setState(() => _alamatActive = _alamatFocus.hasFocus));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _alamatCtrl.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _alamatFocus.dispose();
    super.dispose();
  }

  bool get _isEdit => widget.user != null;

  String get _initials {
    final n = _nameCtrl.text.trim();
    if (n.isEmpty) return _isEdit ? '?' : '+';
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
        final isEdit = widget.user != null;

        return Scaffold(
            appBar: AppBar(title: Text(isEdit ? 'Edit User' : 'Tambah User')),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildAvatarPreview(),
                    const SizedBox(height: 32),
                    _buildFormCard(),
                    const SizedBox(height: 28),
                    _buildSaveButton(context),
                    if (_isEdit) ...[
                      const SizedBox(height: 14),
                      _buildCancelButton(context),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Top bar ──────────────────────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 24, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _P.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_rounded,
                  size: 18, color: _P.dark),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            _isEdit ? 'Edit Pengguna' : 'Tambah Pengguna',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: _P.dark,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ── Avatar preview ────────────────────────────────────────────────────────────
  Widget _buildAvatarPreview() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: _P.yellow,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _P.yellow.withOpacity(0.6),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: _nameCtrl.text.trim().isEmpty
                ? Icon(
                    _isEdit
                        ? Icons.manage_accounts_rounded
                        : Icons.person_add_rounded,
                    size: 44,
                    color: _P.dark,
                  )
                : Text(
                    _initials,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: _P.dark,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _isEdit ? 'Perbarui data pengguna' : 'Buat akun pengguna baru',
          style: const TextStyle(
            fontSize: 13,
            color: _P.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ── Form card ─────────────────────────────────────────────────────────────────
  Widget _buildFormCard() {
    return Container(
      decoration: BoxDecoration(
        color: _P.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  color: _P.dark,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Data Pengguna',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _P.dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          // Name field
          _buildFieldLabel('Nama Lengkap', Icons.person_rounded),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _nameCtrl,
            focusNode: _nameFocus,
            isActive: _nameActive,
            hint: 'Masukkan nama lengkap',
            icon: Icons.person_rounded,
            activeColor: _P.yellow,
            keyboardType: TextInputType.name,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 22),
          // Email field
          _buildFieldLabel('Alamat Email', Icons.email_rounded),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _emailCtrl,
            focusNode: _emailFocus,
            isActive: _emailActive,
            hint: 'Masukkan alamat email',
            icon: Icons.email_rounded,
            activeColor: _P.blue,
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 22),
          // No Telepon field
          _buildFieldLabel('No. Telepon', Icons.phone_rounded),
          _buildTextField(
            controller: _phoneCtrl,
            focusNode: _phoneFocus,
            isActive: _phoneActive,
            hint: '+62xxx',
            icon: Icons.phone_rounded,
            activeColor: Color(0xFFB5E8C9),   // pastel green
            keyboardType: TextInputType.phone,
            onChanged: (_) => setState(() {}),
          ),
          // Alamat field
          _buildFieldLabel('Alamat', Icons.location_on_rounded),
          _buildTextField(
            controller: _alamatCtrl,
            focusNode: _alamatFocus,
            isActive: _alamatActive,
            hint: 'Masukkan alamat lengkap',
            icon: Icons.location_on_rounded,
            activeColor: Color(0xFFE8C9B5),   // pastel orange
            keyboardType: TextInputType.streetAddress,
            maxLines: 3,                       // alamat bisa multi-baris
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: _P.grey),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: _P.dark,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isActive,
    required String hint,
    required IconData icon,
    required Color activeColor,
    TextInputType? keyboardType,
    int? maxLines,
    void Function(String)? onChanged,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isActive ? activeColor.withOpacity(0.2) : const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? activeColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: _P.dark,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: _P.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 10),
            child: Icon(icon,
                color: isActive ? activeColor : _P.grey, size: 20),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 48),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // ── Save button ────────────────────────────────────────────────────────────────
  Widget _buildSaveButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _onSave(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 17),
        decoration: BoxDecoration(
          color: _P.dark,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _P.dark.withOpacity(0.3),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isEdit ? Icons.save_rounded : Icons.person_add_alt_1_rounded,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 10),
            Text(
              _isEdit ? 'Simpan Perubahan' : 'Buat Pengguna',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Cancel button ─────────────────────────────────────────────────────────────
  Widget _buildCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: _P.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5E5EA), width: 1.5),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.close_rounded, color: _P.grey, size: 20),
            SizedBox(width: 8),
            Text(
              'Batal',
              style: TextStyle(
                color: _P.grey,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave(BuildContext context) {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final noTelpon = _phoneCtrl.text.trim();
    final alamat = _alamatCtrl.text.trim();

    //Cek validasi input
    if (name.isEmpty || email.isEmpty || noTelpon.isEmpty || alamat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text('Semua field harus diisi!'),
            ],
          ),
          backgroundColor: const Color(0xFFFF3B30),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      );
      return;
    }

    //Validasi format No. Telepon
    if (!noTelpon.startsWith('+62')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text('Format No. Telepon tidak valid!'),
            ],
          ),
          backgroundColor: const Color(0xFFFF3B30),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      );
      return;
    }

    //Validasi panjang No. Telepon
    if (noTelpon.length > 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text('Panjang No. Telepon tidak valid!'),
            ],
          ),
          backgroundColor: const Color(0xFFFF3B30),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      );
      return;
    }

    final newUser = UserEntity(
      id: _isEdit
          ? widget.user!.id
          : DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      noTelpon: noTelpon,
      alamat: alamat,
    );

    if (_isEdit) {
      context.read<UserBloc>().add(UpdateUserEvent(newUser));
    } else {
      context.read<UserBloc>().add(AddUserEvent(newUser));
    }

                                  Navigator.pop(context);
                                },
                                child: Text(isEdit ? "Simpan Perubahan" : "Simpan User Baru"),
                            ),
                        )
                    ]
                ),
            )
        );
    }
}