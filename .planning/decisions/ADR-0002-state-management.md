# ADR-0002: 상태 관리 라이브러리 선택

- **날짜**: 2026-06-01
- **상태**: 확정

---

## 배경

Flutter 앱에서 일기 목록, AI 분석 결과 등의 상태를 여러 화면이 공유해야 한다.
화면 간 데이터 전달을 단순히 생성자로 넘기면 깊이가 깊어질수록 관리가 어렵다.

## 선택지

| 라이브러리 | 장점 | 단점 |
|-----------|------|------|
| **Riverpod** | 컴파일 타임 안전성, 테스트 용이, 의존성 주입 내장 | 초기 학습 곡선 |
| Provider | 공식 권장, 단순함 | Riverpod보다 타입 안전성 낮음 |
| GetX | 코드량 최소화, 라우팅 통합 | 과도한 마법, 테스트 어려움 |
| BLoC | 명확한 구조, 대규모 프로젝트 적합 | 보일러플레이트 과다 |

## 결정

**flutter_riverpod 2.x** 선택 (`StateNotifierProvider` + `FutureProvider.family`)

## 이유

- `StateNotifierProvider`로 일기 목록 CRUD 상태를 깔끔하게 관리 가능
- `FutureProvider.autoDispose.family`로 AI 분석을 화면 단위로 트리거 가능
- `autoDispose`로 화면을 벗어나면 자동 메모리 해제
- Provider보다 타입 안전하고, BLoC보다 보일러플레이트가 적음

## 결과

- `DiaryNotifier extends StateNotifier<List<DiaryEntry>>` 로 일기 상태 관리
- `generateAiCommentProvider` 로 AI 분석을 상세 화면 진입 시 자동 실행
- `ApiKeyNotifier`로 API 키 영속성 관리
