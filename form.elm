import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main =
    Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model =
    {
        name : String,
        password : String,
        passwordConfirm : String
    }

model : Model
model =
    Model "" "" ""

-- UPDATE

type Msg
    = Name String
    | Password String
    | PasswordConfirm String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordConfirm passwordConfirm ->
            { model | passwordConfirm = passwordConfirm }

-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "text", placeholder "Password", onInput Password ] []
        , input [ type_ "text", placeholder "Please re-enter your password", onInput PasswordConfirm] []
        , viewValidation model
        ]

viewValidation : Model -> Html msg
viewValidation model =
    let
        (color, message) =
            if model.password == model.passwordConfirm then
                ("green", "OK")
            else
                ("red", "Passwords do not match!")
    in
        div [ style [("color", color)] ] [ text message ]
