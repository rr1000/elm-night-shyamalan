import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http
import Task exposing (Task)

-- PROGRAM
main : Program Never
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }

-- MODEL
type alias Model =
    {quote : String}

init : (Model, Cmd Msg)
init =
    (Model "", fetchRandomQuoteCmd)

-- UPDATE
api : String
api =
    "http://localhost:3001"

randomQuoteUrl : String
randomQuoteUrl =
    api ++ "api/random-quote"

fetchRandomQuote : Platform.Task Http.Error String
fetchRandomQuote =
    Http.getString randomQuoteUrl

fetchRandomQuoteCmd : Cmd Msg
fetchRandomQuoteCmd =
    Task.perform HttpError FetchQuoteSuccess fetchRandomQuote

type Msg
    = GetQuote
    | FetchQuoteSuccess String
    | HttpError Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GetQuote ->
            (model, fetchRandomQuoteCmd)

        FetchQuoteSuccess newQuote ->
            ({model |  quote = newQuote}, Cmd.none)

        HttpError _ ->
            (model, Cmd.none)

-- VIEW
view : Model -> Html Msg
view model =
    div [class "container"] [
        h2 [class "text-center"] [text "Chuck Norris Quotes"]
        , p [class "text-center"] [
            button [ class "btn btn-success", onClick GetQuote] [ text "Get a quote buddy"]
        ]
        , blockquote [] [
            p[][text model.quote]
        ]
    ]
