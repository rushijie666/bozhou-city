import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const BozhouGuideApp());
}

class BozhouGuideApp extends StatelessWidget {
  const BozhouGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '亳州导览手账',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.paperDeep,
        fontFamilyFallback: const [
          'PingFang SC',
          'Noto Sans CJK SC',
          'Microsoft YaHei',
          'Arial',
        ],
      ),
      home: const BozhouGuidePage(),
    );
  }
}

Color soft(Color color, double opacity) {
  return color.withAlpha((255 * opacity).round());
}

enum GuidePage { intro, spots, food, route }
enum AppLanguage { zh, ko, en }
enum SpotCategory { all, heritage, medicine, caowei, wine, street }

class T {
  const T(this.zh, this.ko, this.en);
  final String zh;
  final String ko;
  final String en;

  String of(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.zh:
        return zh;
      case AppLanguage.ko:
        return ko;
      case AppLanguage.en:
        return en;
    }
  }
}

class AppColors {
  static const paper = Color(0xFFF7EFE0);
  static const paperDeep = Color(0xFFEAD9BD);
  static const ink = Color(0xFF24201A);
  static const muted = Color(0xFF756B5D);
  static const red = Color(0xFFB24D39);
  static const blue = Color(0xFF28677B);
  static const green = Color(0xFF5C7350);
  static const gold = Color(0xFFAA7B32);
  static const card = Color(0xFFFFF9EE);
  static const line = Color(0x2E463622);
  static const purple = Color(0xFF76507E);
}

class SpotItem {
  const SpotItem({
    required this.id,
    required this.title,
    required this.category,
    required this.icon,
    required this.color,
    required this.text,
    required this.detail,
    required this.time,
    required this.chips,
  });

  final String id;
  final T title;
  final SpotCategory category;
  final String icon;
  final Color color;
  final T text;
  final T detail;
  final T time;
  final List<T> chips;
}

class FoodItem {
  const FoodItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.text,
    required this.tag,
    required this.color,
  });

  final String id;
  final T title;
  final String icon;
  final T text;
  final T tag;
  final Color color;
}

class RouteStop {
  const RouteStop({required this.time, required this.title, required this.note});
  final String time;
  final T title;
  final T note;
}

class RoutePlan {
  const RoutePlan({required this.title, required this.subtitle, required this.stops});
  final T title;
  final T subtitle;
  final List<RouteStop> stops;
}

T pageTitle(GuidePage page) {
  switch (page) {
    case GuidePage.intro:
      return const T('介绍', '소개', 'Intro');
    case GuidePage.spots:
      return const T('景点', '명소', 'Spots');
    case GuidePage.food:
      return const T('美食', '음식', 'Food');
    case GuidePage.route:
      return const T('路线', '코스', 'Route');
  }
}

T categoryTitle(SpotCategory category) {
  switch (category) {
    case SpotCategory.all:
      return const T('全部', '전체', 'All');
    case SpotCategory.heritage:
      return const T('古建', '고건축', 'Heritage');
    case SpotCategory.medicine:
      return const T('医药', '의약', 'Medicine');
    case SpotCategory.caowei:
      return const T('曹魏', '조위', 'Cao Wei');
    case SpotCategory.wine:
      return const T('酒香', '술 문화', 'Wine');
    case SpotCategory.street:
      return const T('街区', '거리', 'Street');
  }
}

