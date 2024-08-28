# Use Python 3.11 as the base image
FROM python:3.11

# Set the working directory within the container
WORKDIR /app/web-app

# Copy the requirements.txt file to the container
COPY requirements.txt /app/web-app

# Install dependencies using pip
RUN pip install -r requirements.txt

# Copy the application to the container
COPY . /app/test-app

# Expose port 8000
EXPOSE 8000

# Apply migrations to set up the database (SQLite)
RUN python manage.py migrate

# Run the Django application
CMD python /app/web-app/manage.py runserver 0.0.0.0:8000