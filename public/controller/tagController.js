PostsApp.controller('TagController', function ($scope, TagService) {
	TagService.GetAllTags(function(data){
		$scope.tags = new Array();
		for(k in data){
			$scope.tags.push({ "tagName" : k , "popularity" : data[k] });
		}
	});
});