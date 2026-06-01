# docs/setup.md 템플릿

> 이 파일을 복사하여 `docs/setup.md`로 사용하세요.
> 새 팀원 또는 다른 기기에서 프로젝트를 실행할 때 필요한 모든 내용을 담습니다.

---

# 개발 환경 설정 가이드

## 요구 사항

| 항목 | 버전 | 확인 방법 |
|------|------|-----------|
| Flutter SDK | 3.x 이상 | `flutter --version` |
| Dart SDK | 3.9.x 이상 | `dart --version` |
| Android Studio | 최신 권장 | - |
| Android SDK | API 21 이상 | Android Studio SDK Manager |
| Git | 최신 | `git --version` |

## 1. 리포지토리 클론

```bash
git clone https://github.com/sungjinkim9504/gimal.git
cd gimal
```

## 2. 패키지 설치

```bash
flutter pub get
```

## 3. 환경변수 설정 (필수)

프로젝트 루트에 `.env` 파일을 생성합니다.
`.env` 파일은 보안상 Git에 포함되지 않으므로 **직접 생성**해야 합니다.

```bash
# .env 파일 생성
echo "GEMINI_API_KEY=여기에_API_키_입력" > .env
```

**Gemini API 키 발급:**
1. [aistudio.google.com](https://aistudio.google.com) 접속
2. "Get API key" 버튼 클릭
3. 생성된 키(`AIza...`)를 `.env`에 입력

## 4. 앱 실행

```bash
# 연결된 기기 확인
flutter devices

# 앱 실행
flutter run

# 특정 기기 지정 실행
flutter run -d <device_id>
```

## 5. 빌드

```bash
# Android APK 빌드
flutter build apk --release

# Android App Bundle 빌드
flutter build appbundle --release
```

## 폴더 구조

```
lib/
├── core/           # 전역 설정 (라우터, 테마)
├── features/
│   ├── diary/      # 일기 기능
│   ├── ai/         # AI 감정 분석
│   └── settings/   # 설정
└── main.dart
```

## 주요 패키지

| 패키지 | 용도 |
|--------|------|
| flutter_riverpod | 상태 관리 |
| go_router | 화면 라우팅 |
| table_calendar | 캘린더 UI |
| dio | HTTP 클라이언트 |
| shared_preferences | 로컬 데이터 저장 |
| flutter_dotenv | 환경변수 로드 |

## 문제 해결

| 증상 | 해결 방법 |
|------|-----------|
| `flutter pub get` 실패 | Flutter SDK 버전 확인 |
| AI 코멘트 오류 (429) | Gemini API 키 확인, 잠시 후 재시도 |
| `.env` 파일 없음 오류 | 프로젝트 루트에 `.env` 파일 생성 |
| 앱 실행 안 됨 | `flutter doctor` 실행 후 오류 확인 |
