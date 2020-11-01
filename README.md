# stock_app
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

## My Stock Manager
나의 주식종목 관리앱

## 기능 
- 주식 종목 폴더 생성, 나의 관심 종목 추가 
- 관심종목 관련 뉴스 업로드, 메인화면에 코스피관련 뉴스 업로드 
- 뉴스 검색(Naver search API)
- 관심 종목관련 이슈 등록 기능 (메모) 

## Study
- AutoLayout (Code, Storyboard)
- SnapKit
- API 사용법 및 Networking
- sync, async using DispatchQueue
- Custom Xib (tableView, collectionView, CustomView)
- RealmSwift (Using List, notification) 
- Webkit (Load url, WKWebView)
- Text Attribute 

## Image
<div>
<img width="200" src="https://user-images.githubusercontent.com/48856104/93471572-7d0c6e80-f92e-11ea-85b0-8b5e806c5e6c.png">
<img width="200" src="https://user-images.githubusercontent.com/48856104/93471667-9e6d5a80-f92e-11ea-96d5-a85b7c3bc58d.png">
<img width="200" src="https://user-images.githubusercontent.com/48856104/93471709-ad540d00-f92e-11ea-98b4-ad2137dde28f.png">
</div>


## Issue 
- **realm을 사용하면서 하나의 model객체를 저장하는것만 가능하였으나 array형식으로 넣어야하는 상황이 발생함 (한 폴더에 여러개의 데이터를 넣어야함)**
헤결: **Realm공식문서를 참고** 1대 다의 관계부분을 보고 List속성을 이용햇 해결함 
- **주식 content를 넣을때 textView에서 각 문장을 구별해야하는 문젝 생김**
해결: (Stackoverflow검색)NSAttributeString을 이용하여 한 문장당 맨앞에 불릿이 만들어지게 구현함
- **naver new 제목을 불러올때 html태그도 함께 나타나는 문제가 발생함**
해결: (Stackoverflow검색)NSAttributeString.DocumentReadingOptionKey를 이용 - documentType, characterEncoding 속성 사용 


