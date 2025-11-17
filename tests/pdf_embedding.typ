#import "../template/pdf.typ": number_of_pages, embed_full

#let pdfinfo(src, target_pagecount) = {
  let pdf = read(src, encoding: none);
  let pagecount = number_of_pages(pdf);
  [
    = #src
    Pagecount: #pagecount
  ];
  place(bottom + right, [Starting on next page]);
  assert(pagecount == target_pagecount);
  embed_full(pdf);
}

#pdfinfo("./pdf_embedding_01.pdf", 1)
#pdfinfo("./pdf_embedding_02.pdf", 2)
#pdfinfo("./pdf_embedding_03.pdf", 1)
