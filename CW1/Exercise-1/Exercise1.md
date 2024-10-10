# Exercise 1

**Set Exercise 1:  Normalisation: 20 marks**

Carry out Normalisation to Third Normal Form (3NF) on the trail detailspage of a trail such as the Plymouth  Waterfront  or  PlymbridgeCircular,  found  on  the  website.   Do  not  include  conditions, reviews,  photos,  activities,  completed,  directions,  printable  map,  share,  more.

**State any assumptions you have made**. Normalise  the  attributes to 3NF  showing  all  intermediate  stages,  namely:  Un-normalised  Form (UNF), First Normal Form (1NF) and Second Normal Form (2NF).

Be careful to identify the attributes used for keys.  Additional marks will NOT be gained for optimising the results of 3NF, though you may still find it worthwhile to optimise your results.

You must name the 3NF relations. Draw the partial ERD using the taught notation of soft boxes and crows feet. This should be included at the end of the Set Exercise 1 report section, clearly labelled. This partial ERDwill be assessed as part of Set Exercise 2

---

**"I'm sure I can just draw this on paper as .drawio so confusing"**

- [X] Get **Plymbridge Circular** data(Trail Name, Length, Elevation, Route Type, Difficulty, Estimated Time, Location)
- [ ] Organise data from un-normalised form to 3NF; draw an Entity Relationship Diagram for each instance of UNF->1NF->2NF->3NF
- [ ] Combine all ERDs into one
- [ ] Create a database schema from the ERD

---

**1NF: no repeating groups.**
Trail: Name, Length, Elevation, Route Type, Difficulty, Estimated Time, Location(FK)
Location: LocationID, Country, City, County

---

**2NF: no partial dependencies; a partial dependency is when a non-key attribute is dependent on only part of the key.**
Trail: TrailID, Name, Length, Elevation, Route Type, Difficulty, Estimated Time, LocationID(FK)
Location: LocationID, Country, City, County

---

**3NF: every attribute is dependent on the key, the whole key, and nothing but the key.**
