FROM python:3.6

RUN pip install kismet

ENTRYPOINT python -m kismet
