#  Pizzas anyone?

## Build
- Bundle install
- Pod install

## Additions
- There is a default error handling that will present a modal if the look up of places fails.
- Look up of friends at a place, on the other hand, will fail silently.
- Modal to present preview of place.

## Arch
- Project is divided in SDK & App targets.
- Used ReactiveSwift for bindings.
- Pattern: MVVM with routing to load and present scenes.

## Too many requests
Stumbled upon this error a couple of times :/
`429 - Too Many Requests. Refer: https://beeceptor.com/pricing`
There is a flag in the SDK to toggle the use of the alternate API.
