#import "utils.typ": assert_in_dict

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

#let disclaimer(language, document_type, author_gender) = {
  let disclaimer = get_lang_item(language, "disclaimer_content");
  let replacements = get_lang_item(language, "disclaimer_replace").at(document_type);
  if language == "cs" {
    let gender_transforms = (
      male: "",
      female: "a",
    );
    assert_in_dict(author_gender, gender_transforms, "author gender");
    disclaimer = disclaimer.replace("{a}", gender_transforms.at(author_gender));
  }
  for (key, value) in replacements.pairs() {
    disclaimer = disclaimer.replace("{" + key + "}", value);
  }
  if disclaimer.contains("{") or disclaimer.contains("}") {
    panic("invalid language file");
  }
  disclaimer
}
