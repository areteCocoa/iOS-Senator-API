//
//  Senator.swift
//  LearningCollections
//
//  Created by Thomas Ring on 10/12/18.
//  Copyright © 2018 TJRing Studios. All rights reserved.
//

import Foundation

//"extra": {
//	"address": "709 Hart Senate Office Building Washington DC 20510",
//	"contact_form": "https://www.baldwin.senate.gov/feedback",
//	"fax": "202-225-6942",
//	"office": "709 Hart Senate Office Building",
//	"rss_url": "http://www.baldwin.senate.gov/rss/feeds/?type=all"
//},

private struct SenatorJSON {
	static func date(withJSON json: [String: Any], fromKey key: String) -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-mm-dd"
		let value = json[key] as! String
		return dateFormatter.date(from: value)!
	}
}

struct SenatorPerson {
	init(json: [String: Any]) {
		bioGuideID = json["bioguideid"] as! String
		birthday = SenatorJSON.date(withJSON: json, fromKey: "birthday")
		cSpanID = json["cspanid"] as? Int
		firstName = json["firstname"] as! String
		gender = json["gender"] as! String
		genderLabel = json["gender_label"] as! String
		lastName = json["lastname"] as! String
		link = json["link"] as! String
		middleName = json["middlename"] as! String
		name = json["name"] as! String
		nameMod = json["namemod"] as! String
		nickname = json["nickname"] as! String
		osID = json["osid"] as! String
		pvsID = json["pvsid"] as? String
		sortName = json["sortname"] as! String
		twitterID = json["twitterid"] as? String
		youtubeID = json["youtubeid"] as? String
	}
	let bioGuideID: String
	let birthday: Date
	let cSpanID: Int?
	let firstName: String
	let gender: String
	let genderLabel: String
	let lastName: String
	let link: String
	let middleName: String
	let name: String
	let nameMod: String
	let nickname: String
	let osID: String
	let pvsID: String?
	let sortName: String
	let twitterID: String?
	let youtubeID: String?
}

struct SenatorExtra {

}

struct Senator {
	init(json: [String: Any]) {
		if let numbers = json["congress_numbers"] as? [NSNumber] {
			congressNumbers = numbers.map { $0.intValue }
		} else { fatalError() }
		description = json["description"] as! String
		endDate = SenatorJSON.date(withJSON: json, fromKey: "enddate")
		//extra
		leadershipTitle = json["leadership_title"] as? String
		party = json["party"] as! String
		person = SenatorPerson(json: (json["person"] as! [String: Any]))
		phone = json["phone"] as! String
		roleType = json["role_type"] as! String
		roleTypeLabel = json["role_type_label"] as! String
		senatorClass = json["senator_class"] as! String
		senatorClassLabel = json["senator_class_label"] as! String
		senatorRank = json["senator_rank"] as! String
		senatorRankLabel = json["senator_rank_label"] as! String
		startDate = SenatorJSON.date(withJSON: json, fromKey: "startdate")
		state = json["state"] as! String
		title = json["title"] as! String
		titleLong = json["title_long"] as! String
		website = json["website"] as! String
	}

	var congressNumbers: [Int]
	var description: String
	var endDate: Date
	// var extra: [[String: Any]]
	var leadershipTitle: String?
	var party: String
	var person: SenatorPerson
	var phone: String
	var roleType: String
	var roleTypeLabel: String
	var senatorClass: String
	var senatorClassLabel: String
	var senatorRank: String
	var senatorRankLabel: String
	var startDate: Date
	var state: String
	var title: String
	var titleLong: String
	var website: String
}
