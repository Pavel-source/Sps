import datetime

import base64
import hashlib
import hmac
import json
import requests

GMT_FORMAT = '%a, %d %b %Y %H:%M:%S GMT'


def getSimpleSign(source, SecretId, SecretKey):
    dateTime = datetime.datetime.utcnow().strftime(GMT_FORMAT)
    auth = "hmac id=\"" + SecretId + "\", algorithm=\"hmac-sha1\", headers=\"date source\", signature=\""
    signStr = "date: " + dateTime + "\n" + "source: " + source
    sign = hmac.new(SecretKey.encode(), signStr.encode(), hashlib.sha1).digest()
    sign = base64.b64encode(sign).decode()
    sign = auth + sign + "\""
    return sign, dateTime


def callAPI():
    # SecretId = 'AKIDaVViFR1vd5Mc00km5acmZ98B3ob77zXWN5eG'  # 密钥对的 SecretId
    # SecretKey = '1X4MS34gaLH2pF999gvw49iBAOFTUF9ZVHe5zb7G'  # 密钥对的 SecretKey
    SecretId = 'AKIDi1RjfRV974596g3ZBm3kjqmT2Rdnkxim1X0Y'
    SecretKey = 'IKLrSk6vH1i4yASoUgU2IbVD72fASxeUDwFR71le'  # 密钥对的 SecretKey

    header = {'Host': 'service-f1zxjxsx-1316447658.sh.apigw.tencentcs.com',  # 用户 API 所在服务的域名
     'Content-Type': 'application/json'
     }
    Source = 'xxxxxx'  # 签名水印值，可填写任意值  "Signature watermark value, any value can be filled in"
    sign, dateTime = getSimpleSign(Source, SecretId, SecretKey)
    header['Authorization'] = sign
    header['Date'] = dateTime
    header['Source'] = Source

    # url = 'https://service-f1zxjxsx-1316447658.sh.apigw.tencentcs.com/api/cde/manager/global/setCdeUserStatus'
    # url = 'https://service-bamhhx1n-1316447658.sh.apigw.tencentcs.com/api/cde/manager/global/setCdeUserStatus'
    url = 'https://cde-api-proxy.cfainstitutecn.com/api/cde/manager/global/setCdeUserStatus'

#     params = { "param": [{"cfa_user_current_registration_level": None, "cfa_user_current_registration_date": None,    "cde_user_id": 100000000,    "cfa_vendor_id": "100004",    "cfa_person_id": "10002",    "visitor_segment": "public",    "cfa_highest_level_passed": "Level I",    "cfa_user_status_change_timestamp": "2023-10-13 10:12:23",    "cfa_user_journey_status": "public",    "cde_user_delete": 0},{    "cde_user_id": 100000001,    "cfa_vendor_id": "100005",    "cfa_person_id": "10002",    "visitor_segment": "public",    "cfa_highest_level_passed": "Level I",    "cfa_user_status_change_timestamp": "2023-10-13 10:12:23",    "cfa_user_journey_status": "public",    "cde_user_delete": 0},{    "cde_user_id": 100000002,    "cfa_vendor_id": "100006",    "cfa_person_id": "10003",    "visitor_segment": "public",    "cfa_highest_level_passed": "Level I",    "cfa_user_status_change_timestamp": "2023-10-13 10:12:23",    "cfa_user_journey_status": "public",    "cde_user_delete": 0},{    "cde_user_id": 100000003,    "cfa_vendor_id": "100007",    "cfa_person_id": "10004",    "visitor_segment": "public",    "cfa_highest_level_passed": "Level I",    "cfa_user_status_change_timestamp": "2023-10-13 10:12:23",    "cfa_user_journey_status": "public",    "cde_user_delete": 0}     ],
#         "consumer_id":"REFUQWJtUlRTRmhaYXpCaldtNUJPR2g0VmpSRFJEbDBSMDB6YzBKVFVqZG1WR3hJZG5KdA",
#      "consumer_key": "REFUQWNabkE4aHhWNENEOXRHTTNzQlNSN2ZUbEh2cm0"
# }

    params = {"param": [{"cfa_user_current_registration_level": None, "cfa_user_current_registration_date": None,
                         "cde_user_id": 100000000, "cfa_vendor_id": "100004", "cfa_person_id": "10002",
                         "visitor_segment": "public", "cfa_highest_level_passed": "Level I",
                         "cfa_user_status_change_timestamp": "2023-10-13 10:12:23", "cfa_user_journey_status": "public",
                         "cde_user_delete": 0},
                        {"cde_user_id": 100000001, "cfa_vendor_id": "100005", "cfa_person_id": "10002",
                         "visitor_segment": "public", "cfa_highest_level_passed": "Level I",
                         "cfa_user_status_change_timestamp": "2023-10-13 10:12:23", "cfa_user_journey_status": "public",
                         "cde_user_delete": 0},
                        {"cde_user_id": 100000002, "cfa_vendor_id": "100006", "cfa_person_id": "10003",
                         "visitor_segment": "public", "cfa_highest_level_passed": "Level I",
                         "cfa_user_status_change_timestamp": "2023-10-13 10:12:23", "cfa_user_journey_status": "public",
                         "cde_user_delete": 0},
                        {"cde_user_id": 100000003, "cfa_vendor_id": "100007", "cfa_person_id": "10004",
                         "visitor_segment": "public", "cfa_highest_level_passed": "Level I",
                         "cfa_user_status_change_timestamp": "2023-10-13 10:12:23", "cfa_user_journey_status": "public",
                         "cde_user_delete": 0}],
              "consumer_id": "REFUQWJtUlRTRmhaYXpCaldtNUJPR2g0VmpSRFJEbDBSMDB6YzBKVFVqZG1WR3hJZG5KdA",
              "consumer_key": "REFUQWNabkE4aHhWNENEOXRHTTNzQlNSN2ZUbEh2cm0"
              }

    r1 = requests.post(url, data=json.dumps(params), headers=header)

    print(r1.status_code)
    print(r1.content.decode("unicode_escape"))

    return r1.status_code

callAPI()

