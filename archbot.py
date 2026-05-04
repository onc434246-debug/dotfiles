import subprocess
import os
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes

TOKEN = ""  # paste your token here
ALLOWED_CHAT_ID = []

async def help(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.message.chat_id != ALLOWED_CHAT_ID:
        await update.message.reply_text("Unauthorized!")
        return
    await update.message.reply_text("""
🤖 ArchBot Commands:

📸 /screenshot - Take a screenshot
🎥 /record - Record screen for 10 seconds
📁 /sendfile <path> - Send a file to Telegram
📋 /listfiles <folder> - List files in a folder
💻 /run <command> - Run any terminal command
🔄 /reboot - Reboot PC
⛔ /shutdown - Shutdown PC
""")

async def screenshot(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.message.chat_id != ALLOWED_CHAT_ID:
        await update.message.reply_text("Unauthorized!")
        return
    subprocess.run(["grim", "/tmp/screenshot.png"])
    await update.message.reply_photo(photo=open("/tmp/screenshot.png", "rb"))

async def record(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.message.chat_id != ALLOWED_CHAT_ID:
        await update.message.reply_text("Unauthorized!")
        return
    seconds = int(context.args[0]) if context.args else 10
    await update.message.reply_text(f"Recording for {seconds} seconds...")
    proc = subprocess.Popen(["wf-recorder", "-f", "/tmp/recording.mp4", "-y"])
    import time
    time.sleep(seconds)
    proc.terminate()
    proc.wait()
    await update.message.reply_video(video=open("/tmp/recording.mp4", "rb"))
    await update.message.reply_text("Done!")

async def sendfile(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.message.chat_id != ALLOWED_CHAT_ID:
        await update.message.reply_text("Unauthorized!")
        return
    if not context.args:
        await update.message.reply_text("Usage: /sendfile <path>")
        return
    path = os.path.expanduser(" ".join(context.args))
    if not os.path.exists(path):
        await update.message.reply_text(f"File not found: {path}")
        return
    await update.message.reply_text(f"Sending {os.path.basename(path)}...")
    await update.message.reply_document(document=open(path, "rb"))

async def listfiles(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.message.chat_id != ALLOWED_CHAT_ID:
        await update.message.reply_text("Unauthorized!")
        return
    folder = os.path.expanduser(" ".join(context.args)) if context.args else "~"
    folder = os.path.expanduser(folder)
    if not os.path.exists(folder):
        await update.message.reply_text(f"Folder not found: {folder}")
        return
    files = os.listdir(folder)
    await update.message.reply_text("\n".join(files) if files else "Empty folder!")

async def run(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.message.chat_id != ALLOWED_CHAT_ID:
        await update.message.reply_text("Unauthorized!")
        return
    if not context.args:
        await update.message.reply_text("Usage: /run <command>")
        return
    command = " ".join(context.args)
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    output = result.stdout or result.stderr or "No output"
    
    # If too long, save as file and send
    if len(output) > 4000:
        with open("/tmp/output.txt", "w") as f:
            f.write(output)
        await update.message.reply_document(document=open("/tmp/output.txt", "rb"), filename="output.txt")
    else:
        await update.message.reply_text(f"$ {command}\n\n{output}")

async def shutdown(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.message.chat_id != ALLOWED_CHAT_ID:
        await update.message.reply_text("Unauthorized!")
        return
    await update.message.reply_text("Shutting down PC...")
    subprocess.run(["sudo", "shutdown", "now"])

async def reboot(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.message.chat_id != ALLOWED_CHAT_ID:
        await update.message.reply_text("Unauthorized!")
        return
    await update.message.reply_text("Rebooting PC...")
    subprocess.run(["sudo", "reboot"])

app = ApplicationBuilder().token(TOKEN).connect_timeout(30).read_timeout(30).write_timeout(30).build()
app.add_handler(CommandHandler("help", help))
app.add_handler(CommandHandler("screenshot", screenshot))
app.add_handler(CommandHandler("record", record))
app.add_handler(CommandHandler("sendfile", sendfile))
app.add_handler(CommandHandler("listfiles", listfiles))
app.add_handler(CommandHandler("run", run))
app.add_handler(CommandHandler("shutdown", shutdown))
app.add_handler(CommandHandler("reboot", reboot))

print("Bot is running...")
app.run_polling()
