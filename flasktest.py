from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():

    return "Hello, mahn!How are youuuuuuuuuuuuuu,are you happpy......."

if __name__ == "__main__":
    app.run(debug=True)

