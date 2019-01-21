from sys import exit
from prompt_toolkit import PromptSession

from kismet.parser import KismetParser

print("Greetings, human! I am Kismet <3")
print("Input a roll and press ENTER.")

# Create parser object.
parser = KismetParser()
# Create prompt object.
session = PromptSession("> ")

while True:
    try:
        text = session.prompt()
        print(parser.parse(text))
    except EOFError:
        exit(0)
    except KeyboardInterrupt:
        exit(130)