const List<SpotItem> spots = [
  SpotItem(
    id: 'huaxilou',
    title: T('花戏楼', '화시루', 'Huaxi Opera Tower'),
    category: SpotCategory.heritage,
    icon: '戏',
    color: AppColors.red,
    text: T(
      '会馆、戏楼、砖雕和木雕集中在一处，是亳州老城最有辨识度的封面。',
      '회관, 극장, 벽돌 조각과 목조 장식이 모인 보저우 구도심의 대표 장면입니다.',
      'A signature old-city landmark with guild hall culture, opera-stage space, brick carving and wood carving.',
    ),
    detail: T(
      '适合放在首页大图或明信片卡片里。UI 可以用“戏台、雕刻、老街”三个关键词突出它的视觉记忆点。',
      '첫 화면이나 엽서 카드에 넣기 좋습니다. “무대, 조각, 옛거리” 키워드로 시각적 포인트를 잡을 수 있습니다.',
      'Best used as a hero card or postcard. Use stage, carving and old street as the three visual keywords.',
    ),
    time: T('建议 1.5 小时', '추천 1.5시간', 'Suggested 1.5h'),
    chips: [T('会馆', '회관', 'Guild hall'), T('砖雕', '벽돌 조각', 'Brick carving'), T('老城', '구도심', 'Old city')],
  ),
  SpotItem(
    id: 'caocao-tunnel',
    title: T('曹操地下运兵道', '조조 지하 운병도', 'Cao Cao Underground Tunnels'),
    category: SpotCategory.caowei,
    icon: '曹',
    color: AppColors.blue,
    text: T(
      '地下军事通道遗存，适合做“曹魏故里”主题路线的核心节点。',
      '지하 군사 통로 유적으로, “조위 고장” 테마 코스의 핵심 지점입니다.',
      'A preserved underground military tunnel site, ideal for a Cao Wei history route.',
    ),
    detail: T(
      '这个点适合做互动说明页：用线条、节点、地下通道图形表现历史空间感。',
      '인터랙티브 설명 페이지에 잘 어울립니다. 선, 노드, 지하 통로 그래픽으로 공간감을 표현하세요.',
      'Works well as an interactive explanation page with line paths, nodes and underground-route graphics.',
    ),
    time: T('建议 1 小时', '추천 1시간', 'Suggested 1h'),
    chips: [T('曹魏', '조위', 'Cao Wei'), T('地下', '지하', 'Underground'), T('历史', '역사', 'History')],
  ),
  SpotItem(
    id: 'huazuan',
    title: T('华祖庵', '화조암', 'Huazu Temple'),
    category: SpotCategory.medicine,
    icon: '药',
    color: AppColors.green,
    text: T(
      '纪念华佗的中医药文化节点，可以和五禽戏、养生亳州一起展示。',
      '화타를 기리는 중의약 문화 지점으로 오금희와 양생 보저우 테마에 어울립니다.',
      'A traditional medicine culture stop linked with Hua Tuo, wellness and Wuqinxi imagery.',
    ),
    detail: T(
      '页面可以加入草药、印章、脉络线和养生标签，让“中华药都”的城市名片更明显。',
      '약초, 도장, 흐름선, 양생 태그를 넣으면 “중화 약도”의 도시 이미지가 더 선명해집니다.',
      'Add herbal labels, seal marks and flow lines to make the “Capital of Chinese Medicine” identity clearer.',
    ),
    time: T('建议 1 小时', '추천 1시간', 'Suggested 1h'),
    chips: [T('华佗', '화타', 'Hua Tuo'), T('中医药', '중의약', 'TCM'), T('养生', '양생', 'Wellness')],
  ),
  SpotItem(
    id: 'museum',
    title: T('亳州博物馆', '보저우 박물관', 'Bozhou Museum'),
    category: SpotCategory.heritage,
    icon: '馆',
    color: AppColors.gold,
    text: T(
      '适合用一站了解古谯、商汤、曹魏、中医药和地方文物脉络。',
      '고초, 상탕, 조위, 중의약과 지역 문물의 흐름을 한 번에 이해하기 좋은 장소입니다.',
      'A compact way to understand Bozhou’s ancient Qiao identity, Cao Wei stories, medicine culture and local relics.',
    ),
    detail: T(
      '建议放在路线第一站，先建立城市背景，再去老城和古迹会更容易理解。',
      '코스의 첫 번째 장소로 추천합니다. 도시 배경을 알고 구도심과 유적을 보면 더 이해하기 쉽습니다.',
      'Recommended as the first stop: learn the city context before moving into old streets and historical sites.',
    ),
    time: T('建议 1.5 小时', '추천 1.5시간', 'Suggested 1.5h'),
    chips: [T('室内', '실내', 'Indoor'), T('文化', '문화', 'Culture'), T('展览', '전시', 'Exhibits')],
  ),
  SpotItem(
    id: 'gujing',
    title: T('古井酒文化博览园', '고정주 문화박람원', 'Gujing Liquor Culture Park'),
    category: SpotCategory.wine,
    icon: '酒',
    color: Color(0xFF8F5A2C),
    text: T(
      '围绕古井贡酒与传统酿造文化展开，适合做“酒香慢游”路线。',
      '고정공주와 전통 양조 문화를 중심으로 한 “술 향기 산책” 코스에 어울립니다.',
      'A liquor-culture stop centered on Gujing Gongjiu and traditional brewing stories.',
    ),
    detail: T(
      '视觉上可以使用酒坛、麦穗、金色票据和复古瓶标，让板块更有地方识别度。',
      '술독, 보리 이삭, 금빛 티켓, 빈티지 라벨을 사용하면 지역성이 강해집니다.',
      'Use jars, grain, golden tickets and vintage bottle-label motifs for a stronger local feel.',
    ),
    time: T('建议 2 小时', '추천 2시간', 'Suggested 2h'),
    chips: [T('古井贡酒', '고정공주', 'Gujing'), T('酿造', '양조', 'Brewing'), T('体验', '체험', 'Experience')],
  ),
  SpotItem(
    id: 'beiguan',
    title: T('北关历史街区', '베이관 역사거리', 'Beiguan Historic Block'),
    category: SpotCategory.street,
    icon: '街',
    color: AppColors.purple,
    text: T(
      '老街、会馆、夜游和小吃聚在一起，是手账地图里最有烟火气的一段。',
      '옛거리, 회관, 야간 산책과 간식이 모여 있어 손장 지도에서 가장 생활감 있는 구간입니다.',
      'An atmospheric old block with guild halls, night walks and local snacks.',
    ),
    detail: T(
      '建议放在路线结尾：白天看历史，晚上回到街区吃小吃、拍夜景。',
      '코스 마지막에 넣기 좋습니다. 낮에는 역사를 보고 밤에는 거리에서 간식과 야경을 즐기세요.',
      'Works best as the final stop: history by day, snacks and night views by evening.',
    ),
    time: T('建议 2 小时', '추천 2시간', 'Suggested 2h'),
    chips: [T('夜游', '야간 산책', 'Night walk'), T('老街', '옛거리', 'Old street'), T('小吃', '간식', 'Snacks')],
  ),
];

