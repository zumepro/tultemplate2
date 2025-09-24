#let todos = state("todos", "0");
#let is_prod = state("is_prod", "false");

#let profile(profile) = {
  let profiles = ("debug", "release");
  if profile not in profiles {
    panic(
      "unknown profile '" + profile +
      "', expected one of: " + profiles.map((v) => { "'" + v + "'" }).join(", ")
    )
  }
  context {
    is_prod.update(is_prod => {
      if eval(is_prod) and profile == "debug" {
        panic("refusing to unset release profile - this is a safety measure");
      }
      if profile == "release" { "true" } else { "false" };
    });
  }
}

#let assert_release_ready() = {
  context {
    if not eval(is_prod.final()) {
      return;
    }
    let todos = eval(todos.final());
    if todos > 0 {
      let panic_message = ("refusing to build for release - " + str(todos) + " " +
        if todos == 1 { "todo" } else { "todos" } + " remaining");
      panic(panic_message);
    }
  }
}

#let todo(content, do_highlight: true) = {
  context {
    todos.update(todos => {
      str(eval(todos) + 1)
    });
  }
  if do_highlight {
    highlight(text(content, fill: white), fill: red, radius: .25em, extent: .25em);
  } else {
    text(content);
  }
}
