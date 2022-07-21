import pyqrcode
from flask import request, make_response, jsonify
from flask_restful import Resource
from flask import send_file

# <------------using blue print method --------------->
# from flask import Blueprint
# module = Blueprint('module',__name__)
# @module.route("",method="GET")
# def qrcode(data):
#     # String which represents the QR code
#     s = data
#
#     # Generate QR code
#     url = pyqrcode.create(s)
#
#     # Create and save the svg file naming "myqr.svg"
#     url.svg("myqr.svg", scale=8)
#     return send_file("myqr.svg", mimetype='image/gif')
#     return make_response(jsonify({'status_code':200,'status':'success',
#             'data':user_details,
#             'isShowToaster':True,'message':f"User validated successfully"}),200)


class Qrcode(Resource):
    def __init__(self):
        pass

    def post(self):
        """
        body:
        {
            "data":"text message"
        }
        :return: dict
        """
        meta_data = request.get_json()
        if isinstance(meta_data,dict):
            respon = meta_data.get('data',None)
            if respon is not None:
                qr_data = pyqrcode.create(respon)
                qr_data.svg("myqr.svg", scale=8)
                return send_file("myqr.svg", mimetype='image/gif')
        return make_response(jsonify({'message': "Invalid Post Request", 'status_code': 400}), 400)


class Test(Resource):
    def __init__(self):
        pass

    def get(self):
        """
        body:
        {
            "data":"text message"
        }
        :return: dict
        """
        return make_response(jsonify({'message': "success", 'status_code': 200}), 200)