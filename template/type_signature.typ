#let doc(inner, argument_name, explanation) = {
  inner.doc = (argname: argument_name, expl: explanation);
  inner
}

#let type_primitive(id, name) = {
  (type: "primitive", type_id: id, type_name: name)
}

#let int = type_primitive("integer", "an 'integer'");
#let float = type_primitive("float", "a 'float'");
#let bool = type_primitive("boolean", "a 'boolean'");
#let string = type_primitive("string", "a 'string'");
#let content = type_primitive("content", "a 'content'");

#let literal(value) = {
  (type: "literal", value: value)
}

#let variants(..variants) = {
  (type: "variants", variants: variants.pos())
}

#let list(items) = {
  (type: "list", items: items)
}

#let tuple(..items) = {
  (type: "tuple", items: items.pos())
}

#let keyval(key, val) = {
  (type: "keyval", key: key, val: val)
}

#let dict(keyval) = {
  (type: "dictionary", key: keyval.key, val: keyval.val)
}

#let struct(..keyvals) = {
  let keyvals = keyvals.pos();
  let res = ().to-dict();
  for keyval in keyvals {
    if keyval.key.type != "literal" {
      panic("invalid type signature, struct keys must be literals");
    }
    res.insert(keyval.key.value, keyval.val);
  }
  (type: "struct", pairs: res)
}

#let signature_check(value, signature, name_prefix) = {
  let error_target_name(target, name_prefix) = {
    name_prefix + if "doc" in target { " ('" + target.doc.argname + "')" } else { "" }
  }

  let error_value_name(value) = {
    str(type(value))
  }

  let dbg_literal(literal) = {
    if type(literal) == str {
      "\"" + literal + "\""
    } else {
      "'" + str(literal) + "'"
    }
  }

  let error_expected_type(target) = {
    if target.type == "variants" {
      let variants = target.variants;
      let last = variants.pop();
      let res = (variants.map((v) => { error_expected_type(v) })).join(", ");
      if type(last) != type(none) {
        if type(res) != type(none) {
          res + " or " + error_expected_type(last)
        } else {
          error_expected_type(last)
        }
      } else {
        res
      }
    } else if target.type == "list" or target.type == "tuple" {
      "an array"
    } else if target.type == "dictionary" or target.type == "struct" {
      "a dictionary/hashmap"
    } else if target.type == "primitive" {
      target.type_name
    } else if target.type == "literal" {
      dbg_literal(target.value)
    } else {
      panic();
    }
  }

  let error(target, name_prefix, value, is_value: false) = {
    error_target_name(target, name_prefix) + " " + if is_value {
      "is unexpected"
    } else {
      "has an unexpected type '" + error_value_name(value) + "'"
    } + ", expected " + error_expected_type(target)
  }

  let in_variants(value, variants, matcher) = {
    for variant in variants {
      if matcher(value, variant).at(0) == true {
        return true;
      }
    }
    false
  }

  let matches_type(value, target, name_prefix: "") = {
    if target.type == "variants" {
      return if in_variants(value, target.variants, matches_type.with(name_prefix: name_prefix)) {
        (true,)
      } else {
        (false, error(target, name_prefix, value, is_value: true))
      }
    } else if target.type == "literal" {
      return if value != target.value {
        (false, error(target, name_prefix, value, is_value: true))
      } else {
        (true,)
      }
    }
    if type(value) == dictionary {
      if target.type == "struct" {
        for key in target.pairs.keys() {
          if key not in value {
            return (false, name_prefix + " is missing an entry for key " + dbg_literal(key));
          }
        }
        for (key, val) in value.pairs() {
          if key not in target.pairs {
            return (
              false, name_prefix + " contains an unexpected key " + dbg_literal(key)
            );
          }
          matches_type(val, target.pairs.at(key), name_prefix: name_prefix + " " + str(key))
        }
      } else if target.type == "dictionary" {
        for (key, val) in value.pairs() {
          let cur = matches_type(key, target.key, name_prefix: name_prefix + " key");
          if not cur.at(0) {
            return cur;
          }
          let cur = matches_type(val, target.val, name_prefix: name_prefix + " value");
          if not cur.at(0) {
            return cur;
          }
        }
        (true,)
      } else {
        (false, error(target, name_prefix, value))
      }
    } else if type(value) == array {
      if target.type == "list" {
        for (idx, val) in value.enumerate() {
          let cur = matches_type(
            val, target.items, name_prefix: name_prefix + " item at index " + str(idx)
          );
          if not cur.at(0) {
            return cur;
          }
        }
        (true,)
      } else if target.type == "tuple" {
        for (idx, target) in target.items.enumerate() {
          if idx >= value.len() {
            return (false, name_prefix + " is missing an item: " + error_expected_type(target))
          }
          let cur = matches_type(
            value.at(idx), target, name_prefix: name_prefix + " item at index " + str(idx)
          );
          if not cur.at(0) {
            return cur;
          }
        }
        (true,)
      } else {
        (false, error(target, name_prefix, value))
      }
    } else {
      if target.type != "primitive" or str(type(value)) != target.type_id {
        (false, error(target, name_prefix, value))
      } else {
        (true,)
      }
    }
  }

  matches_type(value, signature, name_prefix: name_prefix)
}
