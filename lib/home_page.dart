import 'package:dhanraj_portfolio/widgets/project_section.dart';
import 'package:flutter/material.dart';
import 'widgets/nav_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/education_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(
            items: [
              NavItem('About', () => _scrollTo(_aboutKey)),
              NavItem('Skills', () => _scrollTo(_skillsKey)),
              NavItem('Projects', () => _scrollTo(_projectsKey)),
              NavItem('Education', () => _scrollTo(_educationKey)),
              NavItem('Contact', () => _scrollTo(_contactKey)),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeroSection(
                    sectionKey: _heroKey,
                    onSeeWork: () => _scrollTo(_projectsKey),
                  ),
                  AboutSection(sectionKey: _aboutKey),
                  SkillsSection(sectionKey: _skillsKey),
                  ProjectsSection(sectionKey: _projectsKey),
                  EducationSection(sectionKey: _educationKey),
                  ContactSection(sectionKey: _contactKey),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}