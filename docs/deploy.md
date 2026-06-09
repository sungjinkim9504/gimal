# 배포 가이드 — AI 감정 일기

## 배포 대상

| 플랫폼 | 방법 | 용도 |
|--------|------|------|
| Web (GitHub Pages) | `flutter build web` → push | 데모·발표용 |
| Android APK | `flutter build apk` | 실기기 테스트·제출용 |
| Windows | `flutter build windows` | 로컬 데스크탑 실행 |

---

## 1. Web 배포 (GitHub Pages)

### 빌드

```bash
flutter build web --release --base-href /gimal/
```

> `--base-href /gimal/` 은 GitHub Pages 리포지토리명과 일치해야 합니다.

### 배포

```bash
# build/web/ 내용을 gh-pages 브랜치로 push
git subtree push --prefix build/web origin gh-pages
```

또는 GitHub Actions로 자동 배포 (추후 설정 예정).

### 접근 URL

```
https://sungjinkim9504.github.io/gimal/
```

> **주의:** Web 빌드 시 `.env` 파일이 번들에 포함됩니다.  
> API 키가 공개되지 않도록 발표용 Web 빌드에서는 API 키를 제거하거나 빈 값으로 설정하세요.

---

## 2. Android APK 빌드

### 사전 요구사항

- Android Studio 설치 또는 Android SDK 설치
- `flutter doctor` 에서 Android toolchain ✅ 확인

### 빌드

```bash
# debug APK (테스트용)
flutter build apk --debug

# release APK (제출용)
flutter build apk --release
```

출력 위치: `build/app/outputs/flutter-apk/app-release.apk`

### 기기 설치

```bash
flutter install
```

---

## 3. 환경변수 처리

| 환경 | API 키 위치 | 비고 |
|------|------------|------|
| 개발 | `.env` 파일 | `.gitignore` 등록됨 |
| Web 빌드 | `assets/.env` 번들 포함 | 공개 배포 시 주의 |
| Android 배포 | `.env` 파일 포함 | APK 내 포함됨 |

---

## 4. 발표용 데모 체크리스트

- [ ] `.env`에 유효한 `GEMINI_API_KEY` 입력 확인
- [ ] `flutter run -d chrome` 으로 정상 실행 확인
- [ ] 일기 작성 → AI 코멘트 생성 흐름 1회 테스트
- [ ] 발표 URL `https://sungjinkim9504.github.io/gimal/` 브라우저에서 열림 확인
- [ ] 스마트폰 타이머 앱 준비

---

## 관련 문서

- [개발 환경 설정](setup.md)
- [시스템 아키텍처](architecture.md)
