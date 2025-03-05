
# Setup: RStudio Shortcuts

*Purpose*: Your ability to get stuff done is highly dependent on your fluency
with your tools. One aspect of fluency is knowing and *using* keyboard
shortcuts. In this exercise, we'll go over some of the most important ones.

*Reading*: [Keyboard shortcuts](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts); [Code Chunk Options](https://rmarkdown.rstudio.com/lesson-3.html)

*Note*: Use this reading to look up answers to the questions below. Rather than *memorizing* this information, I recommend you download a [cheatsheet](https://github.com/rstudio/cheatsheets/blob/main/rstudio-ide.pdf), and either print it out or save it in a convenient place on your computer. Get used to referencing your cheatsheets while doing data science---practice makes perfect!
- If this link is broken, try searching "Rstudio IDE cheatsheet" on the web.



### __q1__ What do the following keyboard shortcuts do?

* Within the script editor or a chunk

    * `Alt` + `-`

Insert assignment operator `<-`

    * `Shift` + `Cmd/Ctrl` + `M`

Insert pipe operator `%>%`

    * `Cmd/Ctrl` + `Enter`

If no text is highlighted, run complete expression that cursor is
on, and advance to the next line. If text is highlighted, run
selected text.

    * `F1` (Note: on a Mac you need to press `fn` + `F1`)

If cursor is on a function name, pull up the help page for the function.

	* `Cmd/Ctrl` + `Shift` + `C`

Comment/uncomment the code at the cursor, or highlighted code.


* Within R Markdown

    * `Cmd/Ctrl` + `Alt` + `I`

Insert chunk.

* Within a chunk

    * `Shift` + `Cmd/Ctrl` + `Enter`

Run current chunk.

    * `Ctrl` + `I` (`Cmd` + `I`)

Re-indent selected lines.

Try this below!


``` r
## This is what it should look like
c(
  "foo",
  "bar",
  "goo",
  "gah"
)
```

```
## [1] "foo" "bar" "goo" "gah"
```


### __q2__ For a chunk, what header option do you use to

* Run the code, don't display it, but show its results?

`echo=FALSE`

* Run the code, but don't display it or its results?

`include=FALSE`

### __q3__ How do stop the code in a chunk from running once it has started?

Click the red square in the top right corner of the chunk.

### __q4__ How do you show the "Document Outline" in RStudio?

*Hint*: Try googling "rstudio document outline"

Use the keyboard shortcut `Ctrl + Shift + O` (Windows), `Super + Shift + O` (Mac), or click the icon in the top-right of RStudio (it's between the Publish and Compass icons).

<!-- include-exit-ticket -->
