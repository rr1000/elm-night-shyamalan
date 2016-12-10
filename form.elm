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
        passwordConfirm : String,
        age : Int
    }

model : Model
model =
    Model "" "" "" 0

-- UPDATE

type Msg
    = Name String
    | Password String
    | PasswordConfirm String
    | Age Int

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordConfirm passwordConfirm ->
            { model | passwordConfirm = passwordConfirm }

        Age age ->
            { model | age = age }

-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "text", placeholder "Password", onInput Password ] []
        , input [ type_ "text", placeholder "Please re-enter your password", onInput PasswordConfirm] []
        , input [ type_ "number", placeholder "enter your age"] []
        , formValidation model
        ]

formValidation : Model -> Html msg
formValidation model =
    let
        good = "#1055FF"
        bad = "#D93939"
        (color, message) =
            if model.password == model.passwordConfirm then
                (good, "OK")
            else
                (bad, "Passwords do not match!")
    in
        div [ style [("color", color)] ] [ text message ]
