//
//  HTTPWebAPIUrl.h
//  APPFormwork
//
//  Created by 辉贾 on 2016/11/4.
//  Copyright © 2016年 RJ. All rights reserved.
//

#ifndef HTTPWebAPIUrl_h
#define HTTPWebAPIUrl_h

#ifdef RJDebug
#define kBaseUrl    @"http://60.205.93.174:8080/greatwall"
#define KImgBaseUrl @"http://60.205.93.174:8080/greatwall/headPhoto"
#else
#define kBaseUrl    @"http://www.tjhaval.com:7363/great_wall"
#define KImgBaseUrl @"http://www.tjhaval.com:7363/great_wall/headPhoto"
#endif

#define kAppUrl     @"d/app/appService"
#define kImageUrl   @"d/appPhoto/appPhotoService"

#endif /* HTTPWebAPIUrl_h */
