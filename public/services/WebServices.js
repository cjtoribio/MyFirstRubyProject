PostsApp.factory('PostService', ['$http', '$location', function ($http, $location) {
    var turl = /^\w*:\/\/[^/]*\//.exec($location.absUrl())[0];
    return {
        url: turl + 'ws/posts',        
        createGet: function(method){
            return $http.get(this.url + '/' + method, { headers: { 'Content-type': 'application/json' },  data: {} });
        },
        GetPostById: function (id, callback) {
            this.createGet("id/" + id)
            .success(function (data, status) {
                if (status != 200) return callback([]);
                callback(data);
            })
            .error(function(){
            	callback(null);
            })
        },
        GetPostByTag: function (tag, callback) {
            this.createGet("tag/" + tag)
            .success(function (data, status) {
                if (status != 200) return callback([]);
                callback(data);
            })
            .error(function(){
            	callback(null);
            })
        },
        GetPostByAuthor: function (author, callback) {
            this.createGet("author/" + author)
            .success(function (data, status) {
                if (status != 200) return callback([]);
                callback(data);
            })
            .error(function(){
            	callback(null);
            })
        },
        GetAllPosts: function (callback) {
            this.createGet("")
            .success(function (data, status) {
                if (status != 200) return callback([]);
                callback(data);
            })
            .error(function(){
            	callback(null);
            })
        }
    };
}]);
PostsApp.factory('TagService', ['$http', '$location', function ($http, $location) {
    var turl = /^\w*:\/\/[^/]*\//.exec($location.absUrl())[0];
    return {
        url: turl + 'ws/tags',        
        createGet: function(method){
            return $http.get(this.url + '/' + method, { headers: { 'Content-type': 'application/json' },  data: {} });
        },
        GetAllTags: function (callback) {
            this.createGet("")
            .success(function (data, status) {
                if (status != 200) return callback([]);
                callback(data);
            })
            .error(function(){
            	callback(null);
            })
        }
    };
}]);