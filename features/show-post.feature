Feature: Show post
  In order to read comfortably and share my thoughts
  As a logged-in web user
  I need to be able to view my posts

  Background:
    Given a user "bob"
    And a user "alice"
    And I am logged in as "bob"

  Scenario: Post exists
    Given that "bob" has a post with title "Bob's post"
    And the post has body:
    """
    # Heading 1

    ## Heading 2

    ### Heading 3

    #### Heading 4

    ##### Heading 5

    ###### Heading 6
    """
    And I am viewing the given post
    Then I should see the content correctly formatted as HTML

  Scenario: Post I don't own
    Given that "alice" has a post with title "Alice's post"
    And I am viewing the given post
    Then the response status code should be 403

  Scenario: Colliding slugs
    Given that "bob" has a post with title "Post" and body "Written by Bob"
    And that "alice" has a post with title "Post" and body "Written by Alice"
    When I am on "/bob/post"
    Then I should see "Written by Bob"

    When I am logged in as "alice"
    And I am on "/alice/post"
    Then I should see "Written by Alice"

  Scenario: Post contains script
    Given that "bob" has a post with title "Bob's post"
    And the post has body:
    """
    <script>document.getElementByTagName('body').innerHtml = 'Added with script'</script>
    """
    And I am viewing the given post
    Then I should not see "Added with script"
