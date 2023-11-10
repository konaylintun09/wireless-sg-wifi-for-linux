FROM python:3
RUN pip3 install pycryptodome requests
COPY Naungsai.py /
ENTRYPOINT ["python3", "Naungsai.py"]
