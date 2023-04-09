from locust import HttpUser, task, between

class GlamEcom(HttpUser):
    wait_time = between(1, 3)

    @task
    def login(self):
        response = self.client.post("http://glam-server-production-terraform.eba-djmd22j3.ap-southeast-1.elasticbeanstalk.com/api/signin", 
                                    {"username": "jeral.ong.2020@scis.smu.edu.sg", "password": "your_password"})
        if response.status_code == 200:
            self.client.get("/dashboard")
        else:
            self.client.get("/")
            
    @task
    def logout(self):
        self.client.get("/logout")

    @task
    def categories(self):
        self.client.get("/api/category/all-category")

    @task
    def on_start(self):
        self.client.get("/")

    @task
    def view_product(self):
        self.client.get("/products/642bc660deafd2001e315b92")

    @task
    def checkout(self):
        self.client.get("/checkout")
