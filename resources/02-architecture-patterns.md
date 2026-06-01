# 모바일 앱 아키텍처 패턴

## 주요 패턴 비교

| 패턴 | 구조 | 특징 | 적합한 규모 |
|------|------|------|-------------|
| MVC | Model - View - Controller | 단순, 입문용 | 소규모 |
| MVP | Model - View - Presenter | 테스트 용이 | 중소규모 |
| MVVM | Model - View - ViewModel | 데이터 바인딩 | 중대규모 |
| Clean Architecture | Domain / Data / Presentation | 완전한 관심사 분리 | 대규모 |
| **Feature-first** | 기능 단위 폴더 구조 | 모듈화, 직관적 | **중소규모 ✅** |

---

## 본 프로젝트 적용: Feature-first + Riverpod

### 폴더 구조

```
lib/
├── core/                   # 전역 공통 (라우터, 테마, 상수)
│   ├── constants/
│   ├── router/
│   ├── theme/
│   └── utils/
├── features/               # 기능 단위 모듈
│   ├── diary/              # 일기 기능
│   │   ├── models/         # 데이터 모델
│   │   ├── repositories/   # 저장소 (데이터 접근)
│   │   ├── providers/      # 상태 관리 (Riverpod)
│   │   ├── screens/        # 화면 UI
│   │   └── widgets/        # 재사용 위젯
│   ├── ai/                 # AI 기능
│   │   ├── services/       # API 호출
│   │   └── providers/      # AI 상태 관리
│   └── settings/           # 설정 기능
└── shared/                 # features 간 공유 위젯
```

### 레이어별 역할

```
[Screen / Widget]  ← UI 렌더링만 담당
      ↓ watch/read
[Provider]         ← 상태 관리, 비즈니스 로직
      ↓
[Repository]       ← 데이터 접근 추상화
      ↓
[Service / Storage] ← 실제 API 호출, DB 저장
```

---

## Riverpod 상태 관리 패턴

### 사용한 Provider 종류

| Provider | 사용 목적 | 예시 |
|----------|-----------|------|
| `StateNotifierProvider` | CRUD 상태 관리 | DiaryNotifier (일기 목록) |
| `FutureProvider.family` | 비동기 작업 | generateAiCommentProvider |
| `Provider` | 의존성 주입 | GeminiService 인스턴스 |

### StateNotifier 패턴

```dart
// 상태 정의
class DiaryNotifier extends StateNotifier<List<DiaryEntry>> {
  DiaryNotifier(this._repo) : super([]) { _load(); }

  // 상태 변경 메서드
  Future<void> addEntry(...) async { ... state = [...state, entry]; }
  Future<void> updateEntry(...) async { ... state = state.map(...).toList(); }
}

// 화면에서 사용
final entries = ref.watch(diaryNotifierProvider);
```

### FutureProvider.autoDispose.family 패턴

```dart
// 화면별 비동기 작업 (autoDispose: 화면 이탈 시 자동 취소)
final generateAiCommentProvider =
    FutureProvider.autoDispose.family<void, String>((ref, entryId) async {
  // entryId별로 독립적인 Provider 인스턴스 생성
  ...
});

// 화면에서 사용
final aiState = ref.watch(generateAiCommentProvider(entry.id));
aiState.when(
  loading: () => CircularProgressIndicator(),
  data: (_) => Text(entry.aiComment!),
  error: (e, _) => Text('오류: $e'),
);
```
