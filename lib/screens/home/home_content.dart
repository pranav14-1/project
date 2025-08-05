import 'package:flutter/material.dart';
import 'package:project/utils/shimmer_widgets.dart';

class HomeContent extends StatefulWidget {
  final String userName;
  final String empType;

  const HomeContent({super.key, required this.userName, required this.empType});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _isLoading = true; // TODO: toggle based on real API call

  @override
  void initState() {
    super.initState();
    // Simulate a network request; remove when wired to backend.
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) =>
      _isLoading ? const _HomeShimmer() : _RealHomeContent(widget);
}

class _RealHomeContent extends StatelessWidget {
  final HomeContent parent;
  const _RealHomeContent(this.parent);

  @override
  Widget build(BuildContext context) {
    final userName = parent.userName;
    final empType = parent.empType;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _welcomeCard(userName, empType),
          const SizedBox(height: 24),
          _overviewSection(),
          const SizedBox(height: 24),
          _pendingSection(),
        ],
      ),
    );
  }

  // Welcome card
  Widget _welcomeCard(String user, String type) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF1976D2), Color(0xFF1565C0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF1976D2).withOpacity(.30),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white.withOpacity(.25),
          child: const Icon(Icons.person, color: Colors.white, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back,',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                user,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.20),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // Overview
  Widget _overviewSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _SectionHeader('Today’s Overview'),
      const SizedBox(height: 12),
      Row(
        children: const [
          Expanded(
            child: _StatCard(
              icon: Icons.access_time,
              value: '7.5h',
              label: 'Hours Today',
              color: Color(0xFF1976D2),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              icon: Icons.task_alt,
              value: '12/15',
              label: 'Tasks Done',
              color: Color(0xFF388E3C),
            ),
          ),
        ],
      ),
    ],
  );

  // Pending
  Widget _pendingSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const _SectionHeader('Pending Actions'),
      const SizedBox(height: 12),
      Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _dummyTasks.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final t = _dummyTasks[i];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: t.color.withOpacity(.15),
                child: Icon(t.icon, color: t.color, size: 20),
              ),
              title: Text(
                t.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                t.subtitle,
                style: const TextStyle(fontSize: 12, color: Color(0xFF616161)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              onTap: () {
                // TODO: navigate to detail
              },
            );
          },
        ),
      ),
    ],
  );
}

// helpers
class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(
      context,
    ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
  );
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(.15),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Color(0xFF616161)),
            ),
          ],
        ),
      ),
    ),
  );
}

// dummy data
class _TaskItem {
  final String title, subtitle;
  final IconData icon;
  final Color color;

  const _TaskItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

const _dummyTasks = [
  _TaskItem(
    title: 'Prepare sales report',
    subtitle: 'Due today 5:00 PM',
    icon: Icons.assignment,
    color: Color(0xFFD32F2F),
  ),
  _TaskItem(
    title: 'Client meeting',
    subtitle: 'Tomorrow 10:00 AM',
    icon: Icons.meeting_room,
    color: Color(0xFFF57C00),
  ),
  _TaskItem(
    title: 'Submit timesheet',
    subtitle: 'Friday 6:00 PM',
    icon: Icons.schedule,
    color: Color(0xFF1976D2),
  ),
];

class _HomeShimmer extends StatelessWidget {
  const _HomeShimmer();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ShimmerBox(height: 140, width: double.infinity),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: ShimmerBox(height: 120, width: double.infinity)),
            SizedBox(width: 12),
            Expanded(child: ShimmerBox(height: 120, width: double.infinity)),
          ],
        ),
        SizedBox(height: 24),
        ShimmerBox(height: 220, width: double.infinity),
      ],
    ),
  );
}
