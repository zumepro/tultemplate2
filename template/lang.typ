#import "utils.typ": assert_in_dict, assert_in_arr

#let lang_ids = (
  cs: 0,
  en: 1,
);

#let lang_id(lang_abbr) = {
  assert_in_dict(lang_abbr, lang_ids, "language abbreviation");
  return lang_ids.at(lang_abbr);
};

// Typst will usually cache this - so we don't have to re-read the file each time
#let fetch_lang_items() = {
  return json("lang.json");
}

#let get_lang_item(lang_abbr, item_name) = {
  assert_in_dict(lang_abbr, lang_ids, "language abbreviation");
  let lang_items = fetch_lang_items();
  return lang_items.at(lang_abbr).at(item_name);
}

#let replace_czech_gender(raw, gender) = {
  raw.replace(regex("\{g:([^|]*)\|([^|]*)\|([^}]*)\}"), (match) => {
    if gender == "masculine" {
      match.captures.at(0)
    } else if gender == "feminine" {
      match.captures.at(1)
    } else if gender == "we" {
      match.captures.at(2)
    } else {
      panic();
    }
  });
}

#let disclaimer(language, document_type, author_gender) = {
  let disclaimer = get_lang_item(language, "disclaimer_content");
  let replacements = get_lang_item(language, "disclaimer_replace").at(document_type);
  if language == "cs" {
    let language_genders = ("feminine", "masculine", "we");
    assert_in_arr(author_gender, language_genders, "author gender");
    disclaimer = replace_czech_gender(disclaimer, author_gender);
  }
  for (key, value) in replacements.pairs() {
    disclaimer = disclaimer.replace("{" + key + "}", value);
  }
  if disclaimer.contains("{") or disclaimer.contains("}") {
    panic("invalid language file");
  }
  disclaimer
}
