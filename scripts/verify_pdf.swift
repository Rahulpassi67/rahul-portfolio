import AppKit
import PDFKit

let path = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "assets/Rahul_Passi_Portfolio.pdf"
guard let doc = PDFDocument(url: URL(fileURLWithPath: path)) else { fatalError("Could not open PDF at \(path)") }
var links: [String] = []
for index in 0..<doc.pageCount {
    guard let page = doc.page(at: index) else { continue }
    for annotation in page.annotations {
        if let action = annotation.action as? PDFActionURL, let url = action.url { links.append(url.absoluteString) }
    }
    let image = page.thumbnail(of: CGSize(width: 595, height: 842), for: .mediaBox)
    if let data = image.tiffRepresentation, let bitmap = NSBitmapImageRep(data: data),
       let png = bitmap.representation(using: .png, properties: [:]) {
        try png.write(to: URL(fileURLWithPath: "/tmp/rahul_portfolio_page_\(index + 1).png"))
    }
}
guard doc.pageCount == 3 else { fatalError("Expected 3 pages, found \(doc.pageCount)") }
guard links.count >= 6 else { fatalError("Expected clickable project/contact links, found \(links.count)") }
guard links.contains(where: { $0.contains("ai-link-analysis-6uk8.onrender.com") }), links.contains(where: { $0.contains("mailto:") }) else { fatalError("Expected demo and email links") }
print("PDF verified: \(doc.pageCount) pages, \(links.count) clickable links")
