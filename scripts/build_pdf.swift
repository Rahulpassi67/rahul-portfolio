import AppKit
import PDFKit

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let output = root.appendingPathComponent("assets/Rahul_Passi_Portfolio.pdf")
try FileManager.default.createDirectory(at: output.deletingLastPathComponent(), withIntermediateDirectories: true)
let pageSize = CGSize(width: 595, height: 842)
let pdf = PDFDocument()
var pendingLinks: [PDFAnnotation] = []

let bg = NSColor(calibratedRed: 0.031, green: 0.039, blue: 0.071, alpha: 1)
let panel = NSColor(calibratedRed: 0.065, green: 0.078, blue: 0.125, alpha: 1)
let text = NSColor(calibratedRed: 0.94, green: 0.95, blue: 0.98, alpha: 1)
let muted = NSColor(calibratedRed: 0.61, green: 0.64, blue: 0.72, alpha: 1)
let blue = NSColor(calibratedRed: 0.46, green: 0.57, blue: 1, alpha: 1)
let purple = NSColor(calibratedRed: 0.68, green: 0.48, blue: 1, alpha: 1)
let lineColor = NSColor(calibratedRed: 0.25, green: 0.29, blue: 0.41, alpha: 0.7)

func draw(_ value: String, x: CGFloat, y: CGFloat, size: CGFloat, color: NSColor = text, weight: NSFont.Weight = .regular, mono: Bool = false, tracking: CGFloat = 0, width: CGFloat = 500) {
    let font = mono ? NSFont.monospacedSystemFont(ofSize: size, weight: weight) : NSFont.systemFont(ofSize: size, weight: weight)
    let style = NSMutableParagraphStyle(); style.lineBreakMode = .byWordWrapping
    let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .paragraphStyle: style, .kern: tracking]
    let charsPerLine = max(1, Int(width / (size * 0.55)))
    let lineCount = max(1, (value.count + charsPerLine - 1) / charsPerLine)
    let boxHeight = max(size * 1.45, CGFloat(lineCount) * size * 1.45)
    (value as NSString).draw(with: CGRect(x: x, y: y, width: width, height: boxHeight), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attrs)
}
func rule(_ y: CGFloat) { lineColor.setStroke(); let p = NSBezierPath(); p.move(to: CGPoint(x: 46, y: y)); p.line(to: CGPoint(x: 549, y: y)); p.stroke() }
func label(_ value: String, _ x: CGFloat, _ y: CGFloat) { draw(value.uppercased(), x: x, y: y, size: 8, color: muted, mono: true, tracking: 1) }
func link(_ title: String, _ url: String, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat) {
    draw(title + "  ↗", x: x, y: y, size: 9, color: NSColor(calibratedRed: 0.73, green: 0.79, blue: 1, alpha: 1), weight: .semibold, width: width)
    let ann = PDFAnnotation(bounds: CGRect(x: x, y: y - 2, width: width, height: 18), forType: .link, withProperties: nil)
    ann.action = PDFActionURL(url: URL(string: url)!)
    pendingLinks.append(ann)
}
func addPage(_ number: Int, _ title: String, _ content: () -> Void) {
    let image = NSImage(size: pageSize)
    image.lockFocus()
    bg.setFill(); NSBezierPath(rect: CGRect(origin: .zero, size: pageSize)).fill()
    let glow = NSGradient(starting: NSColor(calibratedRed: 0.20, green: 0.22, blue: 0.68, alpha: 0.25), ending: .clear)!
    glow.draw(in: CGRect(x: 320, y: 550, width: 370, height: 340), relativeCenterPosition: NSPoint(x: 0.45, y: 0.35))
    lineColor.setStroke(); let footerRule = NSBezierPath(); footerRule.move(to: CGPoint(x: 46, y: 44)); footerRule.line(to: CGPoint(x: 549, y: 44)); footerRule.stroke()
    draw("RAHUL PASSI", x: 46, y: 20, size: 8, color: muted, mono: true, tracking: 1.2)
    draw(title.uppercased(), x: 210, y: 20, size: 8, color: muted, mono: true, tracking: 1.1)
    draw(String(format: "%02d", number), x: 530, y: 20, size: 8, color: blue, mono: true, tracking: 0.5)
    content()
    image.unlockFocus()
    let page = PDFPage(image: image)!
    for annotation in pendingLinks { page.addAnnotation(annotation) }
    pendingLinks.removeAll()
    pdf.insert(page, at: pdf.pageCount)
}

