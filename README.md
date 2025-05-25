# SKKUBUS-flutter

[![Flutter Version](https://img.shields.io/badge/Flutter-3.22.2-02569B?logo=flutter&logoColor=white)](https://flutter.dev) [![Dart Version](https://img.shields.io/badge/Dart-3.4.3-0175C2?logo=dart&logoColor=white)](https://dart.dev) [![GetX](https://img.shields.io/badge/GetX-4.6.5-33A0FF?logo=get&logoColor=white)](https://pub.dev/packages/get)

> **성균관대학교 버스 앱 ‘스꾸버스’** <br>
> Flutter 기반으로 Android와 iOS를 단일 코드로 지원합니다.

<br>

## Table of Contents

- [Architecture](#architecture)
- [Resources](#resources)
- [Download](#download)
- [About](#about)
- [Contribution Guide](#contribution-guide)

## Architecture

GetX를 활용하여 상태 관리, 라우팅, 의존성 주입을 일원화했습니다.

```plaintext
- android: 안드로이드 설정 및 네이티브 코드
- ios    : iOS 설정 및 네이티브 코드
- assets : 폰트, 이미지, Lottie 등
- lib    : Dart 소스코드
    ├─ admob
    ├─ app
    └─ notification
```

## Resources

- 스꾸버스 웹뷰: https://github.com/spencer0124/SKKUBUS_webview
- 스꾸버스 서버: https://github.com/spencer0124/SKKUBUS-server-express
- 스꾸버스 지도 데이터: https://github.com/spencer0124/SKKUBUS-data

## Download

[![Play Store](https://img.shields.io/badge/Google%20Play-Visit-green?logo=google-play&logoColor=white)](https://shorturl.ac/skkubus_and) [![App Store](https://img.shields.io/badge/App%20Store-Visit-blue?logo=app-store&logoColor=white)](https://shorturl.ac/skkubus_ios)

## About

성균웹진 '성대생은 지금' 최신호에서 [인터뷰](https://webzine.skku.edu/skkuzine/section/people01.do?articleNo=109617&pager.offset=0&pagerLimit=10)를 진행했습니다.

## Contribution Guide

추가 예정
