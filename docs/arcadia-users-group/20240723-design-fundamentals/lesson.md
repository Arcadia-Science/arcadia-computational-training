# Fundamentals of Design

This AUG lesson is a brief introduction to the principles of design, with a focus on how they can be applied to scientific visualizations.  We will cover the following topics:
- Why we should care about good design
- **Layout:** how we arrange and compose figures to guide the viewer
  - Gestalt principles
  - Visual hierarchy
  - Composition
  - Grids, grouping, and alignment
- Layout exercise
- **Design details:** how to choose visual elements to communicate better
  - Color
  - Typography and hierachy
  - Symbols
- Design critique


## Introduction
### Where we're starting from

> “Beauty is a very important entry point for readers to get interested about the visualization and be willing to explore more.  Beauty cannot replace functionality, but beauty and functionality together achieve more.” – *Better Data Visualization*

Beautiful scientific visualizations are able to grab your attention. But design is more than just aesthetics – it is a critical component of effective communication.  Efficient design is functional; it distills complex information into simple and clear contrasts, patterns, or sequences.

In this lesson, we’re going to discuss design principles as they emerged as a formalized system, most famously established by German/Swiss design movements in the early 20th century.  These are time-tested tools which draw from graphical history/culture and perception science.

> “Traditionally, graphic design theory has privileged intuition and creativity over empirical research…. [But] it can be argued that the art-based principles of graphic design - including (but not limited to ) contrast, hierarchy, repetition, alignment, and color - are in fact theories proven through a long history of successful experimentation in practice.  Indeed, graphic designers - through professional practice - have tested and restested to the point where it makes sense to refer to these theories as laws or principles.” – *Audrey G. Bennett, Design Studies: Theory and Research in Graphic Design*

<details>
    <summary> A note about decolonizing design </summary>
    There’s been a lot of discussion of and work towards decolonizing design, and I can speak to some of the projects I’m familiar with.  But I also feel strongly that the visual systems codified by Bauhaus and Swiss design are basically summaries of very ancient systems of visual cognition that don’t belong to Europe, they just had the power/structure to formalize and disseminate it. (Ex: the golden ratio concept (often associated with Swiss grid design) is at least as old as ancient Greece and there’s evidence of stronger ties to ancient African civilizations.) Not to mention the impact of millenia of trade and travel and centuries of colonization that had incalculable influence on European thought.
</details>

## Destination & Audience
### Why do we care about good design?

The point of communication is to get people to understand something.  The figures we’re creating aren’t just about marking that we did something or keeping a record for ourselves, they’re about explaining to other people what happened in a way that will be understandable and compelling.

> “People will read your [pub]. People will listen to you discuss your work.  It might have taken you months or even years to compile and analyze the data.  And yet many of us spend far too little time thinking about how we can best present our findings.  Instead we use whatever default approach is quickest and easiest.” – *Jon Schwabish, Better Data Visualizations*

While you’re familiar with your process and findings, your viewer isn’t.  Thinking carefully about how data/subject matter is presented to people is just as important as the data itself.

When beginning a design, it’s important to consider the audience and the context in which they will be viewing the figure. We can break down this process into a few steps:

#### 1. Defining the key takeaway(s)
Begin by defining the communication goal of your visualization.  
- What key message(s) do you hope to convey?  
- What should someone remember after looking at your figure?
- Who is your audience?
- What visual vocabulary will my audience understand?
- What necessary context needs to be provided?
- What kind of impact do I want?

Clarifying these points early will guide the design process and ensure that the final product is effective in communicating your message.

#### 2. Choosing types of engagement
Sometimes we just want to show the data or subject matter as succinctly, cleanly, and accurately as possible. But we’ve all seen a zillion barcharts, and sometimes, our goal is to get people to stop and actually look at our figure.  Standard charts (like bar and line charts) are perceptually more accurate, but they may not draw people in to investigate it, read it closely, and explore.

> “Different shapes and uncommon forms that move beyond the borders of our typical data visualization experience can draw readers in.  Reading a graph is not like the spontaneous comprehension of seeing a photograph.  Instead, reading a graph has more of the complex cognitive processes of reading a paragraph.” – *Jon Schwabish, Better Data Visualizations*

