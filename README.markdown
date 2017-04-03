# CodeAcademy

This is an personal, old, probably not working application that enables a community to participate in managing and organizing content with an emphasis on collaborative learning.  At the lowest level, it organizes information based on two fundamental structures:

### Nodes
*Nodes* are used to represent a specific topic, subject, or tool.  A *Node* can be linked to other nodes via explicitly defined *Relationships*.  The node holds basic details as well as resources helpful in learning that node.

### Relationships
*Relationships* are used to link nodes to one another when two (or more) nodes share a contextual relationship.  The specific context of the *Relationship* is captured in the Relationship's `sentences`, one for each direction of the relationship, after all, how A relates to B is of often different than how B relates to A.

## Content Delivery
`Nodes` and `Relationships` capture the are then organized and presented to users via one of the following ways:

* Information Pages
* Tutorials

### Information Pages 
Information Pages display the basic data that is captured for a *Node* or *Relationship*.  On each info page there is basic defining information as well as community defined helpful links, tutorials, and in the case of a *Node* Information Page, and a relationships.

### Tutorials 
Tutorials allow users to create guides for learning specific tasks related to a particular *Node* or *Relationship*.  Tutorials are written in Markdown.

### Curriculums 
(advanced feature that is still under construction and not present in the current implementation)
