# Contribution guide

## Contribution philosophy

The lessons on the Arcadia Computational Training website are written to empower learners to pick up skills both during formal teaching encounters and as asynchronous materials they can be used by anyone, anytime to pick up or refresh those skills. 

## Best practices for computational lesson development

1. **Clear learning objectives**: Begin each lesson with explicit learning objectives that outline what the learners should expect to achieve by the end of the session. This helps learners and instructors gauge progress and focus on the key takeaways.
2. **Domain-relevant examples**: Use examples that relate to the domain you're teaching to help learners understand the practical application of the concepts being taught. This aids in retention and engagement.
3. **Incremental skill development**: Organize the lessons in a logical sequence that builds upon previous skills and concepts. This allows learners to progressively gain expertise as they move through the material.
4. **Interactive hands-on exercises**: Include hands-on exercises throughout the lessons to give learners the opportunity to practice their skills in real-time. This helps to reinforce learning and allows instructors to provide immediate feedback.
5. **Accessible language and clear explanations**: Use clear, concise language and avoid jargon to ensure that learners can easily understand the material. Provide explanations and examples for all key terms and concepts.
6. **Visual aids and multimedia resources**: Incorporate visual aids, such as diagrams and flowcharts, to help learners visualize complex concepts. Provide links to supplementary resources, such as videos and articles, to support diverse learning styles.
7. **Self-assessment and challenges**: Include periodic self-assessment questions and challenges to help learners evaluate their progress and identify areas for improvement. This also enables instructors to adapt their teaching approach based on learner performance.
8. **Comprehensive documentation**: Provide thorough documentation for all aspects of the lesson, including step-by-step guides, code examples, and troubleshooting tips.
9. **Open access and reusable materials**: Make the materials freely available online under an open license, enabling learners to access them at their convenience and allowing other educators to reuse and adapt the content for their own purposes.

## Crash course in teaching computation

1. **Establish a welcoming environment**: Create a positive atmosphere by introducing yourself, setting expectations, and encouraging learners to share their backgrounds and goals. This helps to build rapport and foster a supportive learning community.
2. **Use active learning techniques**: Engage learners by incorporating activities, such as group discussions, pair programming, or think-pair-share exercises, which facilitate participation and promote deeper understanding.
3. **Encourage questions**: Ask open-ended questions like "What questions do you have?" instead of "Are there any questions?" This creates a more inclusive environment and prompts learners to reflect on their understanding.
4. **Be mindful of language**: Avoid using diminishing language, such as "just" or "simply," which can make learners feel inadequate if they are struggling with a concept. Use inclusive and accessible language to ensure everyone feels valued and included.
5. **Use live programming and narration**: Type out code or commands as you go, narrating any shortcut keystrokes you use to help learners follow along. This interactive approach allows you to pace yourself, making it easier for learners to keep up with the lesson.
6. **Break down complex concepts**: Present complex ideas in smaller, manageable chunks, and provide clear explanations and examples for each. This helps learners to digest the material more easily and promotes better comprehension.
7. **Be adaptable**: Be prepared to adjust your teaching style or lesson plan to accommodate learners' needs and backgrounds. If learners are struggling with a particular concept, take the time to provide additional support or revisit the topic.
8. **Embrace errors as learning opportunities**: Recognize that errors made while programming can be good examples of how to debug issues in real life and can often be instructional. Use these moments to demonstrate problem-solving techniques and encourage learners to develop their own debugging skills.
9. **Reflect and iterate**: After delivering the lesson, reflect on what went well and what could be improved. Seek feedback from learners and fellow instructors, and use this information to refine your teaching methods and lesson materials for future sessions.

Below we include more resources on how to teach programming.

* [Tips for instructors](https://docs.carpentries.org/topic_folders/hosts_instructors/instructor_tips.html)
* ["Helpers" checklist](https://docs.carpentries.org/topic_folders/hosts_instructors/hosts_instructors_checklist.html#helper-checklist) with many generalizable tips. "Helpers" are expert individuals that help during a workshop or lesson when learners have a specific problem that doesn't need to be addressed by the entire group.
* [Carpentries instructor training curriculum](https://carpentries.github.io/instructor-training/)

## How to contribute via GitHub

This website is built using [MkDocs](https://www.mkdocs.org/) from the GitHub respository [Arcadia-Science/arcadia-computational-training](https://github.com/Arcadia-Science/arcadia-computational-training).

Contributions should be made on a branch or fork, integrated via pull request, and reviewed by at least one Arcadian.

### Contributing to lesson materials in arcadia-users-group

Each AUG lesson should be placed in its own folder. 
Folder names should follow the naming convention `DATE-short-description-of-tutorial.md` where dates are formatted as yearmonthdata with noseparaters, short descriptions are concise tags for the content of the lesson and where each word is separated by a hyphen.
Lesson materials should be in markdown format.
Any companion materials to the lesson should be stored in the folder when possible.
If the additional files are too large, download provenance should be recorded clearly in the lesson.
Images rendered inline in the lesson text should also be stored in this folder.
The relative path (e.g. just the file name) can be used to render the image in the lesson.

Lessons are linked from the `overview.md` document, making them discoverable and rendered on arcadia-science.github.io/arcadia-computational-training.

### Linking to external training materials

Sometimes lesson material belongs better in a different repository or we'll cover open lessons developed by other organizations such as [The Carpentries](https://carpentries.org/).
When this is the case, link to the lesson material in the `overview.md` document.
The lesson will not be rendered on the computational training website, but it will be linked and discoverable from there.

## Attribution

This document was inspired by [The Carpentries documentation](https://docs.carpentries.org/) and our experience participating in The Carpentries community.