##### Explanatory vs. exploratory visuals
Consider whether your visualization is meant to provide a specific narrative, or if it is meant to allow the viewer to explore the data themselves.
- *Explanatory* visualizations highlight the key findings, helping viewers understand cause and effect, trends, and conclusions. This can be achieved through data selection, annotations, direct labels, highlighting, and encoding emphasis.  
- *Exploratory* visualizations allow viewers to interact with a dataset to draw conclusions themselves. This can be achieved through interactivity, encoding categories with equal visual weight.
- What kind of experience are you looking to create?


#### 3. What kind of media will you be using?
Before starting on a design, consider through what medium it will be seen. Different media have different constraints and affordances that will affect how you design your figure.  For example:
- **Pub:** This medium can handle more detail/dense information, text, and annotations.
- **Twitter / X / Bluesky / etc.**: On social media platforms, effective posts are image heavy with sparse text. You may want to consider a using Graphical Abstract (GA) or animation to draw a reader's attention.
- **Slide:** During a talk, information can be broken up/introduced across multiple slides. You can also use animations to guide the viewer’s attention.
- **Poster:** With a large, printed medium such as a poster, the grouping of information and visual flow becomes very crucial. Legibility at a distance is also important.


#### 4. What format will you use?
- **Data figures:** Figures that show raw data, relationships, or trends. These are the most common type of scientific figure.
- **Methods figures:** Figures that illustrate a process or technique.
- **Graphical Abstracts and Illustrations:** These are used to summarize a paper or concept in a single image. They can be useful for showing:
  - Dense explanatory info
  - A more complex/complete story
  - A step-by-step guide


## Layout
Once we have our key takeaways, we know who we're designing for, where it's going, and what it is, we can start the actual design process.  At a high level, how we arrange and compose figures impacts their comprehensibility. We'll discuss principles of layout that you can use to guide the viewer through your figure.  Let's discuss the tools we have for arranging and composing figures.

### Gestalt Principles
The term “gestalt” refers to the idea that the whole is greater than the sum of its parts.  The gestalt principles of design are a set of rules that describe how we perceive visual elements as a whole. 

For example, consider the image below. What do you see?
![Emergence example](emergence_example.png)

You might say that the image is a of a dalmatian. But if you look closer, you’ll see that the image is actually made up of a series of black and white shapes.  This is an example of the gestalt principle of *emergence*, which describes how we perceive a whole image before we see its individual parts.

![Gestalt principles](gestalt_principles.png)

<details>
    <summary> History of gestalt principles </summary>
    <li>Gestalt principles emerged out of the field of psychology in the 1930s, and were part of a broader cultural project of "formalizing the representation of thought" in logic, linguistics, psychology, and art/design.  "The term “gestalt” refers to groupings and our tendency to see patterns wherever possible. Human perception isn’t literal. We will close gaps, see motion, make partial shapes into whole ones in ways that are surprisingly predictable." (Drucker)</li> 
    <li>Instead of thinking about vision as a direct reflection of the world around us, we can think of vision generating pictures and patterns from noise, just as we did with the dog.  These seem like simple ideas, but they are powerful tools to clarify relationships between elements.</li> 
</details>

These principles show up in a variety of different forms of perceptual grouping, including:
- **Proximity:** objects that are close together go together
- **Similarity:** objects that are similar in size, shape, color go together 
- **Symmetry**
- **Parallelism**
- **Common region:** objects that are bounded go together 
- **Connectedness:** connected objects go together
- **Continuity:** smooth and continuous lines are easier to track
- **Closure:** incomplete shapes get closed

These principles might feel a bit abstract, but they inform a lot of the more concrete principles we'll discuss. The first of those is Composition.

### Composition
What we’re doing in layout is creating a composition; we’re showing our audience where to look and helping them navigate the sequence of information.

Questions to consider when composing a figure:
- Where will the reader’s gaze enter the space?
- What piece of information do they need first, second, and third?
- How can I direct their attention through that series in an intuitive manner?
- How can the position of the elements reinforce the story I’m trying to tell?
*Jen Christiansen, Building Science Graphics*

Examples of different types of composition:
I hope that in these examples you’re starting to see certain elements as grouped together, seeing patterns between elements that inform how we perceive the whole, as we just talked about in Gestalt principles.

