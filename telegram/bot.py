import logging
from scripts.functionsVPN import *
import yaml

with open('config.yml', 'r') as file:
    config_file = yaml.safe_load(file)


from telegram import ReplyKeyboardMarkup, ReplyKeyboardRemove, Update
from telegram.ext import (
    Application,
    CommandHandler,
    ContextTypes,
    ConversationHandler,
    MessageHandler,
    filters,
)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Starts the conversation and asks the user about their gender."""
    reply_keyboard = [["/StartVPN", "/StopVPN", "/StatusVPN"]]

    await update.message.reply_text(
        "Hi! I am Digiboy, what can I do for you?\n\n",
        reply_markup=ReplyKeyboardMarkup(
            reply_keyboard, one_time_keyboard=True, input_field_placeholder="?"
        ),
    )

async def StartVPN_func(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Starts the conversation and asks the user about their gender."""
    await update.message.reply_text(
    "Deploying VPN... \n\n"
    "This could take a couple of minutes.⏱️"

    )
    StartVPN()
    await update.message.reply_text(
        "The VPN is ready, enjoy. 😉 \n\n"


    )
    return start

async def StopVPN_func(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Starts the conversation and asks the user about their gender."""
    await update.message.reply_text(
    "Stoping VPN...\n\n"
    )
    
    StopVPN()
    await update.message.reply_text(
        "The VPN has been stopped...\n\n"
    )
    return start

async def StatusVPN_func(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Starts the conversation and asks the user about their gender."""

    await update.message.reply_text(
        "The current status of the VPN is:\n\n"
    )
    return start



def main() -> None:
    """Run the bot."""
    # Create the Application and pass it your bot's token.
    application = Application.builder().token(config_file["telegram_token"]).build()

    # Add conversation handler with the states GENDER, PHOTO, LOCATION and BIO

    application.add_handler(CommandHandler("start", start))
    application.add_handler(CommandHandler("StartVPN", StartVPN_func))
    application.add_handler(CommandHandler("StopVPN", StopVPN_func))
    application.add_handler(CommandHandler("StatusVPN", StatusVPN_func))



    # Run the bot until the user presses Ctrl-C
    application.run_polling(allowed_updates=Update.ALL_TYPES)


if __name__ == "__main__":
    main()