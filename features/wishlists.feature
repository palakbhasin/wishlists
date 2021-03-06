Feature: The wishlists service back-end
    As a Wishlists Service Owner
    I need a RESTful catalog service
    So that I can keep track of all my wishlists and the items in them


Background:
    Given the server is started
    Given the following wishlists
        | id | name       | user_id |
        |  1 | wl1        | user1   |
        |  2 | wl2        | user2   |
        |  3 | wl3        | user3   |

    Given the following items
        | item_id | wishlist_id | description |
        | item1   | 1           | test item 1 |
        | item2   | 1           | test item 2 |
        | item3   | 2           | test item 3 |
    

Scenario: The wishlists service is running
    When I visit the "home page"
    Then I should see "Wishlists REST API Service"
    Then I should not see "404 Not Found"


Scenario: List all wishlists
	When I visit "wishlists"
	Then I should see a wishlist with id "1"
	And I should see a wishlist with id "2"
	And I should see a wishlist with id "3"


Scenario: Get a wishlist with given id
    When I retrieve "wishlists" with id "1"
    Then I should see "user1" in this wishlist
    And I should not see "404 Not Found"

    
Scenario: Deleting a wishlist
    When I visit "wishlists"
    Then I should see a wishlist with id "1" and name "wl1"
    And I should see a wishlist with id "2" and name "wl2"
    And I should see a wishlist with id "3" and name "wl3"
    When I delete "wishlists" with id "2"
    And I visit "wishlists"
    Then I should see a wishlist with id "1" and name "wl1"
    And I should not see a wishlist with id "2" and name "wl2"
    And I should see a wishlist with id "3" and name "wl3"

Scenario: Deleting a wishlist item
    When I delete an item with id "item2" from wishlist with id "1"
    And I retrieve "wishlists" with id "1"
    Then I should see a wishlist with id "1"
    And I should not see an item with id "item2" from wishlist with id "1"

Scenario: Update a wishlist name
    When I retrieve "wishlists" with id "1"
    And I change "name" to "test change"
    And I update "wishlists" with id "1"
    Then I should see "test change"

Scenario: Update a item description
    When I retrieve an item with id "item1" from wishlist id "1"
    And I change "description" to "test change"
    And I update an item with id "item1" in a wishlist with id "1"
    Then I should see "test change"

Scenario: Adding a new wishlist
    When I create new wishlist at "wishlists" with user_id "user2" and name "wl4"
    And I visit "wishlists"
    Then I should see a wishlist with id "4" and name "wl4"

Scenario: Adding a new item and read this item
    When I create an item with id "item4" and description "add item" to wishlist id "1"
    And I retrieve an item with id "item4" from wishlist id "1"
    Then I should see an item with id "item4" and description "add item"
    And I should not see "404 Not Found"

Scenario: Searching 
    When I search for query "item1" in all wishlists with user id "user1"
    Then I should see "test item 1"
    And I should not see "test item 2"
    And I should not see "user2"