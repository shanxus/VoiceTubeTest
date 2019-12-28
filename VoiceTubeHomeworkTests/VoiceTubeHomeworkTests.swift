//
//  VoiceTubeHomeworkTests.swift
//  VoiceTubeHomeworkTests
//
//  Created by ShanOvO on 2019/12/17.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import XCTest
@testable import VoiceTubeHomework

class VoiceTubeHomeworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test for the number of required settings.
    func test_number_of_setting_cases() {
        let casesCount = Settings.allCases.count
        let currentSettingsRequiredCount = 5
        
        XCTAssertEqual(casesCount, currentSettingsRequiredCount)
    }
    
    // Test for the extension function: toData().
    func test_to_data_extension() {
        let trueDic = ["key":"value"]
        let trueData = trueDic.toData()
        
        XCTAssertNotNil(trueData)
    }

    // Test for the functionality of Video DAO.
    func test_video_dao() {
        let dao = VideoDAO()
        
        let testTitle = "testTitle"
        let testImageURL = "com.voiceTube.testURL.image"
        let video = Video(title: testTitle, img: testImageURL)
        let rmVideo = dao.transform(video: video)
        
        XCTAssertEqual(rmVideo.title, testTitle)
        XCTAssertEqual(rmVideo.img, testImageURL)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