const List<FoodItem> foods = [
  FoodItem(
    id: 'beef-bun',
    title: T('牛肉馍', '소고기 모', 'Beef Mo'),
    icon: '馍',
    text: T('外皮焦香、内馅扎实，是亳州烟火小吃里很适合首推的一项。', '겉은 바삭하고 속은 든든한 보저우 대표 길거리 음식입니다.', 'A hearty local snack with a crisp outside and rich beef filling.'),
    tag: T('必吃', '필수', 'Must try'),
    color: AppColors.red,
  ),
  FoodItem(
    id: 'dry-noodle',
    title: T('涡阳干扣面', '워양 간커우면', 'Guoyang Dry Noodles'),
    icon: '面',
    text: T('干拌面香味突出，适合放在县域特色美食入口。', '비벼 먹는 향이 진한 면으로 현지 특색을 보여줍니다.', 'A fragrant dry noodle dish that highlights county-level food culture.'),
    tag: T('面食', '면요리', 'Noodles'),
    color: AppColors.blue,
  ),
  FoodItem(
    id: 'smoked-beef',
    title: T('义门熏牛肉', '의문 훈제 소고기', 'Yimen Smoked Beef'),
    icon: '牛',
    text: T('咸香耐嚼，适合做伴手礼和老字号素材。', '짭짤하고 쫄깃해 선물이나 전통 맛집 소재로 좋습니다.', 'Savory and chewy, suitable for souvenir and old-brand food cards.'),
    tag: T('伴手礼', '선물', 'Souvenir'),
    color: AppColors.green,
  ),
  FoodItem(
    id: 'herbal-soup',
    title: T('药膳汤', '약선탕', 'Herbal Soup'),
    icon: '汤',
    text: T('把“中华药都”的养生气质放进菜单板块。', '“중화 약도”의 양생 이미지를 메뉴에 담을 수 있습니다.', 'A wellness-style food card that connects with Bozhou’s medicine identity.'),
    tag: T('养生', '양생', 'Wellness'),
    color: AppColors.gold,
  ),
  FoodItem(
    id: 'sazi',
    title: T('亳州撒子', '보저우 사즈', 'Bozhou Sazi'),
    icon: '酥',
    text: T('酥脆小吃，适合在美食页补充“轻食/零嘴”感觉。', '바삭한 간식으로 음식 페이지에 가벼운 먹거리 느낌을 더합니다.', 'A crispy snack that adds a light-bite option to the food page.'),
    tag: T('小吃', '간식', 'Snack'),
    color: AppColors.purple,
  ),
  FoodItem(
    id: 'herbal-tea',
    title: T('花草茶', '허브차', 'Herbal Tea'),
    icon: '茶',
    text: T('和药都主题呼应，适合做休息点或文创饮品。', '약도 테마와 어울리며 휴식 포인트나 문화 음료로 좋습니다.', 'A calm drink card that echoes the medicine-and-wellness theme.'),
    tag: T('文创', '문화상품', 'Creative'),
    color: Color(0xFF9A7044),
  ),
];

const List<RoutePlan> routes = [
  RoutePlan(
    title: T('药都印象', '약도 인상', 'Medicine Capital'),
    subtitle: T('文化背景 → 华佗记忆 → 药香街区', '도시 배경 → 화타 기억 → 약향 거리', 'City context → Hua Tuo → herbal atmosphere'),
    stops: [
      RouteStop(time: '09:00', title: T('亳州博物馆', '보저우 박물관', 'Bozhou Museum'), note: T('先建立城市历史背景', '도시 역사 배경부터 이해', 'Start with city history context')),
      RouteStop(time: '11:00', title: T('华祖庵', '화조암', 'Huazu Temple'), note: T('看华佗与中医药文化', '화타와 중의약 문화 보기', 'Explore Hua Tuo and medicine culture')),
      RouteStop(time: '15:00', title: T('中药材市场', '중약재 시장', 'Chinese Herbal Market'), note: T('感受药都烟火气', '약도의 생활감 느끼기', 'Feel the everyday energy of the medicine capital')),
    ],
  ),
  RoutePlan(
    title: T('曹魏古城', '조위 고성', 'Cao Wei Old City'),
    subtitle: T('地下遗存 → 会馆戏楼 → 夜游老街', '지하 유적 → 회관 극장 → 야간 옛거리', 'Tunnels → guild hall → night old street'),
    stops: [
      RouteStop(time: '09:30', title: T('曹操地下运兵道', '조조 지하 운병도', 'Cao Cao Underground Tunnels'), note: T('从地下军事遗存开始', '지하 군사 유적부터 시작', 'Begin with the underground military route')),
      RouteStop(time: '13:30', title: T('花戏楼', '화시루', 'Huaxi Opera Tower'), note: T('看会馆与戏楼雕刻', '회관과 극장 조각 감상', 'See guild hall and opera-stage carvings')),
      RouteStop(time: '18:30', title: T('北关历史街区', '베이관 역사거리', 'Beiguan Historic Block'), note: T('夜景、小吃和老街收尾', '야경과 간식으로 마무리', 'End with night views, snacks and old streets')),
    ],
  ),
  RoutePlan(
    title: T('酒香慢游', '술 향기 산책', 'Liquor Slow Tour'),
    subtitle: T('酒文化 → 古井镇 → 老街小吃', '술 문화 → 고정진 → 옛거리 간식', 'Liquor culture → Gujing town → old-street snacks'),
    stops: [
      RouteStop(time: '10:00', title: T('古井酒文化博览园', '고정주 문화박람원', 'Gujing Liquor Culture Park'), note: T('了解古井贡酒文化', '고정공주 문화 이해', 'Learn about Gujing Gongjiu culture')),
      RouteStop(time: '14:00', title: T('古井镇', '고정진', 'Gujing Town'), note: T('拍街景和酒香元素', '거리와 술 문화 요소 촬영', 'Capture street scenes and brewing motifs')),
      RouteStop(time: '19:00', title: T('老街小吃', '옛거리 간식', 'Old Street Snacks'), note: T('牛肉馍、干扣面收尾', '소고기 모와 간커우면으로 마무리', 'Finish with beef mo and dry noodles')),
    ],
  ),
];

