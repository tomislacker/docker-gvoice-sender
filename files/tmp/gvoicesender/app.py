#!/usr/bin/env python

from config import *
from runconfig import *

from flask import request, url_for
from flask.ext.api import FlaskAPI, status, exceptions

from googlevoice import Voice
from googlevoice.util import input

app = FlaskAPI(__name__)

@app.route('/', methods=['GET'])
def listOperations():
  return {
    'operations': {
      { 'method': 'GET', 'url': url_for('sendMessage') }
    }
  }

@app.route('/msg', methods=['PUT'])
def sendMessage():
  # Sanitizing input
  sendTo = request.form.get('to', type=int)
  sendMsg = request.form.get('msg', type=str)

  if not sendTo:
    return {
      'err': 'No "to" field provided'
    }
  elif not sendMsg:
    return {
      'err': 'No "msg" field provided'
    }

  # Connect to Google Voice
  voice = Voice()
  voice.login(email=GV_EMAIL, passwd=GV_PASSWD)

  # Attempt sending the message
  voice.send_sms(sendTo, sendMsg)
  
  return {
    'success': 'Message sent to ' + str(sendTo)
  }

if __name__ == "__main__":
  app.run(host=GVSENDER_LISTEN, debug=DEBUG)
