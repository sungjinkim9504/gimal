# ADR-0001: 모바일 프레임워크 선택

- **날짜**: 2026-06-01
- **상태**: 확정

---

## 배경

AI 감정 일기 앱을 모바일로 개발하기 위한 프레임워크를 선택해야 했다.
Android / iOS 모두 지원해야 하며, 빠른 개발 속도가 중요했다.

## 선택지

| 프레임워크 | 장점 | 단점 |
|-----------|------|------|
| **Flutter** | 크로스플랫폼, 빠른 UI 개발, 강력한 위젯 생태계 | Dart 언어 학습 필요 |
| React Native | JS 기반으로 진입장벽 낮음 | 성능 이슈, 네이티브 브릿지 복잡 |
| Android Native (Kotlin) | 최고 성능, 공식 지원 | iOS 별도 개발 필요, 개발 속도 느림 |

## 결정

**Flutter** 선택

## 이유

- 하나의 코드베이스로 Android / iOS 동시 지원 가능
- `table_calendar`, `flutter_riverpod` 등 필요한 패키지가 모두 존재
- Material 3 디자인 시스템이 기본 내장되어 UI 구성이 빠름
- 수업에서 Flutter를 학습 중이므로 익숙한 환경

## 결과

Flutter + Dart로 개발 진행. `pubspec.yaml` 기반 의존성 관리,
feature-first 폴더 구조 채택. Android 기기에서 정상 실행 확인.