Composition allows us to see if information is sequential, cyclical, if the designer wants us to compare and contrast elements. It is the structure that draws our gaze through the graphic in a particular way. We build that structure by ordering the elements in our figure by their importance (in relation to the key message). We create that order through something called visual hierarchy.

### Visual hierarchy
Visual hierarchy refers to the arrangement of visual elements in a way that implies importance.  Looking at the components you want to include in your figure, you can define how someone will walk through that information.

To do that, we need to assign a hierarchy of importance to the information we’re including.  For data figures, this is probably just the actual data.  For something more complex (including a combination of data figures), we want to define their order. Some basic ways we can do that are through manipulating position, size, and contrast.

1. **Position**
   - Western readers will start at the top left and move left-to-right, top-to-bottom. Use this ordering to your advantage.
   - For example, if you put your title or set-up imagery in the top-left, it acts as a locator map/starting point that lets us get our bearings.  It will be seen as applying to the rest of the composition.  All subsequent content fits below this umbrella that visually establishes its prominence.
2. **Size**
   - The eye is drawn to larger elements before smaller elements.  Size can be used to indicate importance.
   - The largest element can also provide an anchor/starting point.  We intuitively sense that it applies to the rest of the information in the figure.  Supporting information can be smaller.
   - Also applies to line thickness, arrowheads
3. **Contrast**
   - Elements that are different from the rest of the composition will stand out.
   - Contrast can be applied to both color/saturation and breaking from a design pattern (like scale, weight, position).
   - Use dark/saturated lines and fills to show emphasis, lighter elements to provide context.
   - See Highlights/contrasting colors in Style Guide.  Sometimes creating contrast is as much about removing ink as adding ink.
4. Combine these principles for the greatest impact.

### Grids, grouping, and alignment
If we’ve defined to ourselves what elements are important, and how to show that they’re important, how do we arrange them all together in a way that is simple, organized, and allows for some of those perceptual groupings to emerge? A basic way to do that is just to use a grid.

Grid design should feel very familiar from newspapers, magazines, websites. Information clustered in internal boxes with gutters (empty space) running between them. Subsections (like these text columns and photos) are defined by the space around them, and larger elements are multiples of the smaller elements.

So, remember Gestalt principles. This is what grid systems are doing. Keeping things orderly, grouping the information into relevant chunks, and allowing for effective ordering, grouping, and making comparisons. I just want to reiterate that common regions can be achieved through negative space, which avoids extra visual noise of lines and frames. And that this background common region is what we’re doing when we use panel backgrounds.

Grids also allow us to align things in an organized manner. Align elements to grid, and align elements consistently (left/center/right). This is particularly important for captions, labels, and callouts, as it connects them logically to their relevant information and allows the overall figure to feel organized and modular.

Repetition is inherent in grid systems, which are useful for creating small multiples: Keep orientation exactly the same and add differentiation (color/contrast/weight) to the variable you want people to pay attention to (your key takeaway).

## Layout Exercise
[TBD]

## Design details
Once you've established the overall layout of your figure, you can start to think about the details that will make your figure visually appealing and easy to understand.

### Color
> “Colors - as we perceive them - aren’t absolute.  They vary from person to person, are subject to perceptual issues, aesthetic issues, and semantics….  But color vision [also] allows humans to more easily distinguish things from one another, remember those objects, and communicate with others about them.  It follows that color can be used in information design to selectively isolate and highlight information.” (Christiansen, p. 98)

Color is a powerful tool for conveying information. However, it can also be a source of confusion if not used correctly. Understanding the basics of color theory can help you use color effectively in your figures.

**Color terminology:**
- **Hue:** the color itself (red, blue, green)
- **Chroma / Saturation:** the intensity of the color (from gray to fully saturated)
- **Value / Lightness:** the lightness or darkness of a color

How we combine these things can greatly impact what we read as being important, and how we group information. So we might keep lightness consistent across multiple hue, we might read that as categories of equal importance. Or if we vary chroma within a hue, we might read that as varying levels of importance within a category.