class BozhouGuidePage extends StatefulWidget {
  const BozhouGuidePage({super.key});

  @override
  State<BozhouGuidePage> createState() => _BozhouGuidePageState();
}

class _BozhouGuidePageState extends State<BozhouGuidePage> {
  GuidePage page = GuidePage.intro;
  AppLanguage lang = AppLanguage.zh;
  SpotCategory filter = SpotCategory.all;
  int routeIndex = 0;
  final Set<String> savedFoods = {'beef-bun'};

  void cycleLanguage() {
    setState(() {
      switch (lang) {
        case AppLanguage.zh:
          lang = AppLanguage.ko;
          break;
        case AppLanguage.ko:
          lang = AppLanguage.en;
          break;
        case AppLanguage.en:
          lang = AppLanguage.zh;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEFE2C9), Color(0xFFD4BE98)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableHeight = constraints.maxHeight.isFinite ? constraints.maxHeight : 896.0;
              final verticalPadding = constraints.maxWidth >= 900 ? 44.0 : 28.0;
              final phoneHeight = (availableHeight - verticalPadding).clamp(640.0, 896.0).toDouble();

              final phone = PhoneFrame(
                height: phoneHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StatusRow(lang: lang),
                    const SizedBox(height: 10),
                    TopBar(lang: lang, onLanguageTap: cycleLanguage),
                    const SizedBox(height: 18),
                    Masthead(lang: lang),
                    const SizedBox(height: 18),
                    BozhouMapCard(lang: lang),
                    const SizedBox(height: 14),
                    HighlightStrip(lang: lang),
                    const SizedBox(height: 16),
                    ChapterNav(
                      lang: lang,
                      page: page,
                      onChanged: (value) => setState(() => page = value),
                    ),
                    const SizedBox(height: 14),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: KeyedSubtree(
                        key: ValueKey('${page.name}_${lang.name}_$filter$routeIndex${savedFoods.length}'),
                        child: buildContent(),
                      ),
                    ),
                  ],
                ),
              );

              if (constraints.maxWidth >= 900) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
                    child: phone,
                  ),
                );
              }

              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: phone,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    switch (page) {
      case GuidePage.intro:
        return IntroSection(lang: lang);
      case GuidePage.spots:
        return SpotsSection(
          lang: lang,
          filter: filter,
          onFilterChanged: (value) => setState(() => filter = value),
          onSpotTap: showSpotSheet,
        );
      case GuidePage.food:
        return FoodSection(
          lang: lang,
          savedFoods: savedFoods,
          onSaveTap: (foodId) {
            setState(() {
              if (savedFoods.contains(foodId)) {
                savedFoods.remove(foodId);
              } else {
                savedFoods.add(foodId);
              }
            });
          },
        );
      case GuidePage.route:
        return RouteSection(
          lang: lang,
          routeIndex: routeIndex,
          onRouteChanged: (value) => setState(() => routeIndex = value),
        );
    }
  }

  void showSpotSheet(SpotItem item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
            decoration: BoxDecoration(
              color: soft(AppColors.card, .98),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: soft(Colors.white, .82)),
              boxShadow: const [
                BoxShadow(color: Color(0x55392714), blurRadius: 46, offset: Offset(0, 18)),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: soft(AppColors.ink, .18),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: item.color,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: soft(item.color, .24), blurRadius: 18, offset: const Offset(0, 10))],
                      ),
                      child: Text(item.icon, style: const TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title.of(lang), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.ink)),
                          const SizedBox(height: 6),
                          Text(item.time.of(lang), style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                    CloseCircle(onTap: () => Navigator.pop(context)),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  item.detail.of(lang),
                  style: const TextStyle(color: AppColors.muted, height: 1.68, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: item.chips.map((chip) => ChipPill(label: chip.of(lang))).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child, required this.height});
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 430),
      child: SizedBox(
        height: height,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.paper,
            borderRadius: BorderRadius.circular(38),
            border: Border.all(color: const Color(0xFF171411), width: 7),
            boxShadow: const [BoxShadow(color: Color(0x443D3020), blurRadius: 58, offset: Offset(0, 26))],
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomPaint(
            painter: PaperGridPainter(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class PaperGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x09463622)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 22) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 22) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StatusRow extends StatelessWidget {
  const StatusRow({super.key, required this.lang});
  final AppLanguage lang;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('21:55', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.ink)),
        Text(
          const T('亳州 · 手账导览', '보저우 · 손장 가이드', 'Bozhou · Journal Guide').of(lang),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.ink),
        ),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.lang, required this.onLanguageTap});
  final AppLanguage lang;
  final VoidCallback onLanguageTap;

  String get languageLabel {
    switch (lang) {
      case AppLanguage.zh:
        return '中文';
      case AppLanguage.ko:
        return '한국어';
      case AppLanguage.en:
        return 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RoundButton(child: const Icon(Icons.chevron_left_rounded, size: 28), onTap: () {}),
        Row(
          children: [
            MiniLanguageDot(active: lang == AppLanguage.zh, label: '中'),
            const SizedBox(width: 5),
            MiniLanguageDot(active: lang == AppLanguage.ko, label: '한'),
            const SizedBox(width: 5),
            MiniLanguageDot(active: lang == AppLanguage.en, label: 'EN'),
            const SizedBox(width: 8),
            RoundButton(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(languageLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
                  const SizedBox(width: 4),
                  const Icon(Icons.translate_rounded, size: 16),
                ],
              ),
              onTap: onLanguageTap,
            ),
          ],
        ),
      ],
    );
  }
}

