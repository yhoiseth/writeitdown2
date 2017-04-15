Feature: View post
  In order to read comfortably and share my thoughts
  As a logged-in web user
  I need to be able to view my posts

  Scenario: Post exists
    Given a post with markdown-formatted content
    And I am viewing the given post
    Then I should see the content correctly formatted as HTML