// Page 1 — profile, education and skills
addPage(1, "Profile") {
draw("PORTFOLIO · 2026", x: 48, y: 753, size: 9, color: blue, mono: true, tracking: 1.3)
draw("Rahul", x: 43, y: 632, size: 76, weight: .bold, tracking: -5)
draw("Passi.", x: 43, y: 550, size: 76, color: purple, weight: .bold, tracking: -5)
draw("Mathematics & Computing · AI · Software · Data", x: 49, y: 535, size: 14, color: muted, weight: .medium)
draw("Mathematics and Computing undergraduate with strong Python, algorithms and OOP foundations. I build and deploy AI-powered, API-driven applications, integrating REST and LLM APIs into working products. Keen to grow in LLM and generative AI engineering.", x: 49, y: 455, size: 11, color: text, width: 455)
label("About", 49, 425)
draw("Delhi Technological University undergraduate focused on software engineering, data and applied AI. I learn new technologies quickly and take ownership from problem definition through deployment.", x: 49, y: 343, size: 10, color: muted, width: 485)
rule(325)
label("Education", 49, 297)
draw("B.Tech, Mathematics and Computing", x: 49, y: 266, size: 13, weight: .semibold)
draw("Delhi Technological University (DTU) · 2023—2027", x: 49, y: 244, size: 10, color: muted)
draw("Coursework: Machine Learning · Algorithms · Stochastic Processes · Probability & Statistics", x: 49, y: 227, size: 7.5, color: muted)
draw("CGPA  6.41 / 10", x: 49, y: 207, size: 10, color: blue, mono: true, tracking: 0.4)
rule(191)
label("Technical Skills", 49, 162)
let skills: [(String,String)] = [
    ("PROGRAMMING / CS", "Python · Java · C++ · SQL · JavaScript · OOP · DSA · Complexity · DBMS · OS · Networks"),
    ("AI / MACHINE LEARNING", "Gemini LLM API · Sentence Transformers · Supervised Learning · Logistic Regression · Random Forest · Feature Engineering · SMOTE · ROC-AUC · Precision-Recall · Scikit-learn"),
    ("DATA / MATH", "Pandas · NumPy · EDA · Preprocessing · Matplotlib · Plotly · Probability & Statistics · Stochastic Processes · Optimization · Numerical Methods"),
    ("SOFTWARE / TOOLS", "FastAPI · REST APIs · BeautifulSoup · Bluesky / Telegram APIs · Streamlit · Git / GitHub · VS Code · Render")
]
for (index, skill) in skills.enumerated() {
    let column = index % 2
    let row = index / 2
    let x: CGFloat = column == 0 ? 49 : 305
    let y: CGFloat = row == 0 ? 139 : 80
    let bodyY: CGFloat = row == 0 ? 94 : 50
    draw(skill.0, x: x, y: y, size: 7, color: blue, mono: true, tracking: 0.4, width: 235)
    draw(skill.1, x: x, y: bodyY, size: 7.5, color: muted, width: 235)
}
}

