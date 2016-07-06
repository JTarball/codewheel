# Getting Started

This is a React.js, Redux, Mocha (unit testing) and Docker powered app


IMUUTABLE , CHAI
## Technology Overview
The technology overview covers the important articles, tutorials or videos that can be completed if you have either forgotten or have not touched these technologies before.
### Redux
- Please read the [Redux documentation](http://redux.js.org/index.html)
### React.js
### Mocha (Unit Testing)
### Docker



## Prequistics
- Make sure `React Developer tools` browser plugin is installed
- Make sure `Redux Devtools` browser plugin is installed

## How the `src` was created for you
``` 
 npm init -y
 npm install --save-dev babel-core babel-cli babel-preset-es2015
 npm install --save immutable
 npm install --save-dev mocha chai chai-immutable

modify package.json so mocha test can be run via
npm run test
add to scripts to watch for changes
"test:watch": "npm run test -- --watch" 

npm install --save-dev webpack webpack-dev-server

We are also going to use the JSX syntax to write our React components, so let’s install the Babel React package:
npm install --save-dev babel-preset-react


hot reloading
npm install --save react react-dom
npm install --save-dev react-hot-loader

in package.json
  "babel": {
    "presets": ["es2015", "react"]
  },

webpack
modify to use jsx



```


## Commands

npm run test

npm run test:watch
watches for changes in our code and run the tests


webpack
produce bundle.js


webpack-dev-server



## Redux


## ES6 plugins

## 



# How to Design the FrontEnd
- 1. Define the tasks of the UI *HIGH LEVEL*
	- Remember keep data away from the UI State
- 2. Define components



## Define the tasks of the UI

Create high level tasks for the UI


For example, for a **ToDo App** the requirement might be:

- Each todo can be active or completed
- A todo can be added, edited or deleted
- Todos can be filtered by their status
- A counter of active todos is displayed at the bottom
- Completed todos can be deleted all at once




## How to DESIGN frontend

## How to use 

### Designing in Flux 

Designing in Flux Architecture (in our case Redux and React.js) can be difficult to get your head around as it is very different to the well known MVC architecture used in web application. Once you have got use to however you will find that it far more transparent and intuitive.

We recommend the following steps when 'designing in Flux (React / React.js / Babel.js)'

## Thinking/Design in Redux/Flux
- define tasks of the ui: high level  (what is the state of the UI?) (Try to keep data away from UI state)
- create actions from this (names only)
- create presentational components via React
- connect to Redux (dispatcher) from high level
- define actions in Redux
- reducers to get new state (previousState, action) => newState
- define entrypoint (index.js) for Redux



create user stories

- create tasks

- take a task 
- - create ui tasks from task
- - create actions form names
- - - take action
- - - action + action types
- - - test with mocha chai
- - - create 

- create tasks of the ui from user stories











## 1. Define Tasks

Before designing in Flux you must have some tasks (user stories) which describe the way the UI will interact. This will be used later to create action types and will focus the implementation
 of the actions.


E.g. of Defining Tasks






## 2. Create Action, Action Types from Tasks

- create `constants/` folder
- define an `ActionsType.js` which will hold constant action types (expression way of describing a ui action task)
- create `actions/` folder
- define action creators 

state is readonly -- think numbers 

when you chnage with an action - new state created


action -- the only thing it needs is a type (normally a string)




- Create `constants/` folder under `src/`
 this will hold all action Types


Define Actions Type - 
As you can see, this is a pretty expressive way of defining the scope of our application, which will allow us to add a friend, mark him as favorite or remove him from our friend list.


``` js
/* src/constants/ActionTypes.js */

export const ADD_FRIEND = 'ADD_FRIEND';  
export const STAR_FRIEND = 'STAR_FRIEND';  
export const DELETE_FRIEND = 'DELETE_FRIEND';  

```


Action creators are function that create actions. They do not dispatch to the store, making them portable and easier to test as they have no side-effects. We put them in the actions folder but keep in mind that they are a different notion.



``` js
import * as types from '../constants/ActionTypes';

export function addFriend(name) {
  return {
    type: types.ADD_FRIEND,
    name
  };
}

export function deleteFriend(id) {
  return {
    type: types.DELETE_FRIEND,
    id
  };
}

export function starFriend(id) {
  return {
    type: types.STAR_FRIEND,
    id
  };
}
```


## 3. Create Reducers 

Reducers are in charge of modifying the state of the application.

Remember state is read-only and a new one must be create when an action is applied. If you were to just mutate the previous state you wouldnt be able to time travel.

Think incrementing a number  

42 + 1 = 43  (new number)

NOT

42 = 43


``` js
(previousState, action) => newState

```

- Define initial state
- use ES6 default
- create case statements for actions
- for complex applications add an index.js

index.js
``` js
export { default as friendlist } from './friendlist';
```




``` js
import * as types from '../constants/ActionTypes';
import omit from 'lodash/object/omit';
import assign from 'lodash/object/assign';
import mapValues from 'lodash/object/mapValues';

const initialState = {
  friends: [1, 2, 3],
  friendsById: {
    1: {
      id: 1,
      name: 'Theodore Roosevelt'
    },
    2: {
      id: 2,
      name: 'Abraham Lincoln'
    },
    3: {
      id: 3,
      name: 'George Washington'
    }
  }
};

export default function friends(state = initialState, action) {
  switch (action.type) {

    case types.ADD_FRIEND:
      const newId = state.friends[state.friends.length-1] + 1;
      return {
        ...state,
        friends: state.friends.concat(newId),
        friendsById: {
          ...state.friendsById,
          [newId]: {
            id: newId,
            name: action.name
          }
        },
      }

    case types.DELETE_FRIEND:
      return {
        ...state,
        friends: state.friends.filter(id => id !== action.id),
        friendsById: omit(state.friendsById, action.id)
      }

    case types.STAR_FRIEND:
      return {
        ...state,
        friendsById: mapValues(state.friendsById, (friend) => {
          return friend.id === action.id ?
            assign({}, friend, { starred: !friend.starred }) :
            friend
        })
      }

    default:
      return state;
  }
}
```


I added lodash as a dependency to manipulate objects more easily. As always in those two examples, the important thing is to not mutate the previous state, so we use functions that return a new object. For example instead of using "delete state.friendsById[action.id], we use the _.omit function that is not destructive. 
You can also remark that the spread operator allows us to only manipulate the part of the state that we want to modify.

Redux doesn't care how you store your data so if a tool like Immutable.js makes sense in your project, you're free to use it.



## Wrap actions to dispatchcd








cam test

/* src/containers/App.js */

import { addFriend, deleteFriend, starFriend } from '../actions/FriendsActions';

store.dispatch(addFriend('Barack Obama'));

store.dispatch(deleteFriend(1));

store.dispatch(starFriend(4));






### Define EntryPoint

Next we need to modify our App.js to connect redux. To do this, we will use the Provider from `react-redux`.

It's a component that takes your store as property and has a function as child

```
export default class App extends Component {  
  render() {
    return (
      <div>
        <Provider store={store}>
          {() => <FriendListApp /> }
        </Provider>

        {renderDevTools(store)}
      </div>
    );
  }
}
```







# Unit Testing
- action creators, middlware, reducers
- react componenets using npm install --save-dev react-addons-test-utils




Install local npm packages

* [eslint](https://www.npmjs.com/package/eslint)
* [babel-eslint](https://www.npmjs.com/package/babel-eslint)
* [eslint-plugin-react](https://www.npmjs.com/package/eslint-plugin-react)

```shell
npm install --save-dev eslint babel-eslint eslint-plugin-react


```




















## How to design your website

As stated before we use React.js and Redux. Please see technologies chapter for more info.

This page specifies and explains the information and way of thinking when designing a react/redux application.

This page should act as a reminder on how to understand this topic.


### React and Redux Prequistics

- React bindings are not included in Redux by default. You must install them:
> npm install --save react-redux




### Server / Client Side

### Thinking in React and Redux

### React Data Flow 



server / client side / synchronous / asynchronous


## Asynchrnous thinking / Data Flow
http://redux.js.org/docs/advanced/AsyncActions.html

Three different types of async actions:
- An action informing the reducers that the request began. (toggle `isFetching` flag)
- An action informing the reducers that the request finished successfully (reset `isFetching` flag)
- An  action informing the reducers that the request failed (reset `isFetching` flag  + store an error message -> UI display it )

### Designing the State



### Full Exmaple
http://redux.js.org/docs/advanced/ExampleRedditAPI.html
# ES6
- es6 format in java - make it nice but nor suppotered by all browsers need babel or someother plugin
















## Thinking/Design in Redux/Flux
- define tasks of the ui: high level  (what is the state of the UI?) (Try to keep data away from UI state)
- create actions from this (names only)
- create presentational components via React
- connect to Redux (dispatcher) from high level
- define actions in Redux
- reducers to get new state (previousState, action) => newState
- define entrypoint (index.js) for Redux


# Unit Testing
- action creators, middlware, reducers
- react componenets using npm install --save-dev react-addons-test-utils




components/ - React components representing presentation components

actions/
reducers/
store/configureStore.js 























## best practices



Actions look like this:

{ type: 'ADD_TODO', text: 'Use Redux' }
{ type: 'REMOVE_TODO', id: 42 }
{ type: 'LOAD_ARTICLE', response: { ... } }
It is a common convention that actions have a constant type that helps reducers (or Stores in Flux) identify them. We recommend that you use strings and not Symbols for action types, because strings are serializable, and by using Symbols you make recording and replaying harder than it needs to be.





## Using Ajax
Each of these two moments can usually require a change in the application state; to do that, you need to dispatch normal actions that will be processed by reducers synchronously. Usually, for any API request you’ll want to dispatch at least three different kinds of actions:

An action informing the reducers that the request began.

The reducers may handle this action by toggling an isFetching flag in the state. This way the UI knows it’s time to show a spinner.

An action informing the reducers that the request finished successfully.

The reducers may handle this action by merging the new data into the state they manage and resetting isFetching. The UI would hide the spinner, and display the fetched data.

An action informing the reducers that the request failed.

The reducers may handle this action by resetting isFetching. Maybe, some reducers will also want to store the error message so the UI can display it.


You may use a dedicated status field in your actions:

{ type: 'FETCH_POSTS' }
{ type: 'FETCH_POSTS', status: 'error', error: 'Oops' }
{ type: 'FETCH_POSTS', status: 'success', response: { ... } }
Or you can define separate types for them:

{ type: 'FETCH_POSTS_REQUEST' }
{ type: 'FETCH_POSTS_FAILURE', error: 'Oops' }
{ type: 'FETCH_POSTS_SUCCESS', response: { ... } }








If you have nested entities, or if you let users edit received entities, you should keep them separately in the state as if it was a database. In pagination information, you would only refer to them by their IDs. This lets you always keep them up to date. The real world example shows this approach, together with normalizr to normalize the nested API responses. With this approach, your state might look like this:








# Three Principles

Redux can be described in three fundamental principles:

### Single source of truth

**The [state](../Glossary.md#state) of your whole application is stored in an object tree within a single [store](../Glossary.md#store).**

This makes it easy to create universal apps, as the state from your server can be serialized and hydrated into the client with no extra coding effort. A single state tree also makes it easier to debug or introspect an application; it also enables you to persist your app’s state in development, for a faster development cycle. Some functionality which has been traditionally difficult to implement - Undo/Redo, for example - can suddenly become trivial to implement, if all of your state is stored in a single tree.

```js
console.log(store.getState())

{
  visibilityFilter: 'SHOW_ALL',
  todos: [
    {
      text: 'Consider using Redux',
      completed: true,
    }, 
    {
      text: 'Keep all state in a single tree',
      completed: false
    }
  ]
}
```

### State is read-only

**The only way to mutate the state is to emit an [action](../Glossary.md#action), an object describing what happened.**

This ensures that neither the views nor the network callbacks will ever write directly to the state. Instead, they express an intent to mutate. Because all mutations are centralized and happen one by one in a strict order, there are no subtle race conditions to watch out for. As actions are just plain objects, they can be logged, serialized, stored, and later replayed for debugging or testing purposes.

```js
store.dispatch({
  type: 'COMPLETE_TODO',
  index: 1
})

store.dispatch({
  type: 'SET_VISIBILITY_FILTER',
  filter: 'SHOW_COMPLETED'
})
```

### Mutations are written as pure functions

**To specify how the state tree is transformed by actions, you write pure [reducers](../Glossary.md#reducer).**

Reducers are just pure functions that take the previous state and an action, and return the next state. Remember to return new state objects, instead of mutating the previous state. You can start with a single reducer, and as your app grows, split it off into smaller reducers that manage specific parts of the state tree. Because reducers are just functions, you can control the order in which they are called, pass additional data, or even make reusable reducers for common tasks such as pagination.

```js

function visibilityFilter(state = 'SHOW_ALL', action) {
  switch (action.type) {
    case 'SET_VISIBILITY_FILTER':
      return action.filter
    default:
      return state
  }
}

function todos(state = [], action) {
  switch (action.type) {
    case 'ADD_TODO':
      return [
        ...state,
        {
          text: action.text,
          completed: false
        }
      ]
    case 'COMPLETE_TODO':
      return [
        ...state.slice(0, action.index),
        Object.assign({}, state[action.index], {
          completed: true
        }),
        ...state.slice(action.index + 1)
      ]
    default:
      return state
  }
}

import { combineReducers, createStore } from 'redux'
let reducer = combineReducers({ visibilityFilter, todos })
let store = createStore(reducer)
```

That’s it! Now you know what Redux is all about.






## Middleware

Middleware lets you inject custom logic that interprets every action object before it is dispatched. Async actions are the most common use case for middleware.

## Reducers
Basic representation of a reducer:

(previousState, action) => newState



It’s called a reducer because it’s the type of function you would pass to Array.prototype.reduce(reducer, ?initialValue). It’s very important that the reducer stays pure. 
Things you should never do inside a reducer:

Mutate its arguments;
Perform side effects like API calls and routing transitions;
Calling non-pure functions, e.g. Date.now() or Math.random().


Given the same arguments, it should calculate the next state and return it. No surprises. No side effects. No API calls. No mutations. Just a calculation.





## Stores
Store
In the previous sections, we defined the actions that represent the facts about “what happened” and the reducers that update the state according to those actions.

The Store is the object that brings them together. The store has the following responsibilities:

Holds application state;
Allows access to state via getState();
Allows state to be updated via dispatch(action);
Registers listeners via subscribe(listener).
It’s important to note that you’ll only have a single store in a Redux application. When you want to split your data handling logic, you’ll use reducer composition instead of many stores.

It’s easy to create a store if you have a reducer. In the previous section, we used combineReducers() to combine several reducers into one. We will now import it, and pass it to createStore().



## How to use 

### Designing in Flux 

Designing in Flux Architecture (in our case Redux and React.js) can be difficult to get your head around as it is very different to the well known MVC architecture used in web application. Once you have got use to however you will find that it far more transparent and intuitive.

We recommend the following steps when 'designing in Flux (React / React.js / Babel.js)'

## Thinking/Design in Redux/Flux
- define tasks of the ui: high level  (what is the state of the UI?) (Try to keep data away from UI state)
- create actions from this (names only)
- create presentational components via React
- connect to Redux (dispatcher) from high level
- define actions in Redux
- reducers to get new state (previousState, action) => newState
- define entrypoint (index.js) for Redux



create user stories

- create tasks

- take a task 
- - create ui tasks from task
- - create actions form names
- - - take action
- - - action + action types
- - - test with mocha chai
- - - create 

- create tasks of the ui from user stories











## 1. Define Tasks

Before designing in Flux you must have some tasks (user stories) which describe the way the UI will interact. This will be used later to create action types and will focus the implementation
 of the actions.


E.g. of Defining Tasks






## 2. Create Action, Action Types from Tasks

- create `constants/` folder
- define an `ActionsType.js` which will hold constant action types (expression way of describing a ui action task)
- create `actions/` folder
- define action creators 

state is readonly -- think numbers 

when you chnage with an action - new state created


action -- the only thing it needs is a type (normally a string)




- Create `constants/` folder under `src/`
 this will hold all action Types


Define Actions Type - 
As you can see, this is a pretty expressive way of defining the scope of our application, which will allow us to add a friend, mark him as favorite or remove him from our friend list.


``` js
/* src/constants/ActionTypes.js */

export const ADD_FRIEND = 'ADD_FRIEND';  
export const STAR_FRIEND = 'STAR_FRIEND';  
export const DELETE_FRIEND = 'DELETE_FRIEND';  

```


Action creators are function that create actions. They do not dispatch to the store, making them portable and easier to test as they have no side-effects. We put them in the actions folder but keep in mind that they are a different notion.



``` js
import * as types from '../constants/ActionTypes';

export function addFriend(name) {
  return {
    type: types.ADD_FRIEND,
    name
  };
}

export function deleteFriend(id) {
  return {
    type: types.DELETE_FRIEND,
    id
  };
}

export function starFriend(id) {
  return {
    type: types.STAR_FRIEND,
    id
  };
}
```


## 3. Create Reducers 

Reducers are in charge of modifying the state of the application.

Remember state is read-only and a new one must be create when an action is applied. If you were to just mutate the previous state you wouldnt be able to time travel.

Think incrementing a number  

42 + 1 = 43  (new number)

NOT

42 = 43


``` js
(previousState, action) => newState

```

- Define initial state
- use ES6 default
- create case statements for actions
- for complex applications add an index.js

index.js
``` js
export { default as friendlist } from './friendlist';
```




``` js
import * as types from '../constants/ActionTypes';
import omit from 'lodash/object/omit';
import assign from 'lodash/object/assign';
import mapValues from 'lodash/object/mapValues';

const initialState = {
  friends: [1, 2, 3],
  friendsById: {
    1: {
      id: 1,
      name: 'Theodore Roosevelt'
    },
    2: {
      id: 2,
      name: 'Abraham Lincoln'
    },
    3: {
      id: 3,
      name: 'George Washington'
    }
  }
};

export default function friends(state = initialState, action) {
  switch (action.type) {

    case types.ADD_FRIEND:
      const newId = state.friends[state.friends.length-1] + 1;
      return {
        ...state,
        friends: state.friends.concat(newId),
        friendsById: {
          ...state.friendsById,
          [newId]: {
            id: newId,
            name: action.name
          }
        },
      }

    case types.DELETE_FRIEND:
      return {
        ...state,
        friends: state.friends.filter(id => id !== action.id),
        friendsById: omit(state.friendsById, action.id)
      }

    case types.STAR_FRIEND:
      return {
        ...state,
        friendsById: mapValues(state.friendsById, (friend) => {
          return friend.id === action.id ?
            assign({}, friend, { starred: !friend.starred }) :
            friend
        })
      }

    default:
      return state;
  }
}
```


I added lodash as a dependency to manipulate objects more easily. As always in those two examples, the important thing is to not mutate the previous state, so we use functions that return a new object. For example instead of using "delete state.friendsById[action.id], we use the _.omit function that is not destructive. 
You can also remark that the spread operator allows us to only manipulate the part of the state that we want to modify.

Redux doesn't care how you store your data so if a tool like Immutable.js makes sense in your project, you're free to use it.



## Wrap actions to dispatchcd








cam test

/* src/containers/App.js */

import { addFriend, deleteFriend, starFriend } from '../actions/FriendsActions';

store.dispatch(addFriend('Barack Obama'));

store.dispatch(deleteFriend(1));

store.dispatch(starFriend(4));






### Define EntryPoint

Next we need to modify our App.js to connect redux. To do this, we will use the Provider from `react-redux`.

It's a component that takes your store as property and has a function as child

```
export default class App extends Component {  
  render() {
    return (
      <div>
        <Provider store={store}>
          {() => <FriendListApp /> }
        </Provider>

        {renderDevTools(store)}
      </div>
    );
  }
}
```







# Unit Testing
- action creators, middlware, reducers
- react componenets using npm install --save-dev react-addons-test-utils




Install local npm packages

* [eslint](https://www.npmjs.com/package/eslint)
* [babel-eslint](https://www.npmjs.com/package/babel-eslint)
* [eslint-plugin-react](https://www.npmjs.com/package/eslint-plugin-react)

```shell
npm install --save-dev eslint babel-eslint eslint-plugin-react
``` 





## Directory Structure


```markup
.
+-- src
|   +-- actions
|       +-- index.js
|   +-- components
|       +-- index.js
|   +-- constants
|       +-- ActionTypes.js
|   +-- containers
|       +-- App.js
|       +-- FriendListApp.js
|   +-- reducers
|       +-- index.js
|       +-- friendlist.js
|   +-- utils
|   +-- index.js
+-- index.html
+-- app.css

```




components 






## Installed Libraries

## How / Why?

The following packages have been installed:

- Redux: The library itself
- React-redux: The bindings to React for Redux
- Redux-devtools: Development tools for Redux



```bash
npm install --save redux react-redux
npm install --save-dev redux-devtools
```




### History of Steps taken (If re-creating kit from scratch)

```bash
npm install --save redux react-redux
npm install --save-dev redux-devtools
npm install --save css-loader cssnext-loader extract-text-webpack-plugins

```



- for styles css you need to use extract-text-webpack-plugins and modifiy config file
- add devTools -- redux-devtools to store_enhancers/


- create constants/ folder for all action types
