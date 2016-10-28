Feature: Member role management

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
    And a user with email "member2@mail.com" is a member of Second Group
    And I am signed in as a member of First Group

  #Scenarios using a group with you are a member
  Scenario: A member can't edit and delete information of First Group
    When I go to the group First Group
    Then I should not see "Edit" icon on the group settings
    And I should not see "Trash" icon on the group settings

  Scenario: A member can't add, edit, delete lings of ling, properties, examples/values of Afrikaans in First Group
    When I go to the group First Group
    Then I should not see "Plus" icon on the ling settings
    When I follow "Lings"
    Then I should not see "Plus" icon on the ling settings
    When I follow "Afrikaans"
    Then I should not see "Plus" icon on the example actions
    And I should not see "Edit" icon on the ling property actions
    And I should not see "Trash" icon on the ling property actions
    And I should not see "Edit" icon on the edit menu

  Scenario: A member can't add, delete, edit properties of First Group
    When I go to the group First Group
    Then I should not see "Plus" icon on the property settings
    When I follow "Properties"
    Then I should not see "Plus" icon on the property settings
    And I should not see "Edit" icon on the table
    And I should not see "Trash" icon on the table

  Scenario: A member can't add, edit, delete a members of First Group
    When I go to the group First Group
    Then I should not see "Plus" icon on the membership settings
    When I follow "Members"
    And I follow "All"
    Then I should not see "Plus" icon on the membership settings
    Then I should not see "Edit" icon on the membership actions
    Then I should not see "Trash" icon on the membership actions

  #Scenarios using a group with you are not a member
  Scenario: A member can't edit and delete information of Second Group
    When I go to the group Second Group
    Then I should not see "Edit" icon on the group settings
    And I should not see "Trash" icon on the group settings

  Scenario: A member can't add, edit, delete lings of ling, properties, examples/values of Japanese in Second Group
    When I go to the group Second Group
    Then I should not see "Plus" icon on the ling settings
    When I follow "Lings"
    Then I should not see "Plus" icon on the ling settings
    When I follow "Japanese"
    Then I should not see "Plus" icon on the example actions
    And I should not see "Edit" icon on the ling property actions
    And I should not see "Trash" icon on the ling property actions
    And I should not see "Edit" icon on the edit menu

  Scenario: A member can't add, delete, edit properties of Second Group
    When I go to the group Second Group
    Then I should not see "Plus" icon on the property settings
    When I follow "Properties"
    Then I should not see "Plus" icon on the property settings
    And I should not see "Edit" icon on the table
    And I should not see "Trash" icon on the table

  Scenario: A member can't add, edit, delete a members of Second Group
    When I go to the group Second Group
    Then I should not see "Plus" icon on the membership settings
    When I follow "Members"
    And I follow "All"
    Then I should not see "Plus" icon on the membership settings
    Then I should not see "Edit" icon on the membership actions
    Then I should not see "Trash" icon on the membership actions
