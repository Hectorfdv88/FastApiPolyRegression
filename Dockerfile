# Usar una imagen base de Python oficial. La etiqueta "slim" es una versión reducida que contiene
# las dependencias mínimas necesarias.
FROM python:3.9-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos requeridos al contenedor. Asumimos que tienes un archivo "requirements.txt"
# y tu script de aplicación (app.py) en el mismo directorio que este Dockerfile.
# También asumimos que el modelo de ML ya está entrenado y guardado como "model.pkl".
COPY requirements.txt .
COPY main.py .
COPY model/poly_model.pkl /app/model/poly_model.pkl
COPY model/poly_transformer.pkl /app/model/poly_transformer.pkl

# Instalar las dependencias de Python especificadas en "requirements.txt"
RUN pip install --no-cache-dir -r requirements.txt

# Exponer el puerto en el que FastAPI se ejecutará
EXPOSE 80

# Comando para ejecutar la aplicación FastAPI usando Uvicorn como servidor ASGI. Ajusta "app:app"
# si tu archivo de aplicación o instancia de FastAPI se nombran de manera diferente.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
