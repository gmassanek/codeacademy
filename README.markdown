# Ecosystem -- AKA Rubeco

Ecosystem is a dynamic application that enables a community to participate in managing and organizing content around a specific topic.  At the lowest level, Ecosystem organizes information based on two fundamental structures:

* Nodes
* Relationships

### Nodes
*Nodes* in Ecosystem are used to represent a specific topic, subject, or tool.  Each *Node* contains a *Title, a Homepage Link, a Twitter Search Key, a Stack Search Key, a Description, and Helpful Links*.  A *Node* can also linked to other related nodes via *Relationships*.

### Relationships
*Relationships* are used to link nodes to one another when two or more nodes share a contextual relationship.  The specific context of the *Relationship* is captured in the *Relationship's Sentences*.  *Relationships* are bi-directional, so they only have to be defined once for every pair of *Nodes* they connect.

## Content Delivery
While *Nodes* and *Relationships* capture the fundamental contextual data in an Ecosystem, this content is further organized and presented to end users via one of the following information delivery subsystems:

* Information Pages
* Tutorials
* Cirriculums

###Information Pages 
Information Pages display the basic data that is captured for a *Node* or *Relationship*.  On each information page, the user has the capability to define helpful links, add tutorials, or in the case of a *Node* Information Page, define a relationship.

###Tutorials 
Tutorials allow end users to create guided tutorials for performing specific tasks related to a specific *Node* or *Relationship*.  Tutorials are written in Markdown.

###Cirriculums 
(advanced feature that is still under construction and not present in the current implementation)


## Rubeco
[Rubeco] (http://www.rubeco.info) is a specific implemetation of Ecosystem that is oriented for the Ruby on Rails community of users and students.
