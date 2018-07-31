// JavaScript Document
$(function(){
	//导航最后一个没有背景
	$(".nav li:last").css("background","none");
	//new1imgSmaill li最后一个没有margin
	$(".new1imgSmaill li:last").css("margin","0");
	//new1img 选项卡
	$(".new1imgBig img:first").show();
	$(".new1imgSmaill li").mousemove(function(){
		var new1img=$(this).index();
		$(".new1imgBig img").eq(new1img).show().siblings(".new1imgBig img").hide();
		})
	//.new1Title 选项卡
	$(".new1New:first").show();
	$(".new1Title li:first").addClass("new1Titlestyle");
	$(".new1Title li").mousemove(function(){
		$(this).addClass("new1Titlestyle").siblings("li").removeClass("new1Titlestyle");
		var new1Title=$(this).index();
		$(".new1New").eq(new1Title).show().siblings(".new1New").hide();
		})
	//新闻折叠
	$(".new1New:first .newList:first").show();
	$(".new1New:eq(1) .newList:first").show();
	$(".new1New:last .newList:first").show();
	$(".xinCont .newList:first").show();
	$(".newTitle").mouseover(function(){
		$(this).next(".newList").show().siblings(".newList").hide();
		//$(this).find("div").addClass("new1Titlestyle2").siblings("").removeClass("new1Titlestyle2");
		})
	//.new3LeftTitle li选项卡
	$(".new3LeftTitle li:last span").css("background","none");
	$(".new3LeftTitle li:first").addClass("new3LeftTitlestyle");
	$(".new3LeftBox:first").show();
	$(".new3LeftTitle li").mousemove(function(){
		$(this).addClass("new3LeftTitlestyle").siblings("li").removeClass("new3LeftTitlestyle");
		var new3LeftBox=$(this).index();
		$(".new3LeftBox").eq(new3LeftBox).show().siblings(".new3LeftBox").hide();
		})
	//footLogo
	$(".footLogo img").hover(function(){
		$(this).css({opacity:"0.7",top:"1px"});
		},function(){$(this).css({opacity:"1",top:"0px"});})
	//.eduCont dl
	$(".eduCont dl:odd").css("margin-right","0");
	})
	
	
	
	