# 플랫폼 상세 비교

## 모바일 개발 플랫폼 비교표

| 항목 | Flutter | React Native | Android Native | iOS Native |
|------|---------|--------------|----------------|------------|
| 언어 | Dart | JavaScript / TypeScript | Kotlin / Java | Swift |
| 크로스플랫폼 | ✅ Android + iOS + Web | ✅ Android + iOS | ❌ Android 전용 | ❌ iOS 전용 |
| 성능 | ⭐⭐⭐⭐ (자체 렌더링) | ⭐⭐⭐ (JS 브릿지) | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| UI 일관성 | ⭐⭐⭐⭐⭐ (완전 동일) | ⭐⭐⭐ (플랫폼별 차이) | ⭐⭐⭐ | ⭐⭐⭐ |
| 생태계 / 패키지 | pub.dev (풍부) | npm (매우 풍부) | Maven | CocoaPods |
| 학습 곡선 | 중간 (Dart 학습) | 낮음 (JS 기반) | 중간 | 중간 |
| 핫 리로드 | ✅ | ✅ | ❌ | ❌ |
| 기업 채택 | Google, Alibaba 등 | Facebook, Microsoft 등 | - | - |

## 본 프로젝트 선택: Flutter

**선택 이유 요약**
- 단일 코드베이스로 Android/iOS 동시 지원
- `table_calendar`, `flutter_riverpod` 등 필요 패키지 모두 존재
- Material 3 디자인 내장으로 빠른 UI 개발 가능
- 수업 커리큘럼과 일치

## Flutter 주요 특징

### 렌더링 방식
React Native는 플랫폼 네이티브 컴포넌트를 사용하지만,
Flutter는 **Skia / Impeller 엔진**으로 직접 픽셀을 그린다.
→ 플랫폼 간 UI가 100% 동일하게 보임

### Dart 언어
- 강타입 언어 (타입 안전성)
- JIT (개발 중 핫 리로드) + AOT (배포 시 네이티브 컴파일) 지원
- `async/await` 기본 내장

### 위젯 시스템
- 모든 UI 요소가 위젯 (Widget)
- `StatelessWidget` / `StatefulWidget` / `ConsumerWidget` 구분
- 위젯 트리(Widget Tree) 구조로 UI 구성
