from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
<<<<<<< HEAD
    return "Hello, mahn!How are youuuuuuu......................"
=======
    return "Hello, mahn!How are youuuuuuuuuuuu.................."
>>>>>>> d9baece (ci/cd edit)

if __name__ == "__main__":
    app.run(debug=True)

