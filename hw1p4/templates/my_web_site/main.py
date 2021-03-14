from flask import Flask, request, make_response, redirect, abort, render_template, jsonify
from flask_json import FlaskJSON, JsonError, json_response, as_json
import random

app = Flask(__name__)
app.debug = True

userNames = ["Jenia", "Anantily", "Petr", "Sava"]
age = [5, 6, 7, 8]
profession = ["ss", "dd", "ff", "gg"]


@app.route('/')
def index():
    return 'Hello World'


@app.route('/404/')
def http_404():
    abort(404)


@app.errorhandler(404)
def http_404_handler(error):
    return render_template('404.html'), 404


@app.errorhandler(500)
def http_500_handler():
    return "<h2 style='text-align: center;'>500 Error</h2>", 500


@app.route('/about/')
def feedback():
    return render_template('about.html')


@app.route('/user/<int:id>/')
def user_profile(id):
    template_context = dict(
        name=userNames[id], age=age[id], profession=profession[id])
    return render_template('index.html', **template_context)


@app.route('/myIp/')
def requestdata():
    return "Hello! Your IP is {} and you are using {}: ".format(request.remote_addr, request.user_agent)


# =========================================
# ============== Home Work ================

FlaskJSON(app)


@app.route('/increment_value', methods=['POST'])
def increment_value():
    # We use 'force' to skip mimetype checking to have shorter curl command.
    data = request.get_json(force=True)
    try:
        word = str(data['word'])
        count = int(data['count'])
    except (KeyError, TypeError, ValueError):
        raise JsonError(description='Invalid value.')
    return emojiDecorator(word, count)


def emojiDecorator(word, count):
    emoliList = ["🔥", "🛑", "❗", "ℹ️", "🔘",
                 "✅", "❗", "ℹ️", "⚠️", "❌",
                 "💣", "🔥", "💩", "👍", "🥶",
                 "🥴", "🥳", "😈", "🤡", "💝"]
    res = ""
    emoliN = random.randrange(len(emoliList))
    for number in range(0, count):
        res = res + word + emoliList[emoliN]
    res = res + "\n"
    return res


if __name__ == "__main__":
    app.run()
