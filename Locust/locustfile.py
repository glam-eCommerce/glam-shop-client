from locust import HttpUser, task

class HelloWorldUser(HttpUser):
    @task
    def on_start(self):
        self.client.get("/")
