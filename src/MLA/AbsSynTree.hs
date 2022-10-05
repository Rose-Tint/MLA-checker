module MLA.AbsSynTree (
    Text,
    PageNumber,
    Author,
    Paper(..),
    Header(..),
    Title(..),
    Body(..),
    TopExpr(..),
    Expr(..),
    Quotation(..),
    InTextCitation(..),
    Citation(..),
    WorksCited(..),
) where


-- | The type of string used internally
type Text = String

type PageNumber = Integer

type Author = Text

-- | Represents all information about a paper
data Paper
    = Paper {
        paperHeader :: Header,
        paperTitle :: Title,
        paperBody :: Body,
        paperCitations :: WorksCited
    }

-- | The header of a paper contains the author, instructor, course, and date.
-- It is the very first thing to appear in a paper, and is located at the very
-- top left of the first page.
data Header
    = Header {
        headerAuthor :: Maybe Author,
        headerInstructor :: Maybe Text,
        headerCourse :: Maybe Text,
        headerDate :: Maybe Text
    }

-- | The title of a paper follows the header on the very next line.
newtype Title = Title { unTitle :: Text }

-- | The body of the paper includes all headings and paragraphs between the
-- title and the works-cited page.
newtype Body = Body { unBody :: [TopExpr] }

-- | Represents either a heading or a paragraph in the body of a paper.
data TopExpr
    = Heading Text
    | Paragraph [Expr]

-- | Components that make up a paragraph. The purpose of the separation of the
-- components of a paragraph is to allow for deeper analysis
data Expr
    -- | Regular text.
    = Original {
        exprText :: Text
    }
    -- | A quotation.
    | Quotation {
        -- | Text that introduces the quote.
        exprIntro :: Text,
        -- | The quote itself.
        exprQuote :: Quotation,
        -- | Text that appears after the quote, yet in the same sentence.
        exprOutro :: Text
    }

-- | A quotation
data Quotation
    -- | An ordinary quote
    = InlineQuote {
        quoteText :: Text,
        quoteCite :: Maybe InTextCitation
    }
    -- | Block quotes are in-text quotations that are "more than four lines of
    -- prose [sentences] or three lines of verse" (Purdue).
    | BlockQuote {
        quoteText :: Text,
        quoteCite :: Maybe InTextCitation
    }

-- | An in-text citation in author-page style. For example: "(Smith 69)"
data InTextCitation
    = AuthorPage {
        itcAuthor :: Text,
        itcPage :: PageNumber
    }
    -- | The author may be omitted if the author is attributed in the same
    -- sentence that the quotation appears in.
    | PageOnly {
        itcPage :: PageNumber
    }
    -- | The page number may be omitted if the quotation is from a source that
    -- does not have page numbers, such as a website or film.
    | AuthorOnly {
        itcAuthor :: Text
    }
    -- | A quotation that is also a quotation in the source.
    | Indirect InTextCitation

data Citation
    = Citation {
        citeAuthor :: Maybe Text,
        citeSrcTitle :: Maybe Text,
        citeContainer :: Maybe Text,
        citeContributers :: Maybe Text,
        citeVersion :: Maybe Text,
        citeNumber :: Maybe Text,
        citePublisher :: Maybe Text,
        citePubDate :: Maybe Text,
        citeLocation :: Maybe Text
    }

newtype WorksCited = WorksCited { unWorksCited :: [Citation] }
