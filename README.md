## Depends

Easily calculate reliable load orders between objects

---

### Basic Usage

    class Thing
      include Dependable
    end

### Describing Dependence

    thing1 = Thing.new
    thing2 = Thing.new

    thing2.needs thing1

### Generate a proper loading order

    thing2.load_path # => [thing1, thing2]

### Testing Dependence

    thing2.dependent_on?(thing1) # true
    thing1.dependent_on?(thing2) # false

---

### Coming Soon

Ability to return dependency load paths as trees that are collapsed as far as they can be.

    A needs B, D
    B needs C

would be:

    - D
    - C
    --- B
    ----- A

The benefit here being that loaders could start down multiple paths without having to wait.

---

### License

(The MIT License)

Copyright © 2010 John Crepezzi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
