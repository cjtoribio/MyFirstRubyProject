PostsApp.controller('PostController', function ($scope, PostService) {
	$scope.searchCriterias = ['id' , 'tag' , 'author'];
	$scope.searchMode = "Id";
    $scope.searchBy = function(){
    	if($scope.searchMode == "Id"){
	        PostService.GetPostById($scope.searchValue, function(data){
	        	$scope.posts = data == null ? [] : [data];
	        });
    	}else if($scope.searchMode == "Tag"){
	        PostService.GetPostByTag($scope.searchValue, function(data){
	        	$scope.posts = data;
	        });
    	}else if($scope.searchMode == "Author"){
	        PostService.GetPostByAuthor($scope.searchValue, function(data){
	        	$scope.posts = data;
	        });
    	}
    };
    $scope.getAllPosts = function(){
        PostService.GetAllPosts(function(data){
        	$scope.posts = data;
        });
    }
    $scope.see = function(){
        var a = 1;
    }
});