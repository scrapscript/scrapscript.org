```language-haskell
greet <| person::ron 3

; greet : person -> text =
  | #cowboy -> "howdy"
  | #ron n -> "hi " ++ text/repeat n "a" ++ "ron"
  | #parent #m -> "hey mom"
  | #parent #f -> "greetings father"
  | #friend n -> "yo" |> list/repeat n |> string/join " "
  | #stranger "felicia" -> "bye"
  | #stranger name -> "hello " ++ name

; person :
  #cowboy
  #ron int
  #parent (#m #f)
  #friend int
  #stranger text
```

```{ .language-haskell .result}
"hi aaaron"
```

> Scrapscript is best understood through a few perspectives:
>
> - "it's JSON with types and functions and hashed references"
> - "it's tiny Haskell with extreme syntactic consistency"
> - "it's a language with a weird IPFS thing"

<br/>
<br/>

<h1>scrap<wbr/>script</h1>

Scrapscript solves _the software sharability problem_.

Modern software breaks at boundaries. APIs diverge, packages crumble, configs
ossify, serialization corrupts, git tangles, dependencies break, documentation
dies, vulnerabilities surface, etc.

To make software safe and sharable, scrapscript combines existing wisdom in new
ways:

- all expressions are content-addressible "scraps"
- all programs are data
- all programs are "platformed"

These simple guarantees produce new paradigms:

<ul id="table-of-contents"></ul>

## content-addressible everything

Any chunk of the language can be replaced with a hash.

These chunks are called "scraps".

Scraps are stored/cached/named/indexed in global distributed "scrapyards".

### worldwide collaborative namespace

```{.language-haskell}
31 |> janedoe91/fibonacci
```

```{.language-haskell .result}
1346269
```

```{.language-haskell}
31 |> $~~e4caecf0d6f84d4ad72e228adce6c2b46a0328f9
```

```{.language-haskell .result}
1346269
```

Scrapscript rejects traditional package-management. Instead, "scrapyards"
combine features from Smalltalk, Hackage, IPFS, GitHub, and StackOverflow. This
new paradigm empowers devs to safely collaborate in live environments.

### no broken dependencies

Every scrap carries its own immutable dependencies.

The language itself forms merkle trees; VCS tools like `git` are optional. Every
expression is independently version-controlled through the global namespace.

### expression-level versioning

```{.language-haskell}
pair
(spaceq/is-planet@2005 "pluto")
(spaceq/is-planet@2006 "pluto")
```

```{.language-haskell .result}
pair true false
```

Every expression in the ecosystem can be independently spliced and
"time-travelled".

To avoid giant updates, scrapscript tooling can incrementally upgrade your code.
Any chunk of code can be pinned independently to upgrade at a later time.

### time-travel interpreter

```{.language-bash}
$ echo 'spaceq/is-planet "pluto"' | scrap eval --t="2005-01-01"
```

```{.language-bash .result}
true
```

```{.language-bash}
$ echo 'spaceq/is-planet "pluto"' | scrap eval --t="2006-12-31"
```

```{.language-bash .result}
false
```

Easily inspect code regressions. Execute code with dependencies from a specific
point in time.

## the "platform" paradigm

Scrapscript acts as an algebra for performant "platforms".

