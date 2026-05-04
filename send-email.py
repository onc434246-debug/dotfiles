import smtplib
import os
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders

# Your Gmail settings
SENDER = ""
PASSWORD = ""

recipient = input("Send to: ")
subject = input("Subject: ")
body = input("Message: ")

msg = MIMEMultipart()
msg["From"] = SENDER
msg["To"] = recipient
msg["Subject"] = subject
msg.attach(MIMEText(body, "plain"))

print("Enter attachment paths one by one.")
print("Leave blank and press Enter when done.")

while True:
    attachment_path = input("Attachment: ").strip()
    
    if attachment_path == "":
        break
    attachment_path = os.path.expanduser(attachment_path)
    if not os.path.exists(attachment_path):
        print(f"File not found: {attachment_path}, skipping...")
        continue

    with open(attachment_path, "rb") as f:
        part = MIMEBase("application", "octet-stream")
        part.set_payload(f.read())
        encoders.encode_base64(part)
        part.add_header("Content-Disposition", f"attachment; filename={os.path.basename(attachment_path)}")
        msg.attach(part)
        print(f"Attached: {attachment_path}")

with smtplib.SMTP_SSL("smtp.gmail.com", 465) as server:
    server.login(SENDER, PASSWORD)
    server.sendmail(SENDER, recipient, msg.as_string())

print("Email sent!")
