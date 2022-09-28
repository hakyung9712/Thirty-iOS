//
//  BucketAPI.swift
//  Thirty
//
//  Created by 송하경 on 2022/09/04.
//

import RxSwift
import Moya

enum BucketAPI {
    case addNewbie(_ challengeId: Int)
    case addCurrent(_ challengeId: Int)
    case getBucketList(_ status: String?)
    case getBucketDetail(_ bucketId: String)
    case enrollBucketAnswer(_ bucketId: String, _ bucketAnswer: BucketAnswer)
}

extension BucketAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://15.165.64.36:3000/api/v1")!
    }
    
    var path: String {
        switch self {
        case .addNewbie:
            return "/buckets/add/newbie"
        case .addCurrent:
            return "/buckets/add/current"
        case .getBucketList:
            return "/buckets"
        case .getBucketDetail(let bucketId):
            return "/buckets/\(bucketId)"
        case .enrollBucketAnswer(let bucketId, _):
            return "/buckets/\(bucketId)"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addNewbie, .addCurrent, .enrollBucketAnswer:
            return .post
        case .getBucketList, .getBucketDetail:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .addNewbie(let challengeId):
            return [
                "uuid": UUID().uuidString,
                "challenge": challengeId
            ]
        case .addCurrent(let challengeId):
            return [
                "challenge": challengeId
            ]
        case .enrollBucketAnswer(_, let bucketAnswer):
            return [
                "date": bucketAnswer.date,
                "stamp": bucketAnswer.stamp,
                "image": bucketAnswer.image ?? "",
                "music": bucketAnswer.music ?? "",
                "detail": bucketAnswer.detail ?? ""
            ]
        default:
            return nil
        }
    }
    
    var task: Task {
        switch self {
        case .getBucketList(let statusString):
            return .requestParameters(parameters: ["status": statusString ?? ""], encoding: URLEncoding.default)
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            }
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .addCurrent, .getBucketList, .getBucketDetail, .enrollBucketAnswer:
            return [
                "Authorization": "Bearer \(TokenManager.shared.loadAccessToken() ?? "")"
            ]
        case .addNewbie:
            return ["Content-Type": "application/json"]
        }
    }
}