**What to consider when choosing colors:**
- **Contrast:** Use colors that are easily distinguishable from one another.  This can be achieved by using colors that are far apart on the color wheel, or by using colors with different values.
- **Perceived lightness:** Some colors, such as blues and purples, have more visual weight than others, such as yellows. Lightness is not uniform among hues, so be aware of this when choosing colors.
- **Color vision deficiency:** Color vision deficiency (color blindness) affects a significant portion of the population. Be aware of this when choosing colors, and consider using color palettes that are accessible to colorblind viewers. These issues have been considered in creating our Style Guide, color palette, and gradients.  We’ve also included recommended color combinations that will help you show categories, sequences, and outliers.  So I’d recommend sticking with those as you design.
- **Double encoding:** Use color to encode information, but also use another visual variable (like shape or size) to encode the same information. This way, if someone can’t see the color, they can still understand the information.  I'd encourage further exploration of Jacques Bertin's Visual Variables.  Originally developed for cartographers, they show that, in terms of perceptual accuracy, things like position and length are much easier for us to compare than color.  So using these attributes in combination can help us communicate more effectively.

**How to use color effectively:**
Instead of using color to strictly describe appearance (i.e. the apple is red), you can use it organize elements, themes, and relationships when designing your graphic:
- In the same way you would use a highlighter with text, use color to organize content while planning your graphic. 
Color code thematically-related content or key takeaways (can also do this to blocks of text if you’re a verbal thinker, to connect visual planning to writing, or to tag reference material, and to make sketches). This coloring doesn’t necessarily need to carry over to final design.
- In a design, you can use color to track elements, to divide/chunk information, or highlight an important element.
- Here, you can see that the illustrator uses blue, orange, and yellow to consistently indicate the same elements even as she moves through variations of scale, style, and information density.  The rest of the graphic uses minimal contrast so we know what to pay attention to.
- Remember contrast being a key tool in establishing visual hierarchy.  Use color to create contrast and emphasize something important.  This is an excellent way to highlight data, and there are highlight palettes in the Style Guide.
- Show the relationship of part to whole
- Highlight an important element, an outlier, an unexpected result

### Typography and hierarchy
Typography is "the art and technique of arranging type to make written language legible, readable and appealing when displayed".  It is a critical component of design, as it can be used to convey information and emotion.  When choosing typography for a figure, you should consider the following variables:
- size
- placement
- alignment
- spacing
- color

We can standardize the use of typography in our figures by defining a hierarchy of text elements.  This hierarchy can be used to guide the viewer through the figure, making it easier to understand the information being presented – for example, by using identity levels such as:
- Title
- Introduction
- Subhead
- Caption/annotation
- Label
- Secondary label

Each level should have its own distinct text style. We have standardized text styles detailed in our Style Guide. The hierarchy established there is defined using the same principles as above (position, size, contrast). 

Some other tips for using typography effectively:
- You can create contrast (or signal importance) through style (sans/serif), indentation, line spacing, and alignment.
- Keep alignment consistent within levels (don’t center align some and left align others).
- Legibility (size, color, contrast) and readability (leading, justification, sans/serif, typeface, forced line breaks, text block width).
- Consider your format: pub figures, posters, social media posts, and slides can handle different amount and size of text.
- Use annotations:
    > “In an eye-tracking and recall experiment, they found that titles and other text elements in visualization attracted - and held attention - longer than any other element. And the content of a title has a significant impact on what a person will take away from, and later recall, about a visualization.” – Borkin et al.


### Symbols
Symbols and conventions specific to each scientific discipline are like visual jargon. They allow us to communicate efficiently with others who know these conventions. However, we should use symbols judiciously by asking the following questions:
- Who is my audience?
- Am I speaking only to people who are fluent in this language, or do I want this to be accessible to others outside of this discipline?  Consider another solution or label things carefully.


**Arrows**<br>
Arrows are used to signify a diverse set of meanings, and it’s important to make sure that these different meanings are clearly communicated with different iconography.  Some common meanings of arrows include:
- Change in state or position (things go from A to B) 
- Causality (C leads to, activates, or triggers D)
- Labeling
- Zooming
- Discipline-specific conventions (genetics promoter).  Does your audience know the jargon?  

Make sure these different meanings use different types of arrows, or don’t use arrows at all (leader lines, callouts).

## Design critique
[TBD]