class MiniLanguageDot extends StatelessWidget {
  const MiniLanguageDot({super.key, required this.active, required this.label});
  final bool active;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: active ? 32 : 25,
      height: 25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? AppColors.ink : soft(Colors.white, .55),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: active ? AppColors.ink : AppColors.line),
      ),
      child: Text(
        label,
        style: TextStyle(color: active ? Colors.white : AppColors.muted, fontSize: 10, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton({super.key, required this.child, required this.onTap, this.padding = EdgeInsets.zero});
  final Widget child;
  final VoidCallback onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: soft(AppColors.card, .82),
      shape: StadiumBorder(side: BorderSide(color: soft(AppColors.line, .9))),
      elevation: 2,
      shadowColor: const Color(0x223D3020),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Container(height: 40, constraints: const BoxConstraints(minWidth: 40), padding: padding, alignment: Alignment.center, child: child),
      ),
    );
  }
}

class Masthead extends StatelessWidget {
  const Masthead({super.key, required this.lang});
  final AppLanguage lang;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                decoration: BoxDecoration(
                  color: soft(AppColors.red, .10),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: soft(AppColors.red, .22)),
                ),
                child: Text(
                  const T('安徽省 · 中华药都', '안후이성 · 중화 약도', 'Anhui · Medicine Capital').of(lang),
                  style: const TextStyle(color: AppColors.red, fontSize: 12, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                const T('亳州\n导览手账', '보저우\n손장 가이드', 'Bozhou\nCity Journal').of(lang),
                style: const TextStyle(fontSize: 47, height: .98, fontWeight: FontWeight.w900, letterSpacing: -1.2, color: AppColors.ink),
              ),
              const SizedBox(height: 10),
              Text(
                const T(
                  '把药都、曹魏故里、古街与酒香做成票据、印章和明信片式城市 UI。',
                  '약도, 조위 고장, 옛거리와 술 향기를 티켓, 도장, 엽서형 UI로 구성했습니다.',
                  'A journal-style city UI shaped by medicine, Cao Wei history, old streets and liquor culture.',
                ).of(lang),
                style: const TextStyle(color: AppColors.muted, fontSize: 14, height: 1.65, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Transform.rotate(
          angle: .09,
          child: Container(
            width: 110,
            height: 110,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: soft(AppColors.card, .62),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: soft(AppColors.red, .56), width: 2),
              boxShadow: [BoxShadow(color: soft(AppColors.red, .05), spreadRadius: 8, blurRadius: 0)],
            ),
            child: Text(
              const T('药都\nBOZHOU', '약도\nBOZHOU', 'BOZHOU\nANHUI').of(lang),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.red, fontSize: 17, height: 1.25, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ],
    );
  }
}

