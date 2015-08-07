Red/System [
	Title:	"Windows Image widget"
	Author: "Xie Qingtian"
	File: 	%image.reds
	Tabs: 	4
	Rights: "Copyright (C) 2015 Nenad Rakocevic. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

ImageWndProc: func [
	hWnd	[handle!]
	msg		[integer!]
	wParam	[integer!]
	lParam	[integer!]
	return: [integer!]
	/local
		rect	[RECT_STRUCT]
		width	[integer!]
		height	[integer!]
		hBackDC [handle!]
		ftn		[integer!]
		bf		[tagBLENDFUNCTION]
][
	switch msg [
		WM_ERASEBKGND [
			hBackDC: as handle! GetWindowLong hWnd wc-offset - 4
			rect: declare RECT_STRUCT
			GetClientRect hWnd rect
			width: rect/right - rect/left
			height: rect/bottom - rect/top
			ftn: 0
			bf: as tagBLENDFUNCTION :ftn
			bf/BlendOp: as-byte 0
			bf/BlendFlags: as-byte 0
			bf/SourceConstantAlpha: as-byte 255
			bf/AlphaFormat: as-byte 1
			AlphaBlend as handle! wParam 0 0 width height hBackDC 0 0 width height ftn
			return 1
		]
		default [0]
	]
	DefWindowProc hWnd msg wParam lParam
]

make-image-dc: func [
	hWnd		[handle!]
	img			[red-image!]
	return:		[integer!]
	/local
		graphic [integer!]
		rect	[RECT_STRUCT]
		width	[integer!]
		height	[integer!]
		hDC		[handle!]
		hBitmap [handle!]
		hBackDC [handle!]
][
	graphic: 0
	rect: declare RECT_STRUCT

	GetClientRect hWnd rect
	width: rect/right - rect/left
	height: rect/bottom - rect/top

	hDC: GetDC hWnd
	hBackDC: CreateCompatibleDC hDC
	hBitmap: CreateCompatibleBitmap hDC width height
	SelectObject hBackDC hBitmap
	GdipCreateFromHDC hBackDC :graphic
	GdipDrawImageRectI graphic as-integer img/node 0 0 width height
	ReleaseDC hWnd hDC

	as-integer hBackDC
]