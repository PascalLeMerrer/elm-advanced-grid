module Grid.Stylesheet exposing (grid, preferences, resizingHandleWidth)

import Css exposing (Style, absolute, after, alignItems, alignSelf, auto, backgroundColor, backgroundImage, before, border, border3, borderBottom3, borderLeft3, borderRadius, borderRight3, boxSizing, center, colResize, column, contentBox, cursor, deg, display, displayFlex, firstOfType, flexDirection, flexEnd, flexGrow, flexShrink, flexStart, float, fontSize, height, hidden, hover, inlineFlex, int, justifyContent, left, lineHeight, linearGradient, margin, marginBottom, marginLeft, marginRight, maxWidth, minHeight, move, noWrap, none, num, opacity, overflow, overflowX, overflowY, padding, paddingLeft, paddingRight, paddingTop, pct, pointer, pointerEvents, position, property, px, relative, right, rotate, row, solid, spaceAround, spaceBetween, stop, stretch, top, transform, transparent, visibility, visible, whiteSpace, width, zIndex)
import Css.Global exposing (Snippet, class, descendants, global, typeSelector)
import Grid.Colors exposing (black, darkGrey, darkGrey2, darkGrey3, lightGreen, lightGrey, lightGrey2, white, white2)
import Html.Styled


grid : Html.Styled.Html msg
grid =
    global
        gridStyles


gridStyles : List Snippet
gridStyles =
    [ class "cell"
        [ alignItems center
        , display inlineFlex
        , noShrink
        , justifyContent spaceBetween
        , borderLeft3 (px 1) solid lightGrey
        , borderRight3 (px 1) solid lightGrey
        , firstOfType [ justifyContent flexEnd ] -- justifies on right the first column to avoid it being partially hidden by vertical scrollbar
        , boxSizing contentBox
        , minHeight (pct 100) -- 100% min height forces empty divs to be correctly rendered
        , paddingLeft (px 2)
        , paddingRight (px 2)
        , descendantsVisibleOnHover
        , overflow hidden
        , whiteSpace noWrap
        ]
    , class "drag-handle"
        [ displayFlex
        , flexDirection row
        , cursor move
        , fontSize (px 0.1)
        , height (pct 100)
        , visibility hidden
        , width (px 10)
        , zIndex (int 5)
        ]
    , class "flex-row"
        [ displayFlex
        , noShrink
        , flexDirection row
        , flexGrow (num 1)
        , justifyContent flexStart
        ]
    , class "flex-column"
        [ displayFlex
        , noShrink
        , flexDirection column
        , alignItems flexStart
        , overflow hidden
        ]
    , class "ghost-header"
        [ position absolute
        , top (px 2)
        , pointerEvents none
        ]
    , class "grid"
        [ overflow auto
        , margin auto
        , position relative
        ]
    , class
        "headers"
        [ overflow auto
        , margin auto
        , position relative
        ]
    , class "header"
        [ backgroundImage <| linearGradient (stop white2) (stop lightGrey) []
        , display inlineFlex
        , noShrink
        , flexDirection row
        , border3 (px 1) solid lightGrey2
        , boxSizing contentBox
        , descendantsVisibleOnHover
        , padding (px 2)
        , zIndex (int 10)
        ]
    , class "header-container"
        [ backgroundColor darkGrey
        , displayFlex
        , noShrink
        ]
    , class "header-title"
        [ lineHeight (num 1.2)
        ]
    , class "input-filter"
        [ border (px 0)
        , paddingLeft (px 2)
        , paddingRight (px 2)
        , marginLeft (px resizingHandleWidth) -- for visual centering in the header
        ]
    , class "input-filter-container"
        [ displayFlex
        , flexDirection row
        , justifyContent spaceBetween
        , alignItems center
        , alignSelf stretch
        , backgroundColor white
        , borderRadius (px 3)
        , marginLeft (px 4)
        ]
    , class "invisible"
        [ opacity (num 0)
        ]
    , class "margin-Left-XS"
        [ marginLeft (px 5)
        ]
    , class "progress-bar-background"
        [ displayFlex
        , backgroundColor white
        , borderRadius (px 5)
        , border3 (px 1) solid lightGrey
        ]
    , class "progress-bar-container"
        [ displayFlex
        , alignItems center
        , border3 (px 1) solid lightGrey
        , boxSizing contentBox
        , height (pct 100)
        , paddingLeft (px 5)
        , paddingRight (px 5)
        ]
    , class "progress-bar-foreground"
        [ backgroundColor lightGreen
        , borderRadius (px 5)
        , overflow visible
        ]
    , class "quick-filter-button"
        [ cursor pointer
        , padding (px 2)
        , paddingTop (px 6)
        ]
    , class "resize-handle"
        [ cursor colResize
        , displayFlex
        , justifyContent spaceAround
        , height (pct 100)
        , visibility hidden
        , width (px resizingHandleWidth)
        ]
    , class "root"
        [ overflow hidden
        , margin auto
        , position relative
        ]
    , class "row"
        [ borderBottom3 (px 1) solid lightGrey
        , displayFlex

        -- restore reading order, while preserving the left position of the scrollbar
        , property "direction" "ltr"
        ]
    , class "rows"
        [ overflowX hidden
        , overflowY auto

        -- displays the vertical scrollbar to the left. https://stackoverflow.com/questions/7347532/how-to-position-a-div-scrollbar-on-the-left-hand-side
        , property "direction" "rtl"
        ]
    , class "selection-header"
        [ displayFlex
        , noShrink
        , justifyContent center
        , alignItems center
        ]
    , class "small-square"
        [ backgroundColor darkGrey2
        , borderRadius (pct 50)
        , height (px 3)
        , width (px 3)
        , marginRight (px 1)
        , marginBottom (px 2)
        ]
    , class "arrow-head"
        [ width (px 0)
        , height (px 0)
        , borderLeft3 (px 5) solid transparent
        , borderRight3 (px 5) solid transparent
        , margin (px 5)
        ]
    , class "vertical-bar"
        [ width (px 1)
        , height (px 10)
        , backgroundColor darkGrey3
        ]
    ]


descendantsVisibleOnHover : Style
descendantsVisibleOnHover =
    hover
        [ descendants
            [ typeSelector "div"
                [ visibility visible -- makes the move handle visible when hover the column
                ]
            ]
        ]


{-| prevents width to be automatically reduced
-}
noShrink : Style
noShrink =
    flexShrink (num 0)


resizingHandleWidth : Float
resizingHandleWidth =
    5


preferences : Html.Styled.Html msg
preferences =
    global
        preferencesStyles


preferencesStyles : List Snippet
preferencesStyles =
    [ class "bordered"
        [ border3 (px 1) solid lightGrey2
        , margin auto
        , padding (px 5)
        ]
    , class "close-button"
        [ cursor pointer
        , position relative
        , float right
        , width (px 16)
        , height (px 16)
        , opacity (num 0.3)
        , hover
            [ opacity (num 1) ]
        , before
            [ position absolute
            , left (px 7)
            , property "content" "' '"
            , height (px 17)
            , width (px 2)
            , backgroundColor black
            , transform (rotate (deg 45))
            ]
        , after
            [ position absolute
            , left (px 7)
            , property "content" "' '"
            , height (px 17)
            , width (px 2)
            , backgroundColor black
            , transform (rotate (deg -45))
            ]
        ]
    ]