// Page 2 — projects
addPage(2, "Projects") {
draw("Selected", x: 47, y: 735, size: 38, weight: .bold, tracking: -1.5)
draw("projects.", x: 47, y: 694, size: 38, color: purple, weight: .bold, tracking: -1.5)
draw("Software and AI tools built to make research and everyday workflows more useful.", x: 49, y: 658, size: 10, color: muted)
// Linkly panel
panel.setFill(); NSBezierPath(roundedRect: CGRect(x: 46, y: 407, width: 503, height: 218), xRadius: 9, yRadius: 9).fill()
label("01  /  AI INTELLIGENCE", 66, 594)
draw("Linkly AI", x: 66, y: 550, size: 25, weight: .bold, tracking: -0.5)
draw("AI-powered website intelligence platform", x: 66, y: 546, size: 10, color: muted)
draw("Analyzes sites for competitors, SEO, products and services, and target audiences. Gemini and Tavily APIs power AI analysis and web evidence. The FastAPI workflow handles extraction, error handling and report export; deployed on Render.", x: 66, y: 493, size: 9, color: text, width: 440)
draw("Python · FastAPI · Gemini · Tavily · HTTPX · BeautifulSoup · Sentence Transformers · Scikit-learn · HTML / CSS / JavaScript", x: 66, y: 456, size: 7.5, color: muted, width: 450)
link("Live demo", "https://ai-link-analysis-6uk8.onrender.com/", 66, 423, 100)
link("GitHub repository", "https://github.com/RahulPassi67/ai-link-analysis", 184, 423, 145)
// Dxora panel
panel.setFill(); NSBezierPath(roundedRect: CGRect(x: 46, y: 167, width: 503, height: 218), xRadius: 9, yRadius: 9).fill()
label("02  /  DEVELOPER TOOLS", 66, 354)
draw("Dxora", x: 66, y: 310, size: 25, weight: .bold, tracking: -0.5)
draw("Automated social media posting API", x: 66, y: 306, size: 10, color: muted)
draw("Automates multi-platform publishing through Bluesky and Telegram integrations, with platform-specific authentication and a tested publishing workflow. Structured to support additional platforms.", x: 66, y: 253, size: 9, color: text, width: 440)
draw("Python · FastAPI · REST APIs · Bluesky API · Telegram Bot API", x: 66, y: 216, size: 7.5, color: muted, width: 450)
link("GitHub repository", "https://github.com/Rahulpassi67/automated-posting", 66, 183, 150)
}

// Page 3 — experience and contact
addPage(3, "Experience & Contact") {
draw("Experience &", x: 47, y: 735, size: 38, weight: .bold, tracking: -1.5)
draw("leadership.", x: 47, y: 694, size: 38, color: purple, weight: .bold, tracking: -1.5)
label("Professional Experience", 49, 642)
rule(622)
draw("JUN — JUL 2026", x: 49, y: 591, size: 8, color: blue, mono: true, tracking: 0.6)
draw("Data Analyst Intern", x: 49, y: 559, size: 17, weight: .semibold)
draw("Aman Cleaning Equipments Pvt. Ltd.", x: 49, y: 536, size: 10, color: muted)
draw("Analyzed, preprocessed and statistically analyzed company datasets using SQL and Python to support business decisions. Built visualizations to present actionable insights.", x: 49, y: 502, size: 9, color: muted, width: 475)
draw("Recognized for dedication, analytical thinking, problem-solving and willingness to learn.", x: 49, y: 477, size: 9, color: muted, width: 475)
rule(452)
label("Leadership & Activities", 49, 425)
draw("2025", x: 49, y: 386, size: 8, color: blue, mono: true, tracking: 0.6)
draw("Organizing Team Head", x: 49, y: 356, size: 16, weight: .semibold)
draw("Research Carnival 2025", x: 49, y: 333, size: 10, color: muted)
draw("Led an academic event for 100+ attendees, coordinating quizzes, poster presentations and research challenges.", x: 49, y: 303, size: 9, color: text, width: 475)
rule(267)
label("Contact", 49, 237)
draw("Let’s build something useful.", x: 49, y: 201, size: 22, weight: .bold, tracking: -0.5)
draw("Delhi, India", x: 49, y: 176, size: 10, color: muted)
link("passirahul2004@gmail.com", "mailto:passirahul2004@gmail.com", 49, 141, 190)
link("+91 9871694801", "tel:+919871694801", 276, 141, 130)
link("LinkedIn", "https://www.linkedin.com/in/rahul-passi-20315427b/", 49, 113, 95)
link("GitHub", "https://github.com/Rahulpassi67", 170, 113, 80)
}
pdf.write(to: output)
print("Wrote \(output.path) (\(pdf.pageCount) pages)")
