//
//  Macros.h
//
//
//  Created by Vladimir Psyukalov on 05.05.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#ifndef Macros_h
#define Macros_h

#define kStatusBarHeight (20.f)
#define kStandartCellHeight (64.f)

#define APPLICATION ([UIApplication sharedApplication])
#define DELEGATE ([[UIApplication sharedApplication] delegate])

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(VERSION) ([[[UIDevice currentDevice] systemVersion] compare:VERSION options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO_IOS_10 ([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending)

#define RGBA(R, G, B, A) ([UIColor colorWithRed:R / 255.f green:G / 255.f blue:B / 255.f alpha:A / 255.f])
#define RGB(R, G, B) ([UIColor colorWithRed:R / 255.f green:G / 255.f blue:B / 255.f alpha:1.f])

#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LOCALIZE(STRING) (NSLocalizedString(STRING, nil))

#define DEGREES_TO_RADIANS(DEGREES) (DEGREES * M_PI / 180.f)
#define RADIANS_TO_DEGREES(RADIANS) (RADIANS * 180.f / M_PI)

// Macros for current project

#define kGoogleMapStyleURLTemplate (@"https://mts0.google.com/vt/lyrs=m@289000001&hl=en&src=app&x={x}&y={y}&z={z}&s=DGal&apistyle=s.t%3Aundefined%7Cs.e%3Ag%7Cp.c%3A%23ffebe3cd%2Cs.t%3Aundefined%7Cs.e%3Al.t.f%7Cp.c%3A%23ff523735%2Cs.t%3Aundefined%7Cs.e%3Al.t.s%7Cp.c%3A%23fff5f1e6%2Cs.t%3A1%7Cs.e%3Ag%7Cp.v%3Aoff%2Cs.t%3A1%7Cs.e%3Ag.s%7Cp.c%3A%23ffc9b2a6%2Cs.t%3A21%7Cs.e%3Ag.s%7Cp.c%3A%23ffdcd2be%2Cs.t%3A21%7Cs.e%3Al%7Cp.v%3Aoff%2Cs.t%3A21%7Cs.e%3Al.t.f%7Cp.c%3A%23ffae9e90%2Cs.t%3A82%7Cs.e%3Ag%7Cp.c%3A%23ffdfd2ae%2Cs.t%3A2%7Cp.v%3Aoff%2Cs.t%3A2%7Cs.e%3Ag%7Cp.c%3A%23ffdfd2ae%2Cs.t%3A2%7Cs.e%3Al.t%7Cp.v%3Aoff%2Cs.t%3A2%7Cs.e%3Al.t.f%7Cp.c%3A%23ff93817c%2Cs.t%3A40%7Cs.e%3Ag.f%7Cp.c%3A%23ffa5b076%2Cs.t%3A40%7Cs.e%3Al.t.f%7Cp.c%3A%23ff447530%2Cs.t%3A3%7Cs.e%3Ag%7Cp.c%3A%23fff5f1e6%2Cs.t%3A3%7Cs.e%3Al.i%7Cp.v%3Aoff%2Cs.t%3A50%7Cs.e%3Ag%7Cp.c%3A%23fffdfcf8%2Cs.t%3A49%7Cs.e%3Ag%7Cp.c%3A%23fff8c967%2Cs.t%3A49%7Cs.e%3Ag.s%7Cp.c%3A%23ffe9bc62%2Cs.t%3Aundefined%7Cs.e%3Ag%7Cp.c%3A%23ffe98d58%2Cs.t%3Aundefined%7Cs.e%3Ag.s%7Cp.c%3A%23ffdb8555%2Cs.t%3A51%7Cs.e%3Al%7Cp.v%3Aoff%2Cs.t%3A51%7Cs.e%3Al.t.f%7Cp.c%3A%23ff806b63%2Cs.t%3A4%7Cp.v%3Aoff%2Cs.t%3A65%7Cs.e%3Ag%7Cp.c%3A%23ffdfd2ae%2Cs.t%3A65%7Cs.e%3Al.t.f%7Cp.c%3A%23ff8f7d77%2Cs.t%3A65%7Cs.e%3Al.t.s%7Cp.c%3A%23ffebe3cd%2Cs.t%3A66%7Cs.e%3Ag%7Cp.c%3A%23ffdfd2ae%2Cs.t%3A6%7Cs.e%3Ag.f%7Cp.c%3A%23ffb9d3c2%2Cs.t%3A6%7Cs.e%3Al.t.f%7Cp.c%3A%23ff92998d")

#endif /* Macros_h */
