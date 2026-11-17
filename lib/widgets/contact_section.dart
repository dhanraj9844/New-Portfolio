import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import 'reveal_on_scroll.dart';
import 'section_container.dart';

class ContactSection extends StatefulWidget {
  final Key sectionKey;
  const ContactSection({super.key, required this.sectionKey});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final subject =
        Uri.encodeComponent('Freelance inquiry from ${_nameController.text}');
    final body = Uri.encodeComponent(
        '${_messageController.text}\n\n— ${_nameController.text} (${_emailController.text})');
    final uri =
        Uri.parse('mailto:${ProfileData.email}?subject=$subject&body=$body');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      setState(() => _sent = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    return SectionContainer(
      sectionKey: widget.sectionKey,
      child: RevealOnScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(title: 'Contact'),
            Text(
              "If you'd like to work together or have a question, send me a message using the form below,"
              "or reach out directly at ${ProfileData.email}.",
              style: AppText.body,
            ),
            const SizedBox(height: 28),
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ContactForm(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    messageController: _messageController,
                    sent: _sent,
                    onSubmit: _submit,
                  ),
                  const SizedBox(height: 28),
                  const _ContactInfoCard(),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: _ContactForm(
                      formKey: _formKey,
                      nameController: _nameController,
                      emailController: _emailController,
                      messageController: _messageController,
                      sent: _sent,
                      onSubmit: _submit,
                    ),
                  ),
                  const SizedBox(width: 28),
                  const Expanded(
                    flex: 2,
                    child: _ContactInfoCard(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final bool sent;
  final VoidCallback onSubmit;

  const _ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.sent,
    required this.onSubmit,
  });

  InputDecoration _decoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: AppText.bodySmall,
      hintStyle: AppText.bodySmall.copyWith(color: AppColors.textMuted),
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.accentGreen, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: nameController,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: _decoration('Name', 'Your name'),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Please enter your name'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: emailController,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: _decoration('Email', 'you@email.com'),
            validator: (v) {
              if (v == null || v.trim().isEmpty)
                return 'Please enter your email';
              if (!v.contains('@') || !v.contains('.'))
                return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: messageController,
            style: const TextStyle(color: AppColors.textPrimary),
            maxLines: 5,
            decoration:
                _decoration('Message', 'Tell me about your project details'),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Please add a short message'
                : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
              foregroundColor: const Color(0xFF06251D),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onSubmit,
            child: Text(
              sent ? 'Message ready — check your email app' : 'Send Message',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  const _ContactInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Direct Contact', style: AppText.h3),
          const SizedBox(height: 16),
          _InfoRow(
              icon: Icons.mail_outline,
              label: ProfileData.email,
              onTap: () => launchUrl(Uri.parse('mailto:${ProfileData.email}'))),
          const SizedBox(height: 12),
          _InfoRow(
              icon: Icons.phone_outlined,
              label: ProfileData.phone,
              onTap: () => launchUrl(Uri.parse('tel:${ProfileData.phoneRaw}'))),
          const SizedBox(height: 12),
          _InfoRow(
              icon: Icons.code,
              label: '@${ProfileData.githubUsername}',
              onTap: () => launchUrl(Uri.parse(ProfileData.githubUrl))),
          const SizedBox(height: 12),
          _InfoRow(
              icon: Icons.camera_alt_outlined,
              label: ProfileData.instagramHandle,
              onTap: () => launchUrl(Uri.parse(ProfileData.instagramUrl))),
        ],
      ),
    );
  }
}

class _InfoRow extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _InfoRow(
      {required this.icon, required this.label, required this.onTap});

  @override
  State<_InfoRow> createState() => _InfoRowState();
}

class _InfoRowState extends State<_InfoRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            Icon(widget.icon,
                size: 18,
                color:
                    _hover ? AppColors.accentGreen : AppColors.textSecondary),
            const SizedBox(width: 10),
            Text(
              widget.label,
              style: AppText.bodySmall.copyWith(
                fontSize: 14,
                color: _hover ? AppColors.accentGreen : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
