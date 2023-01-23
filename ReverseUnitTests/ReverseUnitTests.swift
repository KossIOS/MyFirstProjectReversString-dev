//
//  ReverseUnitTests.swift
//  ReverseUnitTests
//
//  Created by Konstantyn Koroban on 04/11/2022.
//

import XCTest
@testable import MyFirstProjectMyFirstProjectReversString

class ReverseUnitTests: XCTestCase {
    
    var sut: ReversePhraseService!
    
    override func setUp() {
        super.setUp()
        sut = ReversePhraseService()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testReversePhraseEmptyString() {
        XCTAssert(sut.reverse(phrase: "").isEmpty)
    }
    
    func testReversePhraseEmptyStringEmptyExclusion() {
        XCTAssert(sut.reverse(phrase: "", ignoredCharacters: "").isEmpty)
    }
    
    func testReversePhraseDefaultExclusion() {
        let sentenceToReverse = "abcd efgh"
        let expectedOutcome = "dcba hgfe"
        XCTAssertEqual(expectedOutcome, sut.reverse(phrase: sentenceToReverse))
    }
    
    func testReversePhraseDefaultExclusionWithNumbers() {
        let sentenceToReverse = "a1bcd efg!h"
        let expectedOutcome = "d1cba hgf!e"
        XCTAssertEqual(expectedOutcome, sut.reverse(phrase: sentenceToReverse))
    }
    
    func testReversePhraseSingleWordString() {
        let sentenceToReverse = "Swift"
        let expectedOutcome = "tfiwS"
        XCTAssertEqual(expectedOutcome, sut.reverse(phrase: sentenceToReverse))
    }
    
    func testReversePhraseStringEmptyExclusion() {
        let sentenceToReverse = "a1bcd efg!h"
        let ignoredCharacters = ""
        let expectedOutcome = "dcb1a h!gfe"
        XCTAssertEqual(expectedOutcome, sut.reverse(phrase: sentenceToReverse, ignoredCharacters: ignoredCharacters))
    }
    
    func testReversePhraseStringCustomExclusion() {
        let sentenceToReverse = "Foxminded cool 24/7"
        let ignoredCharacters = "Foxminded"
        let expectedOutcome = "Foxminded looc 7/42"
        XCTAssertEqual(expectedOutcome, sut.reverse(phrase: sentenceToReverse, ignoredCharacters: ignoredCharacters))
    }
    
    func testReversePhraseEmptyStringCustomExclusion() {
        XCTAssert(sut.reverse(phrase: "", ignoredCharacters: "123").isEmpty)
    }
    
    func testReversePhraseStringCustomExclusionCharacters() {
        let ignoredCharacters = "xl"
        let sentenceToReverse = "Foxminded cool 24/7"
        let expectedOutcome = "dexdnimoF oocl 7/42"
        XCTAssertEqual(expectedOutcome, sut.reverse(phrase: sentenceToReverse, ignoredCharacters: ignoredCharacters))
    }
    
    func testReversePhraseStringCustomSpecialCharacters() {
        let ignoredCharacters = "xl"
        let sentenceToReverse = "abcd efgh"
        let expectedOutcome = "dcba hgfe"
        XCTAssertEqual(expectedOutcome, sut.reverse(phrase: sentenceToReverse, ignoredCharacters: ignoredCharacters))
    }
    
    func testReversePhraseStringCustomSpecialCharactersWithNumbers() {
        let ignoredCharacters = "xl"
        let sentenceToReverse = "a1bcd efglh"
        let expectedOutcome = "dcb1a hgfle"
        XCTAssertEqual(expectedOutcome, sut.reverse(phrase: sentenceToReverse, ignoredCharacters: ignoredCharacters))
    }
}
