#import "lang.typ": lang_id
#import "utils.typ": assert_in_dict

#let faculty_themes = (

    fs: (
      rgb("#000000"),
      (
        "FAKULTA STROJNÍ TUL&",
        "FACULTY OF MECHANICAL ENGINEERING TUL&"
      ),
    ),

    ft: (
      rgb("#924c14"),
      (
        "FAKULTA TEXTILNÍ TUL&",
        "FACULTY OF TEXTILE ENGINEERING TUL&",
      ),
    ),

    fp: (
      rgb("#3c84e1"),
      (
        "FAKULTA\nPŘÍRODOVĚDNĚ-HUMANITNÍ\nA PEDAGOGICKÁ TUL&",
        "FACULTY OF SCIENCE,\nHUMANITIES AND\nEDUCATION TUL&",
      ),
    ),

    ef: (
      rgb("#65a812"),
      (
        "EKONOMICKÁ FAKULTA TUL&",
        "FACULTY OF ECONOMICS TUL&",
      ),
    ),

    fua: (
      rgb("#006443"),
      (
        "FUA\nTUL&",
        "FAA\nTUL&",
      ),
    ),

    fm: (
      rgb("#ea7603"),
      (
        "FAKULTA MECHATRONIKY,\nINFORMATIKY A MEZIOBOROVÝCH\nSTUDIÍ TUL&",
        "FACULTY OF MECHATRONICS,\nINFORMATICS AND\nINTERDISCIPLINARY STUDIES TUL&",
      ),
    ),

    fzs: (
      rgb("#00b0be"),
      (
        "FAKULTA ZDRAVOTNICKÝCH STUDIÍ TUL&",
        "FACULTY OF HEALTH STUDIES TUL&",
      ),
    ),

);

#let faculty_theme(faculty_id) = {
  assert_in_dict(faculty_id, faculty_themes, "faculty abbreviation");
  return faculty_themes.at(faculty_id)
}

#let faculty_color(faculty_id) = {
  let theme = faculty_theme(faculty_id);
  let theme_color = theme.at(0);
  assert(type(theme_color) == color);
  return theme_color;
}

#let faculty_logotype_text(faculty_id, lang) = {
  let theme = faculty_theme(faculty_id);
  let logotype_text = theme.at(1).at(lang_id(lang));
  assert(type(logotype_text) == str);
  return logotype_text;
}

#let faculty_logotype(faculty_id, lang) = {
  let theme_color = faculty_color(faculty_id);
  let logotype_text = faculty_logotype_text(faculty_id, lang);
  text(logotype_text, font: "TUL Mono", theme_color, weight: "black");
}

#let tul_logomark(faculty_id) = {
  let theme_color = faculty_color(faculty_id);
  let image_raw = bytes(read("./assets/tul_logo.svg").replace("black", theme_color.to-hex()));
  image(image_raw, fit: "contain")
}
