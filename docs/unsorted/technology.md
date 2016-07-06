## Redux 


Redux attempts to make state mutations predictable by imposing certain restrictions on how and when updates can happen

## Three Principles

- Single State of truth
> The state of your whole applicaiton is stored in an object within a single store. 
**Think Redo/Undo much easier to implement**
- State is read-only
The only way to mutate the state is to emit an action, an object describing what happened.
Think about immutablility with integer you would never write the following:
> 42 + 1 = 42
the correct form is:
> 42 + 1 = 43
This ensures that neither the views nor the network callbacks will ever write directly to the state. Instead, they express an intent to mutate. Because all mutations are centralized and happen one by one in a strict order, there are no subtle race conditions to watch out for. As actions are just plain objects, they can be logged, serialized, stored, and later replayed for debugging or testing purposes.
- Changes are made with Pure functions 
To specify how the state tree is transformed by actions, you write pure reducers.
Reducers are just pure functions that take the previous state and an action, and return the next state. 
Remember to return new state objects, instead of mutating the previous state.




# Similar to Flux
Essentially an implementation of Flux Architecture. (Some differences though)

Flux has often been described as (state, action) => state. Redux is true to the Flux Architecture.



### Main Points

 - **A Redux application's state tree is an immutable data structure.**
 That means that once you have a state tree, it will never change as long as it exists. It will keep holding the same state forever. How you then go to the next state is by producing another state tree that reflects the changes you wanted to make.


 To get acquainted with the idea of immutability, it may be helpful to first talk about the simplest possible data structure: What if you had a "counter" application whose state was nothing but a single number? The state would go from 0 to 1 to 2 to 3, etc.

We are already used to thinking of numbers as immutable data. When the counter increments, we don't mutate a number. It would in fact be impossible as there are no "setters" on numbers. You can't say 42.setValue(43).





# ES6 plugins 

# Object Spread Syntax `(...)`
## How to use
- instead of Object.assign() use `...`
```js
function todoApp(state = initialState, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return { ...state, visibilityFilter: action.filter }
    default:
      return state
  }
}
```

## Why use
- While effective, using Object.assign() can quickly make simple reducers difficult to read given its rather verbose syntax.

See http://redux.js.org/docs/recipes/UsingObjectSpreadOperator.html

## How to install
- Need to use babel as is still a Stage 2 proposal for ECMAScript

You can use your existing es2015 preset, install babel-plugin-transform-object-rest-spread and add it individually to the plugins array in your .babelrc.

```js
{
  "presets": ["es2015"],
  "plugins": ["transform-object-rest-spread"]
}
```

# Default State 
- ES6 default arguments syntax

```js
function todoApp(state = initialState, action) {
  // For now, don’t handle any actions
  // and just return the state given to us.
  return state
}
```