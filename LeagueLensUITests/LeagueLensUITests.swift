//
//  LeagueLensUITests.swift
//  LeagueLensUITests
//
//  Created by Ahmet Tunahan Bekdaş on 23.04.2024.
//

import XCTest

final class LeagueLensUITests: XCTestCase {
    
    func testToLeaguDetails() {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let selectedLeague = collectionViewsQuery.cells.containing(.staticText, identifier:"Ligue 1").element
        let scrollTeams = collectionViewsQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"6.").element/*[[".cells.containing(.staticText, identifier:\"WLDLL\").element",".cells.containing(.staticText, identifier:\"P: 46\").element",".cells.containing(.staticText, identifier:\"Lens\").element",".cells.containing(.staticText, identifier:\"6.\").element"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        selectedLeague.tap()
        scrollTeams.swipeUp()
    }
    
    func testAddFavoritesLeague() {
        let app = XCUIApplication()
        app.launch()
        
        let addFavoriteLeague = app.collectionViews.cells.containing(.staticText, identifier:"Ligue 1").buttons["favorite"]
        let tappedOkay = app/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"Success\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.buttons["Okay"]
        let tappedFavoriteTab = app.tabBars["Tab Bar"].buttons["Favorites"]
        
        addFavoriteLeague.tap()
        tappedOkay.tap()
        tappedFavoriteTab.tap()
    }
    
    func testDeleteFavoritesLeague() {
        let app = XCUIApplication()
        app.launch()
        
        let addFavoriteLeague = app.collectionViews.cells.containing(.staticText, identifier:"Premier League").buttons["favorite"]
        let tappedOkay = app/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"Success\"].scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.buttons["Okay"]
        let tappedFavoriteTab = app.tabBars["Tab Bar"].buttons["Favorites"]
        
        let tableView = app.tables.element
        
        let firstCell = tableView.cells.element(boundBy: 0)
        let swipteFavoriteCell = firstCell
        
        let deleteButton = firstCell.buttons["Delete"]
        let tappedDeleteButton = deleteButton
        
        let deleteAlert = app.alerts["League Deleted"]
        let deleteAlertButton = deleteAlert.buttons["Delete"]
        let tappedDeleteAllert = deleteAlertButton
        
        addFavoriteLeague.tap()
        tappedOkay.tap()
        tappedFavoriteTab.tap()
        swipteFavoriteCell.swipeLeft()
        tappedDeleteButton.tap()
        tappedDeleteAllert.tap()
    }
    
    func testSearchLeague() {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.navigationBars["League Lens"].searchFields["Search League"]
        let searchBar = searchField
        searchBar.tap()
        searchField.typeText("Süper Lig")
        
        let superLigCell = app.collectionViews["Search results"].staticTexts["Süper Lig"]
        XCTAssertTrue(superLigCell.waitForExistence(timeout: 5), "Süper Lig cell not found")
        
        superLigCell.tap()
    }
}
