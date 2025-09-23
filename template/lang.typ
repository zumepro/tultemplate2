#import "utils.typ": assert_in_dict

#let lang_ids = (
  cs: 0,
  en: 1,
);

#let lang_id(lang_abbr) = {
  assert_in_dict(lang_abbr, lang_ids, "language abbreviation");
  return lang_ids.at(lang_abbr);
};
