FROM python:3.12-slim

RUN apt-get update && apt-get install -y make

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONPATH=/app

RUN python -m pip install --upgrade pip

RUN mkdir /app

COPY ./requirements.txt ./requirements-dev.txt /app

WORKDIR /app

RUN python -m pip install --no-cache-dir -r requirements.txt -r requirements-dev.txt

# pre download model
RUN python -c "import easyocr; easyocr.Reader(['en'])"

COPY . /app

EXPOSE 8000
CMD ["sh"]
