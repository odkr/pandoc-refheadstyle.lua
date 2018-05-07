---
reference-section-title: Cited Works
references:
    - id: doe2006
      author:
          family: Doe
          given: [John, F.]
      title: Article
      page: 33-34
      issued:
          year: 2006
      type: article-journal
      volume: 6
      container-title: Journal of Generic Studies
...

The above reference is the example from the `pandoc-citeproc` man page.

@doe2006 says: "Test your code!"

# Appendix

::: appendix :::

The following header should be replaced.
And its attributes should be preserved.


### Cited Works {#bibliography .preserve-me preserve-me='test'}

:::::: {#refs} ::::::
::::::

:::

This is just some text.
