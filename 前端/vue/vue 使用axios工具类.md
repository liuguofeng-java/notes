## vue 使用axios工具类.m

```javascript
import axios from 'axios'
import Qs from 'qs'


axios.defaults.timeout = 10000;
axios.defaults.baseURL = '/api';
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';


/**
 * 封装get方法
 * @param url
 * @param data
 * @returns {Promise}
 */

export function get(url, params = {}) {
    return new Promise((resolve, reject) => {
        ajax(url, params, 'get')
            .then((res) => {
                resolve(res);
            })
            .catch((error) => {
                reject(error);
            })
    })
}


/**
 * 封装post请求
 * @param url
 * @param data
 * @returns {Promise}
 */

export function post(url, params = {}) {
    return new Promise((resolve, reject) => {
        ajax(url, params, 'post')
            .then((res) => {
                resolve(res);
            })
            .catch((error) => {
                reject(error);
            })
    })
}

let ajax = (url, params = {}, method) => {
    return new Promise((resolve, reject) => {
        axios({
            method: method,
            url: url,
            data: Qs.stringify(params)
        })
            .then((res) => {
                resolve(res);
            })
            .catch((error) => {
                reject(error);
            })
    });
}

/**
 * 
 * @param {错误信息} err 
 */
function getError(err) {
    if (err && err.response) {
        switch (err.response.status) {
            case 400:
                err.message = '请求错误(400)';
                break;
            case 401:
                err.message = '未授权，请重新登录(401)';
                break;
            case 403:
                err.message = '拒绝访问(403)';
                break;
            case 404:
                err.message = '请求出错(404)';
                break;
            case 408:
                err.message = '请求超时(408)';
                break;
            case 500:
                err.message = '服务器错误(500)';
                break;
            case 501:
                err.message = '服务未实现(501)';
                break;
            case 502:
                err.message = '网络错误(502)';
                break;
            case 503:
                err.message = '服务不可用(503)';
                break;
            case 504:
                err.message = '网络超时(504)';
                break;
            case 505:
                err.message = 'HTTP版本不受支持(505)';
                break;
            default:
                err.message = `连接出错(${err.response.status})!`;
        }
    } else {
        err.message = '连接服务器失败!'
    }
    return err.message;
}

```

