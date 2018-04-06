//
//  ArticleClient.swift
//  FemininBio
//
//  Created by Mouna EL AMRI on 06/04/2018.
//  Copyright © 2018 Mouna EL AMRI. All rights reserved.
//

import Alamofire
import RxSwift
import RxAlamofire
import RxCocoa

class ArticleClient {
    let disposeBag = DisposeBag()
    func getArticles(articles: BehaviorRelay<[ArticleModel]>, isSuccess: BehaviorRelay<(Bool,String)>) {
        let dataSource = ConfigurationHelper.getConfigForKey(key: "listeArticleURL")
        RxAlamofire.requestData(.get, dataSource).debug().subscribe(onNext: { (response, data) in
            if 200..<300 ~= response.statusCode {
                do {
                    let array = try JSONDecoder().decode([ArticleModel].self, from: data)
                    articles.accept(array)
                    isSuccess.accept((true, ""))
                } catch let error as DecodingError {
                    isSuccess.accept((false, error.localizedDescription))
                } catch {
                    isSuccess.accept((false, "TechnicalError"))
                }
            } else {
                isSuccess.accept((false,""))
            }
        }, onError: { (_) in
            isSuccess.accept((false, "TechnicalError"))
        }).disposed(by: disposeBag)
    }
    func getArticlesByPage(articles: BehaviorRelay<[ArticleModel]>, isSuccess: BehaviorRelay<(Bool,String)>,pageNumber: Int) {
        let dataSource = ConfigurationHelper.getConfigForKey(key: "listeArticleURL").replacingOccurrences(of: "{page}", with: String(pageNumber))
        
        RxAlamofire.requestData(.get, dataSource).debug().subscribe(onNext: { (response, data) in
            if 200..<300 ~= response.statusCode {
                do {
                    let array = try JSONDecoder().decode([ArticleModel].self, from: data)
                    articles.accept(array)
                    isSuccess.accept((true, ""))
                } catch let error as DecodingError {
                    isSuccess.accept((false, error.localizedDescription))
                } catch {
                    isSuccess.accept((false, "TechnicalError"))
                }
            } else {
                isSuccess.accept((false,""))
            }
        }, onError: { (_) in
            isSuccess.accept((false, "TechnicalError"))
        }).disposed(by: disposeBag)
    }
    func getArticleDetails(articleDetails: BehaviorRelay<ArticleDetailsModel>, isSuccess: BehaviorRelay<(Bool,String)>, articleId: String) {
        let dataSource = ConfigurationHelper.getConfigForKey(key: "articleDetailsURL").replacingOccurrences(of: "{id}", with: articleId)
        RxAlamofire.requestData(.get, dataSource).debug().subscribe(onNext: { (response, data) in
            if 200..<300 ~= response.statusCode {
                do {
                    let details = try JSONDecoder().decode(ArticleDetailsModel.self, from: data)
                    articleDetails.accept(details)
                    isSuccess.accept((true, ""))
                } catch let error as DecodingError {
                    isSuccess.accept((false, error.localizedDescription))
                } catch {
                    isSuccess.accept((false, "TechnicalError"))
                }
            } else {
                isSuccess.accept((false, ""))
            }
        }, onError: { (_) in
            isSuccess.accept((false, "TechnicalError"))
        }).disposed(by: disposeBag)
    }
}
