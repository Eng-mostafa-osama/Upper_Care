import 'package:flutter/material.dart';
import '../../providers/theme_provider.dart';
import '../../l10n/app_localizations.dart';

class Article {
  final String id;
  final String title;
  final String category;
  final String readTime;
  final List<Color> gradientColors;
  final String excerpt;
  final int likes;

  Article({
    required this.id,
    required this.title,
    required this.category,
    required this.readTime,
    required this.gradientColors,
    required this.excerpt,
    required this.likes,
  });
}

class HealthAwarenessScreen extends StatefulWidget {
  final VoidCallback onBack;

  const HealthAwarenessScreen({Key? key, required this.onBack})
    : super(key: key);

  @override
  State<HealthAwarenessScreen> createState() => _HealthAwarenessScreenState();
}

class _HealthAwarenessScreenState extends State<HealthAwarenessScreen> {
  String selectedCategory = 'all';

  List<Map<String, dynamic>> get categories => [
    {
      'id': 'all',
      'name': tr('allCategory'),
      'color': const Color(0xFF0A6DD9),
      'icon': Icons.book,
    },
    {
      'id': 'nutrition',
      'name': tr('nutritionCategory'),
      'color': const Color(0xFF0A6DD9),
      'icon': Icons.apple,
    },
    {
      'id': 'exercise',
      'name': tr('exerciseCategory'),
      'color': const Color(0xFFFF9E57),
      'icon': Icons.fitness_center,
    },
    {
      'id': 'prevention',
      'name': tr('preventionCategory'),
      'color': const Color(0xFF2BB9A9),
      'icon': Icons.favorite,
    },
    {
      'id': 'summer',
      'name': tr('summerHealthCategory'),
      'color': const Color(0xFFFF7D40),
      'icon': Icons.wb_sunny,
    },
  ];

  List<Article> get articles => [
    Article(
      id: '1',
      title: tr('drinkingWaterHotWeather'),
      category: 'summer',
      readTime: tr('minutes5'),
      gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF2BB9A9)],
      excerpt: tr('drinkingWaterExcerpt'),
      likes: 245,
    ),
    Article(
      id: '2',
      title: tr('childNutrition'),
      category: 'nutrition',
      readTime: tr('minutes7'),
      gradientColors: [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
      excerpt: tr('childNutritionExcerpt'),
      likes: 189,
    ),
    Article(
      id: '3',
      title: tr('simpleHomeExercises'),
      category: 'exercise',
      readTime: tr('minutes6'),
      gradientColors: [const Color(0xFFFF9E57), const Color(0xFFFF7D40)],
      excerpt: tr('homeExercisesExcerpt'),
      likes: 321,
    ),
    Article(
      id: '4',
      title: tr('heartDiseasePrevention'),
      category: 'prevention',
      readTime: tr('minutes8'),
      gradientColors: [const Color(0xFFFF7D40), const Color(0xFFE9E9E9)],
      excerpt: tr('heartDiseaseExcerpt'),
      likes: 276,
    ),
    Article(
      id: '5',
      title: tr('immunityBoostingFoods'),
      category: 'nutrition',
      readTime: tr('minutes5'),
      gradientColors: [const Color(0xFF2BB9A9), const Color(0xFF0A6DD9)],
      excerpt: tr('immunityFoodsExcerpt'),
      likes: 198,
    ),
    Article(
      id: '6',
      title: tr('healthySleepTips'),
      category: 'prevention',
      readTime: tr('minutes6'),
      gradientColors: [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
      excerpt: tr('sleepTipsExcerpt'),
      likes: 167,
    ),
  ];

  List<Article> get filteredArticles {
    if (selectedCategory == 'all') return articles;
    return articles.where((a) => a.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey[50],
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildCategories(),
                  const SizedBox(height: 24),
                  if (filteredArticles.isNotEmpty) _buildFeaturedArticle(),
                  const SizedBox(height: 24),
                  _buildArticlesList(),
                  const SizedBox(height: 24),
                  _buildHealthTips(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9), Color(0xFF0A6DD9)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(15, (index) {
                  final colors = [
                    const Color(0xFF0A6DD9),
                    const Color(0xFF2BB9A9),
                    const Color(0xFF0A6DD9),
                  ];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colors[index % 3].withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: widget.onBack,
                  ),
                  Text(
                    tr('healthAwareness'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tr('yourHealthMatters'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tr('trustedHealthTips'),
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0A6DD9), Color(0xFF2BB9A9)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.menu_book,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategory == cat['id'];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat['id'] as String),
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? null : Colors.white,
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          cat['color'] as Color,
                          (cat['color'] as Color).withOpacity(0.8),
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    cat['name'] as String,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    cat['icon'] as IconData,
                    size: 18,
                    color: isSelected ? Colors.white : cat['color'] as Color,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedArticle() {
    final article = filteredArticles[0];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: article.gradientColors),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: article.gradientColors[0].withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            tr('featuredArticle'),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.book, size: 16, color: Colors.grey[700]),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        categories.firstWhere(
                              (c) => c['id'] == article.category,
                            )['name']
                            as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Text(
                          article.readTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  article.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                Text(
                  article.excerpt,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${filteredArticles.length} ${tr('article')}',
              style: TextStyle(color: Colors.grey[500]),
            ),
            Text(
              tr('articles'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...filteredArticles
            .skip(1)
            .map((article) => _buildArticleCard(article))
            .toList(),
      ],
    );
  }

  Widget _buildArticleCard(Article article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          article.readTime,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            categories.firstWhere(
                                  (c) => c['id'] == article.category,
                                )['color']
                                as Color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        categories.firstWhere(
                              (c) => c['id'] == article.category,
                            )['name']
                            as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  article.excerpt,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${article.likes}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.favorite, size: 16, color: Colors.red),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: article.gradientColors),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.article, color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTips() {
    final tips = [
      {
        'icon': Icons.water_drop,
        'text': tr('drink8GlassesWater'),
        'colors': [const Color(0xFFFF9E57), const Color(0xFFFF7D40)],
      },
      {
        'icon': Icons.apple,
        'text': tr('eat5FruitsVeggies'),
        'colors': [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
      },
      {
        'icon': Icons.fitness_center,
        'text': tr('exercise30Minutes'),
        'colors': [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)],
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE9E9E9).withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE9E9E9).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                tr('quickTips'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.tips_and_updates, color: const Color(0xFFFF9E57)),
            ],
          ),
          const SizedBox(height: 16),
          ...tips.map((tip) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      tip['text'] as String,
                      style: TextStyle(color: Colors.grey[700]),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: tip['colors'] as List<Color>,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      tip['icon'] as IconData,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}





