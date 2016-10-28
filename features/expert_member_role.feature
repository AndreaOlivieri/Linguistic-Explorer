Feature: Expert member role management

  Background:
    Given the group "First Group"
    And the group has a maximum depth of 0
    And the following "First Group" lings:
      | name        | depth |
      | Afrikaans   | 0     |
      | German      | 0     |
      | Spanish     | 0     |
      | French      | 0     |

    And the following "First Group" properties:
      | property name     | ling name   | prop val    | category | depth | surety    |
      | Adjective Noun    | Afrikaans   | yes         | Grammar  | 0     | certain   |
      | Subject Object    | Afrikaans   | no          | Grammar  | 0     | certain   |
      | Adjective Noun    | German      | no          | Grammar  | 0     | certain   |
      | Adjective Noun    | French      | N/A         | Grammar  | 0     | certain   |
      | Adjective Noun    | Spanish     | yes         | Grammar  | 0     | certain   |
      | Subject Object    | Spanish     | no          | Grammar  | 0     | certain   |
      | Noun Adjective    | Spanish     | no          | Grammar  | 0     | revisit   |
      | Object Subject    | Spanish     |             | Grammar  | 0     | certain   |

    And the following "First Group" definitions for properties
      | property name     | definition                         |
      | Adjective Noun    | Adjective Noun definition text     |
      | Noun Adjective    | Noun Adjective definition text     |
      | Subject Object    | Subject Object definition text     |
      | Object Subject    | Object Subject definition text     |

    And the following "First Group" examples for properties
      | ling name | property name   | example name  | description      |
      | Afrikaans | Adjective Noun  | ex1           | I speak Afrikaans|
      | German    | Adjective Noun  | ex2           | I speak German   |

    And the group "Second Group"
    And the group has a maximum depth of 0
    And the following "Second Group" lings:
      | name        | depth |
      | Japanese    | 0     |
      | Chinese     | 0     |
      | Italian     | 0     |
      | Irish       | 0     |

    And the following "Second Group" properties:
      | property name            | ling name   | prop val    | category        | depth | surety    |
      | Second Adjective Noun    | Japanese    | yes         | Second Grammar  | 0     | certain   |
      | Second Subject Object    | Japanese    | no          | Second Grammar  | 0     | certain   |
      | Second Adjective Noun    | Chinese     | no          | Second Grammar  | 0     | certain   |
      | Second Adjective Noun    | Irish       | N/A         | Second Grammar  | 0     | certain   |
      | Second Adjective Noun    | Italian     | yes         | Second Grammar  | 0     | certain   |
      | Second Subject Object    | Italian     | no          | Second Grammar  | 0     | certain   |
      | Second Noun Adjective    | Italian     | no          | Second Grammar  | 0     | revisit   |
      | Second Object Subject    | Italian     |             | Second Grammar  | 0     | certain   |

    And the following "Second Group" definitions for properties
      | property name            | definition                         |
      | Second Adjective Noun    | Adjective Noun definition text     |
      | Second Noun Adjective    | Noun Adjective definition text     |
      | Second Subject Object    | Subject Object definition text     |
      | Second Object Subject    | Object Subject definition text     |

    And the following "Second Group" examples for properties
      | ling name | property name          | example name  | description      |
      | Japanese  | Second Adjective Noun  | ex1           | I speak Japanese |
      | Chinese   | Second Adjective Noun  | ex2           | I speak Chinese  |

    And a user with email "member1@mail.com" is a member of First Group
    And a user with email "expert@mail.com" is an expert member of First Group for lings
      | name        |
      | Spanish     |
    And a user with email "member2@mail.com" is a member of Second Group
    And I am signed in as an expert member of First Group for lings
      | name        |
      | Afrikaans   |

  # Scenarios using a group where the user is the Afrikans expert.
  # There are a total of two expert members in the group: one for Afrikaans and the other for Spanish ling
  # German and French don't have any experts
  Scenario: An Afrikaans expert member can't edit and delete information of First Group
    When I go to the group First Group
    Then I should not see "Edit" icon on the group settings
    And I should not see "Trash" icon on the group settings

  Scenario: An Afrikaans expert member can only edit ling, properties, examples/values of Afrikaans in First Group
    When I go to the group First Group
    Then I should not see "Plus" icon on the ling settings
    When I follow "Lings"
    Then I should not see "Plus" icon on the ling settings
    When I follow "Afrikaans"
    Then I should not see "Plus" icon on the example actions
    And I should see "Edit" icon on the ling property actions
    And I should not see "Trash" icon on the ling property actions
    And I should see "Edit" icon on the edit menu
    When I press "Edit" icon on the edit menu
    Then I should see "Ling" within "#edit-dropdown-menu"
    And I should see "Values" within "#edit-dropdown-menu"

  Scenario: Scenario: An Afrikaans expert member can edit values for a ling that has no expert assigned in the First Group
    When I go to the group First Group
    Then I should not see "Plus" icon on the ling settings
    When I follow "Lings"
    Then I should not see "Plus" icon on the ling settings
    When I follow "German"
    Then I should not see "Plus" icon on the example actions
    And I should see "Edit" icon on the ling property actions
    And I should not see "Trash" icon on the ling property actions
    And I should see "Edit" icon on the edit menu
    When I press "Edit" icon on the edit menu
    Then I should see "Ling" within "#edit-dropdown-menu"
    And I should see "Values" within "#edit-dropdown-menu"

  Scenario: An Afrikaans expert member can't edit ling, properties, examples/values of Spanish in First Group
    When I go to the group First Group
    Then I should not see "Plus" icon on the ling settings
    When I follow "Lings"
    Then I should not see "Plus" icon on the ling settings
    When I follow "Spanish"
    Then I should not see "Plus" icon on the example actions
    And I should not see "Edit" icon on the ling property actions
    And I should not see "Trash" icon on the ling property actions
    And I should not see "Edit" icon on the edit menu

  Scenario: An Afrikaans expert member can't edit all properties of First Group
    When I go to the group First Group
    Then I should not see "Plus" icon on the property settings
    When I follow "Properties"
    Then I should not see "Plus" icon on the property settings
    And I should not see "Edit" icon on the table
    And I should not see "Trash" icon on the table

  Scenario: An Afrikaans expert member can't add, edit, delete a members of First Group
    When I go to the group First Group
    Then I should not see "Plus" icon on the membership settings
    When I follow "Members"
    And I follow "All"
    Then I should not see "Plus" icon on the membership settings
    Then I should not see "Edit" icon on the membership actions
    Then I should not see "Trash" icon on the membership actions

  #Scenarios using a group there you are not member
  Scenario: An Afrikaans expert member can't edit and delete information of Second Group
    When I go to the group Second Group
    Then I should not see "Edit" icon on the group settings
    And I should not see "Trash" icon on the group settings

  Scenario: An Afrikaans expert member can do nothing of Japanese in Second Group
    When I go to the group Second Group
    Then I should not see "Plus" icon on the ling settings
    When I follow "Lings"
    Then I should not see "Plus" icon on the ling settings
    When I follow "Japanese"
    Then I should not see "Plus" icon on the example actions
    And I should not see "Edit" icon on the ling property actions
    And I should not see "Trash" icon on the ling property actions
    And I should not see "Edit" icon on the edit menu

  Scenario: An Afrikaans expert member can't edit all properties of Second Group
    When I go to the group Second Group
    Then I should not see "Plus" icon on the property settings
    When I follow "Properties"
    Then I should not see "Plus" icon on the property settings
    And I should not see "Edit" icon on the table
    And I should not see "Trash" icon on the table

  Scenario: An Afrikaans expert member can't add, edit, delete a members of Second Group
    When I go to the group Second Group
    Then I should not see "Plus" icon on the membership settings
    When I follow "Members"
    And I follow "All"
    Then I should not see "Plus" icon on the membership settings
    Then I should not see "Edit" icon on the membership actions
    Then I should not see "Trash" icon on the membership actions