By embracing
["managed effects"](https://blog.testdouble.com/posts/2022-02-16-interview-eric-newbury/)
(like Elm and Roc), scrapscript stays small and simple.

### designed for embedded DSLs

```{.language-haskell}
h1 [] [ text "hello world" ]
; { h1, text } = luffy88/html-tags
```

```{.language-haskell}
| "/home" -> q -> res::success <| "<p>howdy " ++ get-name q ++ "</p>"
| "/contact" -> _ -> res::success "<a href="mailto:hello@example.com">email</a>"
| _ -> _ -> res::notfound "<p>not found</p>"
; get-name = maybe/default "partner" << dict/get "name"
; res : #success text #notfound text
```

Platforms are flexible! Use scrapscript as a web server, templating language,
shell, compilation target, tiny embedded OS, query language, or anything
imaginable.

### self-documenting typed configs

```{.language-haskell}
my-org::my-config
{ name = "my-server-001"
, cpus = #4
, mem  = #16
}
; my-org :
    #my-config
      { name : text
      , cpus : #1 #2 #4 #8
      , mem  : #1 #2 #4 #8 #16 #32
      }
```

## large as a language; small as a message

Scrapscript is a full programming language designed to be sent over the wire
with type-safety in mind.

### all valid programs return valid programs

```{.language-bash}
$ echo 'my-type::left ; my-type : #left #right' \
> | scrap eval \
> | scrap eval \
> | scrap eval
```

```{.language-haskell .result}
my-type::left
; my-type :
  #left
  #right
```

```{.language-bash}
$ echo 'ok (42 + 1)' \
> | scrap eval --result \
> | scrap eval --result \
> | scrap eval --result
```

```{.language-haskell .result}
ok 43
```

```{.language-bash}
$ echo 'ok (42 + "apple")' \
> | scrap eval --result \
> | scrap eval --result \
> | scrap eval --result
```

```{.language-haskell .result}
err [ eval/type-error "+" "int" "text" ]
```

Scrapscript is small enough to be its own complete datatype.

Every scrap carries its own custom types. Stale references are simply
impossible.

Programs can be chained and transformed in completely new ways. Pass your scraps
through linters and optimizers in simple pipelines.

### send arbitrary types over the wire

```{.language-haskell}
animal::horse "Lucy"
; animal :
  #horse text
  #zebra int
```

Let the computers communicate which types they're using.

Don't waste engineering hours juggling types and serialization across different
machines.

### send unevaluated sandboxed programs

```{.language-haskell}
quang77/nth-digit-pi 420000000000
```

Scrapscript programs are safe to send around.

Many client/server relationships can be radically simplified by skipping
serialization.

### comes with "flat" binary representation

```{.language-bash}
$ echo '3 * 5' | scrap eval | scrap flat | hexdump -C
```

```{.language-haskell .result}
0F
```

```{.language-bash}
$ echo 'true' | scrap flat | hexdump -C
```

```{.language-bash .result}
C3
```

```{.language-bash}
$ echo '[ false, true ]' | scrap flat | hexdump -C
```

```{.language-haskell .result}
92C2C3
```

Put programs into JSONB-sized packages. Scrapscript fits into
[msgpack](https://msgpack.org).

### magic compression

```{.language-bash}
$ echo 'sarahsmith65/very-large-video' | scrap flat | hexdump -C
```

```{.language-haskell .result}
D8A196C4BC3A1139B2413CBE2EBECA8F3B754166450E
```

Instead of sharing large dumps of data, you can send references to any data
anywhere.

By sending references, other machines can opt to pull the data from cache or
high-speed CDNs.

## first-class network requests

By leveraging scraps-as-messages, scrapscript explores new networking paradigms.

Scrapyards enable new compile-time primitives for verifying type-safety across
network boundaries. "Contracts" are automatically inferred and enforced between
clients, servers, and external APIs.

### serialization-free experience

<!-- TODO: move this syntax into decorators -->

```{.language-bash}
$ echo "@hucksternews/frontpage 3" | scrap platform task
```

```{.language-haskell .result}
[ "https://ciechanow.ski/mechanical-watch"
, "http://www.paulgraham.com/todo.html"
, "https://sive.rs/hellyeah"
]
```

Scrapscript automatically serializes and deserializes scraps across any API
boundaries. The system doesn't care whether you use IPC, HTTP, QUIC, email, etc.

### typecheck across network bounds

<!-- TODO: move this syntax into decorators -->

```{.language-bash}
$ echo "@rebbit/users 42" | scrap eval
```

```{.language-bash .result}
error: @rebbit/users expects type rebbit/users-request
```

The scrapscript compiler tells you when remote APIs differ from the code. And if
the API changes while the code is running, scrapscript offers a series of
graceful handling options.

## tooling from first-principles

Scrapscript vertically integrates editors, VCS, configuration, platforms,
payments, data, and cloud infrastructure.

### optimized for AI & autocomplete

```{.language-haskell}
f a b
; f = | x -> y -> x * y
; a = 1
; b = 2
```

Scrapscript encourages [wishful thinking](https://wiki.c2.com/?WishfulThinking).

Declare your goal up-front, and let your tooling make educated guesses about how
to get there.

### snippets on steroids

```{.language-bash}
$ echo "~~633b327df5e54bb626300a19a459b7bd81cce3ad13f72aa395df41e03f6a1577" \
| scrap save "my-key"
```

Save your scraps in scrapbooks to privately sync across your devices.

Use team scrapbooks to collaborate on code in a live environment.

### seamlessly publish and partake

```{.language-haskell}
@yard/publish my-key "greet" "| _ -> \"hello\""
```

```{.language-haskell .result}
task::success ()
```

```{.language-haskell}
connie2036/greet "hi"
```

```{.language-haskell .result}
"hello"
```

```{.language-haskell}
@yard/get "connie2036/greet"
```

```{.language-haskell .result}
task:success "greet" "| _ -> \"hello\""
```

```{.language-haskell}
@yard/delete my-key "greet"
```

```{.language-haskell .result}
task::success ()
```

Scrapyards store scraps in an IPFS-like system with name and versioning
information.

### hosting, accounts, and payments

Development doesn't need to be difficult. Scraplab will offer the best features
of the following services in an integrated experience:

- Stripe/Gumroad/Patreon
- Netlify/Fly.io
- GitHub

### brand new browser

The scrapland browser turns every scrap into its own interactive page.
