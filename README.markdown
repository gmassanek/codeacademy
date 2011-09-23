# Ecosystem -- AKA Rubeco

Ecosystem is an application that enables a community to participate in managing and organizing content around a specific topic.  At the lowest level, Ecosystem organizes information based on two fundamental structures:

### Nodes
*Nodes* in Ecosystem are used to represent a specific topic, subject, or tool.  A *Node* can be linked to other nodes via explicitly defined *Relationships*.  The node holds basic details as well as resources helpful in learning that node.

### Relationships
*Relationships* are used to link nodes to one another when two (or more) nodes share a contextual relationship.  The specific context of the *Relationship* is captured in the Relationship's `sentences`, one for each direction of the relationship, after all, how A relates to B is of often different than how B relates to A.

## Content Delivery
While `Node`* and `Relationships` capture the contextual data in an Ecosystem, this content is then organized and presented to users via one of the following information delivery subsystems:

* Information Pages
* Tutorials
* Cirriculums

###Information Pages 
Information Pages display the basic data that is captured for a *Node* or *Relationship*.  On each info page there is basic defining information as well as community defined helpful links, tutorials, and in the case of a *Node* Information Page, and a relationships.

###Tutorials 
Tutorials allow users to create guides for learning specific tasks related to a particular *Node* or *Relationship*.  Tutorials are written in Markdown.

###Cirriculums 
(advanced feature that is still under construction and not present in the current implementation)


## Rubeco
[Rubeco] (http://www.rubeco.info) is a specific implemetation of Ecosystem that is oriented for the Ruby on Rails community of users and students.
