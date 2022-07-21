from flask import Flask
from flask_restful import Api
from module.qrcode import Qrcode, Test

app = Flask(__name__)
api = Api(app)
api.add_resource(Qrcode, '/qr_code')
api.add_resource(Test, '/testing')
# from module.qrcode import module
# app.register_blueprint(module)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=False)

    # app.run(host=host, port=int(os.environ['PORT']), debug=True, threaded=True, use_reloader=False)