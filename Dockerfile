FROM pytorch/pytorch
COPY requirements.txt requirements.txt 
RUN pip install --no-cache-dir -r requirements.txt