class BozhouMapCard extends StatelessWidget {
  const BozhouMapCard({super.key, required this.lang});
  final AppLanguage lang;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: soft(Colors.white, .92)),
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFFFF9ED), AppColors.paperDeep]),
        boxShadow: const [BoxShadow(color: Color(0x1F3D3020), blurRadius: 36, offset: Offset(0, 18))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: -34,
            right: -18,
            top: 92,
            child: Transform.rotate(
              angle: -.17,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: soft(AppColors.blue, .12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: soft(AppColors.blue, .42), width: 2),
                ),
              ),
            ),
          ),
          Positioned(left: 24, top: 22, child: MapBubble(label: const T('药材', '약재', 'Herbs').of(lang), color: AppColors.green)),
          Positioned(right: 24, top: 26, child: MapBubble(label: const T('古城', '고성', 'Old city').of(lang), color: AppColors.gold)),
          const Positioned(left: 48, top: 68, child: MapPin(label: '药', color: AppColors.red)),
          const Positioned(right: 70, top: 78, child: MapPin(label: '戏', color: AppColors.blue)),
          const Positioned(left: 156, bottom: 52, child: MapPin(label: '曹', color: AppColors.green)),
          const Positioned(right: 34, bottom: 58, child: MapPin(label: '酒', color: Color(0xFF8F5A2C))),
          Positioned(
            left: 18,
            right: 18,
            bottom: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        const T('涡河与药香', '와허와 약향', 'Wo River & Herbal Scent').of(lang),
                        style: const TextStyle(color: AppColors.ink, fontSize: 19, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        const T('花戏楼 · 华祖庵 · 曹操故里 · 古井酒香', '화시루 · 화조암 · 조조 고향 · 고정 술향', 'Huaxi Tower · Huazu Temple · Cao Cao · Gujing').of(lang),
                        style: const TextStyle(color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                ChipPill(label: const T('地图感', '지도 느낌', 'Map mood').of(lang)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MapBubble extends StatelessWidget {
  const MapBubble({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: soft(color, .12), borderRadius: BorderRadius.circular(999), border: Border.all(color: soft(color, .25))),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900)),
    );
  }
}

class MapPin extends StatelessWidget {
  const MapPin({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -.78,
      child: Container(
        width: 47,
        height: 47,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomRight: Radius.circular(17), bottomLeft: Radius.circular(4)),
          boxShadow: const [BoxShadow(color: Color(0x333D3020), blurRadius: 20, offset: Offset(0, 10))],
        ),
        child: Transform.rotate(
          angle: .78,
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}

class HighlightStrip extends StatelessWidget {
  const HighlightStrip({super.key, required this.lang});
  final AppLanguage lang;

  @override
  Widget build(BuildContext context) {
    final items = [
      (const T('华佗故里', '화타 고향', 'Hua Tuo'), Icons.spa_rounded, AppColors.green),
      (const T('曹魏故事', '조위 이야기', 'Cao Wei'), Icons.account_balance_rounded, AppColors.blue),
      (const T('古井酒香', '고정 술향', 'Gujing'), Icons.local_bar_rounded, AppColors.gold),
    ];

    return Row(
      children: items.map((item) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: soft(Colors.white, .58),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.line),
            ),
            child: Column(
              children: [
                Icon(item.$2, color: item.$3, size: 19),
                const SizedBox(height: 5),
                Text(item.$1.of(lang), textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: AppColors.muted, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class ChapterNav extends StatelessWidget {
  const ChapterNav({super.key, required this.lang, required this.page, required this.onChanged});
  final AppLanguage lang;
  final GuidePage page;
  final ValueChanged<GuidePage> onChanged;

  @override
  Widget build(BuildContext context) {
    final items = [GuidePage.intro, GuidePage.spots, GuidePage.food, GuidePage.route];
    final icons = {
      GuidePage.intro: Icons.auto_stories_rounded,
      GuidePage.spots: Icons.place_rounded,
      GuidePage.food: Icons.restaurant_menu_rounded,
      GuidePage.route: Icons.alt_route_rounded,
    };

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(color: soft(AppColors.paper, .88), borderRadius: BorderRadius.circular(24), border: Border.all(color: soft(Colors.white, .45))),
      child: Row(
        children: items.map((item) {
          final isActive = page == item;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Material(
                color: isActive ? AppColors.ink : soft(AppColors.card, .78),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: isActive ? Colors.transparent : AppColors.line)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => onChanged(item),
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icons[item], size: 17, color: isActive ? Colors.white : AppColors.muted),
                        const SizedBox(height: 4),
                        Text(pageTitle(item).of(lang), style: TextStyle(color: isActive ? Colors.white : AppColors.muted, fontSize: 11, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class IntroSection extends StatelessWidget {
  const IntroSection({super.key, required this.lang});
  final AppLanguage lang;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('intro'),
      children: [
        Row(
          children: [
            Expanded(child: FactCard(value: const T('500万+', '500만+', '5M+').of(lang), label: const T('常住人口量级', '인구 규모', 'Population scale').of(lang))),
            const SizedBox(width: 10),
            Expanded(child: FactCard(value: const T('3700+', '3700+', '3700+').of(lang), label: const T('历史记忆', '역사 기억', 'Years of memory').of(lang))),
            const SizedBox(width: 10),
            Expanded(child: FactCard(value: const T('药都', '약도', 'Medicine').of(lang), label: const T('城市名片', '도시 명함', 'City identity').of(lang))),
          ],
        ),
        const SizedBox(height: 14),
        TicketCard(
          title: const T('城市档案', '도시 파일', 'City File').of(lang),
          tag: 'INTRO',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                const T(
                  '亳州位于安徽西北部，古称谯，是一座兼具药香、曹魏文化与老城烟火的城市。沿着手账地图，可以从华佗故里认识中医药文化，从花戏楼和地下运兵道感受历史，再去老街寻找牛肉馍与古井酒香。',
                  '보저우는 안후이성 서북부에 있는 도시로, 옛 이름은 초입니다. 약초 향기, 조위 역사, 구도심의 생활감이 함께 남아 있습니다. 손장 지도를 따라 화타 고향, 화시루, 지하 운병도, 옛거리 음식까지 둘러볼 수 있습니다.',
                  'Bozhou is in northwest Anhui, historically known as Qiao. It blends herbal medicine culture, Cao Wei history and old-street daily life. Follow the journal map from Hua Tuo heritage to Huaxi Opera Tower, underground tunnels, beef mo and Gujing liquor culture.',
                ).of(lang),
                style: const TextStyle(color: Color(0xFF5D554C), fontSize: 14, height: 1.78, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChipPill(label: const T('国家历史文化名城', '국가 역사문화도시', 'Historic city').of(lang)),
                  ChipPill(label: const T('中华药都', '중화 약도', 'Medicine capital').of(lang)),
                  ChipPill(label: const T('华佗故里', '화타 고향', 'Hua Tuo').of(lang)),
                  ChipPill(label: const T('曹魏文化', '조위 문화', 'Cao Wei').of(lang)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}

class SpotsSection extends StatelessWidget {
  const SpotsSection({super.key, required this.lang, required this.filter, required this.onFilterChanged, required this.onSpotTap});
  final AppLanguage lang;
  final SpotCategory filter;
  final ValueChanged<SpotCategory> onFilterChanged;
  final ValueChanged<SpotItem> onSpotTap;

  @override
  Widget build(BuildContext context) {
    final filters = [SpotCategory.all, SpotCategory.heritage, SpotCategory.medicine, SpotCategory.caowei, SpotCategory.wine, SpotCategory.street];
    final visible = filter == SpotCategory.all ? spots : spots.where((item) => item.category == filter).toList();

    return Column(
      key: const ValueKey('spots'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filters.map((item) => FilterPill(label: categoryTitle(item).of(lang), active: filter == item, onTap: () => onFilterChanged(item))).toList(),
        ),
        const SizedBox(height: 12),
        ...visible.map((item) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Postcard(lang: lang, item: item, onTap: () => onSpotTap(item)))),
      ],
    );
  }
}

class FoodSection extends StatelessWidget {
  const FoodSection({super.key, required this.lang, required this.savedFoods, required this.onSaveTap});
  final AppLanguage lang;
  final Set<String> savedFoods;
  final ValueChanged<String> onSaveTap;

  @override
  Widget build(BuildContext context) {
    return TicketCard(
      key: const ValueKey('food'),
      title: const T('药都菜单', '약도 메뉴', 'Local Menu').of(lang),
      tag: 'MENU',
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: foods.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: .78),
        itemBuilder: (context, index) {
          final item = foods[index];
          return MenuCard(lang: lang, item: item, saved: savedFoods.contains(item.id), onTap: () => onSaveTap(item.id));
        },
      ),
    );
  }
}

class RouteSection extends StatefulWidget {
  const RouteSection({super.key, required this.lang, required this.routeIndex, required this.onRouteChanged});
  final AppLanguage lang;
  final int routeIndex;
  final ValueChanged<int> onRouteChanged;

  @override
  State<RouteSection> createState() => _RouteSectionState();
}

class _RouteSectionState extends State<RouteSection> {
  bool copied = false;

  @override
  Widget build(BuildContext context) {
    final plan = routes[widget.routeIndex];
    final stops = plan.stops;

    return Column(
      key: const ValueKey('route'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: List.generate(routes.length, (index) {
            final active = widget.routeIndex == index;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: RouteTab(
                  lang: widget.lang,
                  title: routes[index].title.of(widget.lang),
                  subtitle: routes[index].subtitle.of(widget.lang),
                  active: active,
                  stops: routes[index].stops.length,
                  onTap: () => widget.onRouteChanged(index),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        TicketCard(
          title: plan.title.of(widget.lang),
          tag: 'ROUTE',
          child: Column(children: [for (int i = 0; i < stops.length; i++) Padding(padding: EdgeInsets.only(bottom: i == stops.length - 1 ? 0 : 12), child: StopRow(lang: widget.lang, index: i + 1, stop: stops[i]))]),
        ),
        const SizedBox(height: 14),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: AppColors.ink, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
          onPressed: () {
            final copyText = '${plan.title.of(widget.lang)}\n${plan.stops.map((s) => '${s.time} ${s.title.of(widget.lang)} - ${s.note.of(widget.lang)}').join('\n')}';
            Clipboard.setData(ClipboardData(text: copyText));
            setState(() => copied = true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(const T('路线已复制', '코스를 복사했습니다', 'Route copied').of(widget.lang)),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(milliseconds: 900),
              ),
            );
            Future.delayed(const Duration(milliseconds: 1100), () {
              if (mounted) setState(() => copied = false);
            });
          },
          icon: Icon(copied ? Icons.check_circle_rounded : Icons.copy_rounded, size: 19),
          label: Text(copied ? const T('已复制路线', '복사 완료', 'Copied').of(widget.lang) : const T('复制路线', '코스 복사', 'Copy Route').of(widget.lang), style: const TextStyle(fontWeight: FontWeight.w900)),
        ),
      ],
    );
  }
}

class FactCard extends StatelessWidget {
  const FactCard({super.key, required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(color: soft(Colors.white, .62), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.line)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: const TextStyle(color: AppColors.red, fontSize: 18, fontWeight: FontWeight.w900)),
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 11, height: 1.35, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.title, required this.tag, required this.child});
  final String title;
  final String tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: soft(Colors.white, .82)),
            boxShadow: const [BoxShadow(color: Color(0x1A3D3020), blurRadius: 30, offset: Offset(0, 14))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text(title, style: const TextStyle(color: AppColors.ink, fontSize: 20, fontWeight: FontWeight.w900))),
                  const SizedBox(width: 8),
                  Text(tag, style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w900)),
                ],
              ),
              const SizedBox(height: 12),
              child,
            ],
          ),
        ),
        const Positioned(left: -12, top: 50, child: TicketHole()),
        const Positioned(right: -12, top: 50, child: TicketHole()),
      ],
    );
  }
}

class TicketHole extends StatelessWidget {
  const TicketHole({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 24, height: 24, decoration: BoxDecoration(color: AppColors.paper, border: Border.all(color: AppColors.line), shape: BoxShape.circle));
  }
}

class ChipPill extends StatelessWidget {
  const ChipPill({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(color: soft(Colors.white, .58), borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.line)),
      child: Text(label, style: const TextStyle(color: Color(0xFF6E5B3F), fontSize: 12, fontWeight: FontWeight.w900)),
    );
  }
}

class FilterPill extends StatelessWidget {
  const FilterPill({super.key, required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? AppColors.red : soft(Colors.white, .62),
      shape: StadiumBorder(side: BorderSide(color: active ? AppColors.red : AppColors.line)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          child: Text(label, style: TextStyle(color: active ? Colors.white : const Color(0xFF6E5B3F), fontSize: 12, fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}

class Postcard extends StatelessWidget {
  const Postcard({super.key, required this.lang, required this.item, required this.onTap});
  final AppLanguage lang;
  final SpotItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: soft(Colors.white, .72),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: BorderSide(color: soft(Colors.white, .82))),
      elevation: 2,
      shadowColor: const Color(0x123D3020),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 132),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 92,
                height: 108,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [item.color, Color.lerp(item.color, AppColors.ink, .35)!]),
                  borderRadius: BorderRadius.circular(21),
                ),
                child: Text(item.icon, style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(item.title.of(lang), maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.ink, fontSize: 17, fontWeight: FontWeight.w900))),
                        Text(categoryTitle(item.category).of(lang), style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(item.text.of(lang), maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.muted, fontSize: 12, height: 1.55, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text('${item.chips[0].of(lang)} · ${item.chips[1].of(lang)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w900)),
                        ),
                        const SizedBox(width: 6),
                        Text(const T('详情 →', '자세히 →', 'Details →').of(lang), style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w900)),
                      ],
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
}

class MenuCard extends StatelessWidget {
  const MenuCard({super.key, required this.lang, required this.item, required this.saved, required this.onTap});
  final AppLanguage lang;
  final FoodItem item;
  final bool saved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: soft(Colors.white, .70), borderRadius: BorderRadius.circular(24), border: Border.all(color: soft(Colors.white, .82)), boxShadow: const [BoxShadow(color: Color(0x143D3020), blurRadius: 24, offset: Offset(0, 12))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: item.color, borderRadius: BorderRadius.circular(18)),
                child: Text(item.icon, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900)),
              ),
              const Spacer(),
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: saved ? AppColors.red : Colors.white, borderRadius: BorderRadius.circular(999), border: Border.all(color: saved ? AppColors.red : AppColors.line)),
                  child: Text('♥', style: TextStyle(color: saved ? Colors.white : const Color(0xFF8B7B66), fontSize: 16, fontWeight: FontWeight.w900)),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(color: soft(item.color, .12), borderRadius: BorderRadius.circular(999)),
                child: Text(item.tag.of(lang), style: TextStyle(color: item.color, fontSize: 10, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(height: 6),
              Text(item.title.of(lang), maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.ink, fontSize: 16, fontWeight: FontWeight.w900)),
              const SizedBox(height: 5),
              Text(item.text.of(lang), maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.muted, fontSize: 12, height: 1.52, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}

class RouteTab extends StatelessWidget {
  const RouteTab({super.key, required this.lang, required this.title, required this.subtitle, required this.active, required this.stops, required this.onTap});
  final AppLanguage lang;
  final String title;
  final String subtitle;
  final bool active;
  final int stops;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? AppColors.blue : soft(Colors.white, .66),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: active ? AppColors.blue : AppColors.line)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: active ? Colors.white : AppColors.muted, fontSize: 13, fontWeight: FontWeight.w900)),
              const SizedBox(height: 3),
              Text(const T('3 站', '3곳', '3 stops').of(lang), style: TextStyle(color: active ? soft(Colors.white, .78) : soft(AppColors.muted, .78), fontSize: 11, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
    );
  }
}

class StopRow extends StatelessWidget {
  const StopRow({super.key, required this.lang, required this.index, required this.stop});
  final AppLanguage lang;
  final int index;
  final RouteStop stop;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
          child: Text('$index', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: soft(Colors.white, .68), borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.line)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stop.title.of(lang), style: const TextStyle(color: AppColors.ink, fontSize: 15, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text('${stop.time} · ${stop.note.of(lang)}', style: const TextStyle(color: AppColors.muted, fontSize: 12, height: 1.55, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CloseCircle extends StatelessWidget {
  const CloseCircle({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: soft(AppColors.ink, .08), borderRadius: BorderRadius.circular(999)),
        child: const Icon(Icons.close_rounded, size: 20, color: AppColors.ink),
      ),
    );
  }
}
