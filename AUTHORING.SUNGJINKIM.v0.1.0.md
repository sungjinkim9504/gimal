# AUTHORING — SUNG JIN KIM · v0.1.0

## 본인 소개

- **이름**: 김성진 (SUNG JIN KIM)
- **역할**: 기획 · 설계 · 개발 (1인 프로젝트)
- **프로젝트**: AI 감정 일기 (Project Gimal)

---

## 담당 영역

| 영역 | 내용 |
|------|------|
| 기획 | 앱 비전 정의, 요구사항 분석, WBS/일정 작성 |
| 설계 | 화면 구성, 데이터 모델 설계, 상태 관리 설계 |
| 프론트엔드 | Flutter 전체 UI 구현 (3개 화면) |
| AI 연동 | Gemini API 호출, 감정 분석 프롬프트 설계 |
| 인프라 | 로컬 저장소 설계, .env 기반 보안 관리 |

---

## 기술 스택 (본인 사용)

- **언어**: Dart
- **프레임워크**: Flutter
- **상태 관리**: flutter_riverpod (StateNotifier, FutureProvider)
- **라우팅**: go_router
- **AI**: Google Gemini 1.5 Flash API
- **저장**: SharedPreferences
- **협업 도구**: AI Agent (Claude Code)

---

## 이번 버전(v0.1.0)에서 한 것

- AI 감정 일기 앱 MVP 구현
- 일기 작성 / 수정 / 삭제 기능
- Gemini AI 기반 감정 이모지 + 조언 코멘트 자동 생성
- 월별 캘린더 뷰에 감정 이모지 마킹
- .env 기반 API 키 보안 관리

---

## 배운 점 / 반성

- Riverpod의 `FutureProvider.autoDispose.family` 패턴을 처음 써봤고 AI 비동기 작업에 적합함을 확인
- AI API 모델 선택(2.0 → 1.5)이 안정성에 영향을 줌 — 최신 모델이 항상 좋은 것은 아님
- `.env` 파일 관리와 `.gitignore` 처리의 중요성을 실감

---

*최초 작성: 2026-06-01*
