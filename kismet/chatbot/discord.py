from os import getenv
from discord import Client

from kismet.core import process_markdown

token = getenv("DISCORD_TOKEN", "")
clientid = getenv("DISCORD_CLIENTID", "0")
permissions = getenv("DISCORD_PERMISSIONS", "8192")

oauth2_template = (
    "https://discordapp.com/oauth2/authorize?client_id=%s&scope=bot&permissions=%s"
)
oauth2_url = oauth2_template % (clientid, permissions)
print("Use the following URL to invite:")
print(oauth2_url)


# Define client
client = Client()


@client.event
async def on_message(message):
    if message.author == client.user:
        return
    else:
        parsed, emoted = process_markdown(message.content)
        if parsed:
            await client.send_message(
                message.channel, "{0.author.mention}\n".format(message) + parsed
            )
        if emoted:
            await client.send_message(message.channel, emoted)


@client.event
async def on_ready():
    print("Logged in as")
    print(client.user.name)
    print(client.user.id)
    print("------")


client.run(token)