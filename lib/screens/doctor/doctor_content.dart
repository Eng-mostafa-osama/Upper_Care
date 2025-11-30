import 'package:flutter/material.dart';
import '../../widgets/colorful_header.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

class DoctorContent extends StatefulWidget {
  final VoidCallback onBack;

  const DoctorContent({Key? key, required this.onBack}) : super(key: key);

  @override
  State<DoctorContent> createState() => _DoctorContentState();
}

class _DoctorContentState extends State<DoctorContent> {
  String selectedTab = 'published';

  List<Map<String, dynamic>> get publishedContent {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': 1,
        'type': 'article',
        'title': isArabic
            ? 'أهمية شرب الماء للقلب'
            : 'Importance of Drinking Water for Heart Health',
        'views': 1240,
        'likes': 89,
        'comments': 23,
        'date': isArabic ? 'منذ يومين' : '2 days ago',
      },
      {
        'id': 2,
        'type': 'video',
        'title': isArabic
            ? 'تمارين القلب للمبتدئين'
            : 'Heart Exercises for Beginners',
        'views': 2150,
        'likes': 156,
        'comments': 42,
        'date': isArabic ? 'منذ 5 أيام' : '5 days ago',
      },
      {
        'id': 3,
        'type': 'article',
        'title': isArabic
            ? 'النظام الغذائي الصحي للقلب'
            : 'Healthy Diet for Heart',
        'views': 890,
        'likes': 67,
        'comments': 18,
        'date': isArabic ? 'منذ أسبوع' : '1 week ago',
      },
    ];
  }

  List<Map<String, dynamic>> get drafts {
    final isArabic = localeProvider.isArabic;
    return [
      {
        'id': 4,
        'type': 'article',
        'title': isArabic
            ? 'علامات أمراض القلب المبكرة'
            : 'Early Signs of Heart Disease',
        'lastEdit': isArabic ? 'أمس' : 'Yesterday',
      },
      {
        'id': 5,
        'type': 'video',
        'title': isArabic
            ? 'كيفية قياس ضغط الدم في المنزل'
            : 'How to Measure Blood Pressure at Home',
        'lastEdit': isArabic ? 'منذ 3 أيام' : '3 days ago',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColorfulHeader(
              title: tr('educationalContent'),
              subtitle: tr('publishArticlesVideos'),
              onBack: widget.onBack,
              showNotifications: true,
              gradient: 'sunset',
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildCreateSection(),
                  const SizedBox(height: 20),
                  _buildTabs(),
                  const SizedBox(height: 20),
                  if (selectedTab == 'published')
                    _buildPublishedList()
                  else
                    _buildDraftsList(),
                  const SizedBox(height: 20),
                  _buildStatsSummary(),
                  const SizedBox(height: 20),
                  GradientButton(
                    variant: 'sunset',
                    fullWidth: true,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(tr('createNewContent')),
                      ],
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

  Widget _buildCreateSection() {
    return GlassCard(
      gradient: 'sunset',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('createNewContent'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCreateButton(
                Icons.description,
                tr('articleType'),
                const Color(0xFFFF7D40),
              ),
              _buildCreateButton(
                Icons.videocam,
                tr('videoType'),
                const Color(0xFF8B5CF6),
              ),
              _buildCreateButton(
                Icons.image,
                tr('imageType'),
                const Color(0xFF2BB9A9),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.2)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = 'published'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: selectedTab == 'published'
                      ? const LinearGradient(
                          colors: [Color(0xFFFF9E57), Color(0xFFFF7D40)],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${tr('published')} (${publishedContent.length})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedTab == 'published'
                        ? Colors.white
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = 'drafts'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: selectedTab == 'drafts'
                      ? const LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${tr('drafts')} (${drafts.length})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedTab == 'drafts'
                        ? Colors.white
                        : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPublishedList() {
    return Column(
      children: publishedContent
          .map(
            (content) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: GlassCard(
                gradient: 'blue',
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: content['type'] == 'article'
                                  ? [
                                      const Color(0xFFFF9E57),
                                      const Color(0xFFFF7D40),
                                    ]
                                  : [
                                      const Color(0xFF8B5CF6),
                                      const Color(0xFFEC4899),
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            content['type'] == 'article'
                                ? Icons.description
                                : Icons.videocam,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                content['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                content['date'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildStatBadge(
                          Icons.visibility,
                          '${content['views']}',
                          const Color(0xFF0A6DD9),
                        ),
                        const SizedBox(width: 16),
                        _buildStatBadge(
                          Icons.thumb_up,
                          '${content['likes']}',
                          const Color(0xFF0A6DD9),
                        ),
                        const SizedBox(width: 16),
                        _buildStatBadge(
                          Icons.comment,
                          '${content['comments']}',
                          const Color(0xFFFF7D40),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            Icons.visibility,
                            tr('view'),
                            const Color(0xFF0A6DD9),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildActionButton(
                            Icons.edit,
                            tr('edit'),
                            const Color(0xFF0A6DD9),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          Icons.delete,
                          '',
                          const Color(0xFFF43F5E),
                          isIconOnly: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDraftsList() {
    return Column(
      children: drafts
          .map(
            (draft) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: GlassCard(
                gradient: 'turquoise',
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: draft['type'] == 'article'
                                  ? [
                                      const Color(0xFFFF9E57),
                                      const Color(0xFFFF7D40),
                                    ]
                                  : [
                                      const Color(0xFF8B5CF6),
                                      const Color(0xFFEC4899),
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            draft['type'] == 'article'
                                ? Icons.description
                                : Icons.videocam,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                draft['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'آخر تعديل: ${draft['lastEdit']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            tr('draft'),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFFFF7D40),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit, size: 18),
                            label: Text(tr('continueEditing')),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A6DD9),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFFF43F5E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatBadge(IconData icon, String value, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(value, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color, {
    bool isIconOnly = false,
  }) {
    if (isIconOnly) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          onPressed: () {},
          icon: Icon(icon, color: color),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 16, color: color),
        label: Text(label, style: TextStyle(fontSize: 12, color: color)),
      ),
    );
  }

  Widget _buildStatsSummary() {
    return GlassCard(
      gradient: 'green',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('contentSummary'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildSummaryItem('42', tr('totalArticles')),
              _buildSummaryItem('18', tr('videos')),
              _buildSummaryItem('15. 2K', tr('totalViews')),
              _buildSummaryItem('1.8K', tr('likes')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
