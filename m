Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795206081;
	b=lb/L8po/hfgTfBdkYLdKEkqQQzydbzybD8pXBTvVzbaOxE7ZKwoyZn7Yu00n+PxhrtE0
	 8PqjuFvb7GUC7mBkcy9pnsHwlQTydzhHU53tTqCGPq/GSE0XKol08IF4nVpO5fH5+p3aO
	 jfqLxV6MdBBug9xASzzEhOx1vlwUo7+fbNflLl/75AROs+16wM1NZQdioc744H9sXTSn2
	 fgbcg/SmWRGEFh6bIEYh8dEUHkpZwkzxkSFlAGGC1ENu1AzzYTfY1KLa9IfwEPAEzmfFs
	 J3T2RtSXChjQ9OHaWg5q647rQOn3mdRmAp3ivxcpAvhzELJRJD/LY+2cT1tYdWRk3Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206081;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qz2B4N9etx9jP8oea2N4QRySfXxTG4kD3MkOGiJ61ms=;
	b=pefkgDbFpStSOAhXLOEUtq3FU3bogC2HGqovhKPggC4UNPe9Qyfxaa/f9nM50S/D96HU
	 zOnnNE5pM3XjJxOH3e2QlW6difiLN2GfdcT80SYmuFv7W6jwudHjWo5xLOeU/NaKmTUTE
	 YK+WK30qLIvylg3gLEBJley1B6ZD2tPCYEIz+TRyNLHHutlhTlJoR/EqRUlOWPtbByNGM
	 Hlvb40x9pjoSzUVzBeLLCaZVlhqIjz32Q761qtcqsLKd/D1Wy4fPBNL3VXkzIInUl5RxW
	 7N0cFh8XEE6wRtbcfpMwU4H3M5esyRa9OKmadbB39hISPDCXAaTPy5x1c+pPmLPHJAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kns.com;
	spf=pass smtp.mailfrom=kns.com;
	dkim=pass header.d=kns.com header.i=@kns.com header.a=rsa-sha256 header.s=selector1 header.b=jU+zAZhp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.8
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012008.outbound.protection.outlook.com [40.107.75.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477F606A6EA;
	Fri, 20 Nov 2026 20:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1477F606A6EA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kns.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kns.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kns.com header.i=@kns.com header.a=rsa-sha256 header.s=selector1 header.b=jU+zAZhp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmbeJqvxhWsXecXeIkLnEYSvP8m/HEWjy7MVpShA/2QMyqdVwRlrLd5yO6dtFwq+iTZuBzMZhbd7loEGvJ3oqI4FZDOB4VhDYwkUwsnnsauFHPy19uCWd5AgaIUwbm47YY0NH6UzAO4ONdzmLoMqRrtDJ6rkVY95jexuAe2M7xS3snO2lBeYtqREycUkAopMH4h6linjkTTtoagoT6bcsPF0XWTVOghuyHb26ouVoimHigZvLAJmpn/Blfxkba0fxWnh4N7WLQ9FZ6HL67Lo8Ef2oBQgOSMjwnsgW/5ryrs6Eb93HTSUB3tLdREWSk8KLpoUkDzijz2+83m3exMbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz2B4N9etx9jP8oea2N4QRySfXxTG4kD3MkOGiJ61ms=;
 b=aUnHo46SWOrE0eTN0MsVBZ3vAjS54r8zSa6IijhiR0Mykn2N6Ov/Gs8KQMLkdXVAQOJzyVlfphaFIOYsLilkVGv9Q7Gsr/cjRZs1BLfDQVGwquME8amTzfeHRCHlOJXbyHa7zs4/yv1aU8z63oALGt2AFCjOl/iLkpXZd50LP5+HHs2S2VXZlPq/W8W99wz2pth6UQWbaBX7D/eJKaHjfTMxIH8FuIquZh5vwI78LtBxUuqxRZc4eHRZR/gkTo5PZC1MvrDJs9bvwhqdc5p88yZ7W9hBgj33Y3oal8RtxxHngyXfc3y+UvE1ZjBkeYKad4+eqo1CtaDxcAlfP2luZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kns.com; dmarc=pass action=none header.from=kns.com; dkim=pass
 header.d=kns.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kns.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz2B4N9etx9jP8oea2N4QRySfXxTG4kD3MkOGiJ61ms=;
 b=jU+zAZhp9va+dXOpFCGDPuSqdlyEfEgJDKOuAILXU6FSuxoOjcWNyMr8BG+/xVObcPZwo2f2JOkQzw2ixjXXeuk7GtybT+8g0tDGX+MsB9oBddV3dc4IRSwNCnFaddMRI65uQcoq96veA3z12QZ/6ojURJ+g+lATDbdgUgNQifRiWNudjkyW4SKaYO/6BGOmz4DEk3NQBfKnkDtoBTV1tfdAdlvy51M1RT/01jZ2dFRUyQy2pX8+HJLwVhT8fdob4Cpla3tZVwRHfuk4oaP5WBAwxnVVnPAWyfONxzBdvGlYRVn+AcuSHxebfFtWpf30BSOf7bf1Mqojl8gahdyIpQ==
Received: from TY0PR01MB5723.apcprd01.prod.exchangelabs.com
 (2603:1096:405:1b::14) by OSNPR01MB8248.apcprd01.prod.exchangelabs.com
 (2603:1096:604:48f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 20:21:15 +0000
Received: from TY0PR01MB5723.apcprd01.prod.exchangelabs.com
 ([fe80::150e:2612:b40c:cc2e]) by TY0PR01MB5723.apcprd01.prod.exchangelabs.com
 ([fe80::150e:2612:b40c:cc2e%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 20:21:15 +0000
From: Mike Schanne <mschanne@kns.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: LKML <linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, linux-rt-users
	<linux-rt-users@vger.kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt
	<rostedt@goodmis.org>, "chris.packham@alliedtelesis.co.nz"
	<chris.packham@alliedtelesis.co.nz>, Todd Leitzel <tleitzel@kns.com>
Subject: [PATCH v3] Revert "uio: use threaded interrupts"
Thread-Topic: [PATCH v3] Revert "uio: use threaded interrupts"
Thread-Index: Ad15K+GSMSGjY2+eQTqZf7dJi5uZgg==
Date: Fri, 20 Nov 2026 20:21:15 +0000
Message-ID:
 <TY0PR01MB5723E978A7EE94644B15621FD2782@TY0PR01MB5723.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kns.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR01MB5723:EE_|OSNPR01MB8248:EE_
x-ms-office365-filtering-correlation-id: a5130a7c-a44f-438c-4fb2-08df4743d3ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|19092799006|366016|261026121527099003|38070700021|10067099003|56012099006|11063799006|261009223027099003|261021123027099003|261021121427099003|261022075727099003|261102123227099003|261026140227099003|261102130727099003|261022105027099003|261028144727099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 ZrgZ/7qbV2WruA3Wi3giFeeMP8Ez0omALtQvti8TtbAbManeq2oDov4yQG6pbbIjlt7dU63MNqdwO3LtYiNMc1ALuY1NPz0d48O93wRx/MKlV/sGi1mQHa7nPmO16PjoyDhB5gOYjAfANdG+ri91RGheZIKwr0cpQFjcH8tcalRqz5GCSixGHF0VUFsvkCU/O4adu8WI3k+ZIwy5wEBAP1NMGTJTdPvYULkpDZOPp+Lh692ISsS8qgzyaF4t/w3memp0GBf4mv0PpZHHTgS3UPM8A3H+RHGE5thTh1TLPWBXF5/yjdtU7lTkq4oYfyLH1wBRu3FHhvKLTFwXFO/QWTXgMzHHZiqIkpeYoigib2ICWe7MO4ii4KdueHO14iEBZbWoJRPgWmqRNFScjknvkrm8d6PQlI0moaIDDWkkovZSwxLKbh85UglXf2cdnJ/HRJuZEExznEt109i0xEWu7Juehs7IWi3MNnOSU8xfhBGP4/HxyiUElAFpeP1Rp3yaibsdNhsXk1Ti8/epIw4rFUhr2OEfHxgpx9v/VmNdkXEyDEKNpYMOE++GprjpdOgoBUQhElWS3IwZy0/ApqYFLTWWL1LU5TAZ3VOjVcusRV06xcpNbvbqN7BJsQhkjQfvqf12S4WR4uGztKVyx4VmRYpytZjw1rOgkO48ArjgrEvzKRtQhRPvvtFJNyJV+c7B
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR01MB5723.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(19092799006)(366016)(261026121527099003)(38070700021)(10067099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261102123227099003)(261026140227099003)(261102130727099003)(261022105027099003)(261028144727099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bE40cUhLY0Z6OTQzQVU2MlVRMy8zWWpUamp0cDhVb0xncm5iMGxlWlNLYzhO?=
 =?utf-8?B?NzFNYjhnbUd4b25YT3A2eDBSa25TM01udzNFc2xHRVRyRDVoRGI5bHhFWWp0?=
 =?utf-8?B?YmhuK3cvazkxMk1QNk95S2FUc2J1RmtTM1J0emkwbDlTTTRtNzR0N3JPZUk5?=
 =?utf-8?B?Q2pMaS9oeVhGOXhaQVgrMzNEZUIzQ0dDbzAvMkpYNjdnUURWVk1LWjAvbVdH?=
 =?utf-8?B?SHZTVC9yOEJkS3M2a0l1Q2d6R1FLTi9OQUFZcDZwQlN4bWw3WVFXS1A1Vjl3?=
 =?utf-8?B?QjNESkdUcklzS0ZGU2dNaUl3YW9wNXFxNmVWZTVKQWRueVJSalJER1ZrQ3ds?=
 =?utf-8?B?SWdPdTg5cUp0WUxBelBIYWNoRTZVemoxUEQxTEJCWWFYaTczWlQ3WVoyWVNQ?=
 =?utf-8?B?MUJiOWVSTU1GRmNPdXl2ZXNUOHREZ1Bzd25WQnMvVEFjM2kvK1d1bk5nRER3?=
 =?utf-8?B?b0J2M0c4UWYrTE1qSVVsSU4yU1FEQ2JIc01nY3pIemg0d1p4MXlQd0JEYk8v?=
 =?utf-8?B?K2NTTittaktrTmJQM1Bhem5YbERrTVE0c1Z4ckxleWRtN09laHBOOWUwYUQy?=
 =?utf-8?B?UjVrVzN6UnZlYVhBSWd2S3hkcDkwUElhZVVVT0twQ21DeDl0YkRZTXhXWEla?=
 =?utf-8?B?R1hFd0dRaGpIc1p6ZVFhWGl0NWVOb1crdDJNOWNDbHhGVUcrZ3VyWTJzWmNB?=
 =?utf-8?B?OTVjK1lCNzVsWTJSRUF3Z2NRbmc1a3Y3QWpxeXZvb3VsWEVGNVJrVTU1RzQ5?=
 =?utf-8?B?eTlZbFJ6RG1vdUM3SnpLc1Bpc0IzRDF6Wkd5SmM5QWxZajdvbytlOFV0UVN0?=
 =?utf-8?B?VDRVRm0yN1hNKzlEQU5FZVlQZGlXVmV4dUJTWmhVMTdlVEV6QU9kSmptazdz?=
 =?utf-8?B?N1hUbUtKeDgrYm5idkRHdVk1SHJSSXZ5eWNWajJZcGd3ZER3T2R4RjFuRENj?=
 =?utf-8?B?czFrdER2MkdqRGRaV1lYSG8yNmkzQTVJdUZZaDQ3Rms5Q09wRmJDaHg0S1Jh?=
 =?utf-8?B?NzlUdklxcnNYRGFPbWxPNGRmd3FNMjJmYWd3b0xzQXJOaFUzNEVERTU3ckhi?=
 =?utf-8?B?Q0tzd2RRU3ZXVUtTRWVYNmhNZGxSSDdRZkQ3M1VhbDhGR0wweFBjL1ZNbGdq?=
 =?utf-8?B?QU81a1RBK3kwZC83Vko5MlkybVlReS9SMmMrQlJXRmUxdGp6RFc2ei9ia2tP?=
 =?utf-8?B?d3VTcU9wY3dtTFlaVGhZajNpSUlIbXpHcU1tZnBhdTFLdklTVXp0aVR6akdN?=
 =?utf-8?B?Y0J4VnQ3cTJyRFprRFRWTmM5d1lUTlJRQmFvcmtQMGl4cTlVNDg0WkJRKzJ0?=
 =?utf-8?B?WFFwSmkzL0hwWGlOR0NsRjNDVEt2L2kraXUyTzVTcUVKeWpHbE8yZ3FBc2JJ?=
 =?utf-8?B?b1NsdXRVdC83NHcySTljRHdnNW8wb0RVczMxdFkrV3YzR0FKMFBIL1V0ZVdQ?=
 =?utf-8?B?aVVaWmNhUkQvU0NaUDFsNE5GVlExbUR4d0xuZDNqa0FDSnpqY2dJWWxZakdp?=
 =?utf-8?B?S2ZybFFTeTVsWVl2bWZxUmtrSVFQRmJ2MHpkcng1OU1pMUt4NDFubHBnQzlj?=
 =?utf-8?B?eS9mWll6cGxJNHQyVHRBMTNoWStYdXdhT1Vha2VsZ1FVOWpNSHlkdkFWVnBD?=
 =?utf-8?B?d1g0VStSanp3bVp5eEZqaHAxd0xPZnB0Zm9ieXRwbW5FVUpLZTVsM3I1TFRO?=
 =?utf-8?B?TjZBWmZnTytwSVUzd09vaE9YUE1qYStOWDNKMVZ2dm0vOFdzTzFFVW8vMW5C?=
 =?utf-8?B?bjc2a1FUZjF6MVpBVXpoNXp4d2JaKzBZaXJBMWZ3czRPcHA1M2dxZmM3Kyta?=
 =?utf-8?B?K0d5VEl3aTk3WGx3YUJ6ZUxGZUhYVVFTSjhybEdBNjRHL2QvcWVzUGlVaW90?=
 =?utf-8?B?MFczcm9xeitPL24raFFZamFwNjVXVGxPWTlBZFRXNlV5ajNVY3piUzRWM2NM?=
 =?utf-8?B?YzFHVytOK0V0dWRTMUVaMldpU1ZlaUYxc2dCNDNKYzJpRDRxemtsWGlyL0Jr?=
 =?utf-8?B?d0RBSVQ3M1BxajlIUEkxd1ROdTZDRS9RSFBXb2tkOVhpWnVnMnIzU1JIOGZJ?=
 =?utf-8?B?aFozRVJzdUk2UkpiUE9NeGM2NmJSQmwwQnZGYkJCeHVWQnVaeDg0MlBjSVJY?=
 =?utf-8?B?eEFTMHRGNlRsVzVmMXdyeFBTN25WZi9NTEo4UHlZVmlsbUJ3MHVNRjZ4eXBm?=
 =?utf-8?B?VlpaV1BEeXZETUpad2pjczZqODR0QlBCeSttUWtpZk1IZnBRYVZLZ0VDZXp0?=
 =?utf-8?B?N2xGQVAvZzBvTXJaaTNYd3ozNXFFUVVZc3B2TXc5WjBQait5ZGcvN1lQM3Ew?=
 =?utf-8?Q?fon+SURaEPb1XOp0Xo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: kns.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR01MB5723.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5130a7c-a44f-438c-4fb2-08df4743d3ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 20:21:15.4630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 13db00d8-2bd3-413e-a71f-ae7175d8527f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPKVgz+i4IBV3nvygEYHUg0DUYKtFtKOcz9IwByvVVtv6vPs2cp2rvvD9/8vQjb0HI6FWINL+c90jOU212UdNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR01MB8248

VGhpcyByZXZlcnRzIGNvbW1pdCBmOGEyN2RmYTRiODJkNDQyYWYxYzA2NDVhNWFjYzcwY2M5N2M2
N2Y2Lg0KDQpUaGUgcGF0Y2ggY2xhaW1zIHRvIGZpeCB0aGUgaXNzdWUgd2l0aCBuZXN0ZWQgaW50
ZXJydXB0cyBieSB1c2luZw0KcmVxdWVzdF90aHJlYWRlZF9pcnEoKS4gU2hvdWxkIGFuIElSUSBi
ZSBuZXN0ZWQsIHRoZW4gX19zZXR1cF9pcnEoKSB3aWxsDQpvdmVyd3JpdGUgdGhlIHByaW1hcnkg
aGFuZGxlciwgYW5kIHRoZSBzdWJtaXR0ZWQgdWlvX2ludGVycnVwdF9oYW5kbGVyKCkNCndpbGwg
bm90IGJlIGNhbGxlZCAob25seSB0aGUgdGhyZWFkZWQgaGFuZGxlcikuDQpPbiBub24tbmVzdGVk
IGludGVycnVwdHMsIGJvdGggaGFuZGxlcnMgYXJlIGluc3RhbGxlZCBhbmQgd29yaw0KcHJvcGVy
bHkuIEluIGZvcmNlZCB0aHJlYWRlZCBlbnZpcm9ubWVudHMsIHN1Y2ggYXMgUFJFRU1QVF9SVCwg
aXQNCnJlc3VsdHMgaW4gdHdvIHRocmVhZHMsIGFkZGluZyBhZGRpdGlvbmFsIG92ZXJoZWFkLg0K
DQpUaGVyZWZvcmUgcmV2ZXJ0IHRoZSBjaGFuZ2UuDQoNCkZpeGVzOiBmOGEyN2RmYTRiODJkICgi
dWlvOiB1c2UgdGhyZWFkZWQgaW50ZXJydXB0cyIpDQoNClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwg
U2NoYW5uZSA8bXNjaGFubmVAa25zLmNvbT4NCi0tLQ0KdjM6IFJldmlzZSBjb21taXQgbWVzc2Fn
ZQ0KdjI6IEluc3RlYWQgb2YgYW4gaWZkZWYsIHJldmVydCB0aGUgY2l0ZWQgY29tbWl0DQp2MTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1RZMFBSMDEwMU1CNDg2NzZENTAzQTdGNkM1Q0FD
MTEyQjNCRDJBNTJAVFkwUFIwMTAxTUI0ODY3LmFwY3ByZDAxLnByb2QuZXhjaGFuZ2VsYWJzLmNv
bS8NCi0tLQ0KDQogZHJpdmVycy91aW8vdWlvLmMgfCAxOSArKysrKy0tLS0tLS0tLS0tLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3Vpby91aW8uYyBiL2RyaXZlcnMvdWlvL3Vpby5jDQppbmRleCBmOGZh
MjA1MjI2NjAuLjllZjViMjc2YjA5MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdWlvL3Vpby5jDQor
KysgYi9kcml2ZXJzL3Vpby91aW8uYw0KQEAgLTQ0MiwzMCArNDQyLDIxIEBAIEVYUE9SVF9TWU1C
T0xfR1BMKHVpb19ldmVudF9ub3RpZnkpOw0KICAqIEBpcnE6IElSUSBudW1iZXIsIGNhbiBiZSBV
SU9fSVJRX0NZQ0xJQyBmb3IgY3ljbGljIHRpbWVyDQogICogQGRldl9pZDogUG9pbnRlciB0byB0
aGUgZGV2aWNlcyB1aW9fZGV2aWNlIHN0cnVjdHVyZQ0KICAqLw0KLXN0YXRpYyBpcnFyZXR1cm5f
dCB1aW9faW50ZXJydXB0X2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KK3N0YXRpYyBp
cnFyZXR1cm5fdCB1aW9faW50ZXJydXB0KGludCBpcnEsIHZvaWQgKmRldl9pZCkNCiB7DQogICAg
ICAgIHN0cnVjdCB1aW9fZGV2aWNlICppZGV2ID0gKHN0cnVjdCB1aW9fZGV2aWNlICopZGV2X2lk
Ow0KICAgICAgICBpcnFyZXR1cm5fdCByZXQ7DQoNCiAgICAgICAgcmV0ID0gaWRldi0+aW5mby0+
aGFuZGxlcihpcnEsIGlkZXYtPmluZm8pOw0KICAgICAgICBpZiAocmV0ID09IElSUV9IQU5ETEVE
KQ0KLSAgICAgICAgICAgICAgIHJldCA9IElSUV9XQUtFX1RIUkVBRDsNCi0NCi0gICAgICAgcmV0
dXJuIHJldDsNCi19DQotDQogLyoqDQogICogdWlvX2ludGVycnVwdF90aHJlYWQgLSBpcnEgdGhy
ZWFkIGhhbmRsZXINCiAgKiBAaXJxOiBJUlEgbnVtYmVyDQogICogQGRldl9pZDogUG9pbnRlciB0
byB0aGUgZGV2aWNlcyB1aW9fZGV2aWNlIHN0cnVjdHVyZQ0KICAqLw0KLXN0YXRpYyBpcnFyZXR1
cm5fdCB1aW9faW50ZXJydXB0X3RocmVhZChpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQotew0KLSAg
ICAgICBzdHJ1Y3QgdWlvX2RldmljZSAqaWRldiA9IChzdHJ1Y3QgdWlvX2RldmljZSAqKWRldl9p
ZDsNCisgICAgICAgICAgICAgICB1aW9fZXZlbnRfbm90aWZ5KGlkZXYtPmluZm8pOw0KDQotICAg
ICAgIHVpb19ldmVudF9ub3RpZnkoaWRldi0+aW5mbyk7DQotDQotICAgICAgIHJldHVybiBJUlFf
SEFORExFRDsNCisgICAgICAgcmV0dXJuIHJldDsNCiB9DQoNCiBzdHJ1Y3QgdWlvX2xpc3RlbmVy
IHsNCkBAIC0xMDQ0LDggKzEwMzUsOCBAQCBpbnQgX191aW9fcmVnaXN0ZXJfZGV2aWNlKHN0cnVj
dCBtb2R1bGUgKm93bmVyLA0KICAgICAgICAgICAgICAgICAqIEZEcyBhdCB0aGUgdGltZSBvZiB1
bnJlZ2lzdGVyIGFuZCB0aGVyZWZvcmUgbWF5IG5vdCBiZQ0KICAgICAgICAgICAgICAgICAqIGZy
ZWVkIHVudGlsIHRoZXkgYXJlIHJlbGVhc2VkLg0KICAgICAgICAgICAgICAgICAqLw0KLSAgICAg
ICAgICAgICAgIHJldCA9IHJlcXVlc3RfdGhyZWFkZWRfaXJxKGluZm8tPmlycSwgdWlvX2ludGVy
cnVwdF9oYW5kbGVyLCB1aW9faW50ZXJydXB0X3RocmVhZCwNCi0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT5pcnFfZmxhZ3MsIGluZm8tPm5hbWUsIGlkZXYp
Ow0KKyAgICAgICAgICAgICAgIHJldCA9IHJlcXVlc3RfaXJxKGluZm8tPmlycSwgdWlvX2ludGVy
cnVwdCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT5pcnFfZmxhZ3Ms
IGluZm8tPm5hbWUsIGlkZXYpOw0KICAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGluZm8tPnVpb19kZXYgPSBOVUxMOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBlcnJfcmVxdWVzdF9pcnE7DQotLQ0KMi41My4wDQoNClRoaXMgZW1haWwgaXMg
bm9uLWJpbmRpbmcsIGlzIHN1YmplY3QgdG8gY29udHJhY3QsIGFuZCBuZWl0aGVyIEt1bGlja2Ug
YW5kIFNvZmZhIEluZHVzdHJpZXMsIEluYy4gbm9yIGl0cyBzdWJzaWRpYXJpZXMgKGVhY2ggYW5k
IGNvbGxlY3RpdmVseSDigJxLJlPigJ0pIHNoYWxsIGhhdmUgYW55IG9ibGlnYXRpb24gdG8geW91
IHRvIGNvbnN1bW1hdGUgdGhlIHRyYW5zYWN0aW9ucyBoZXJlaW4gb3IgdG8gZW50ZXIgaW50byBh
bnkgYWdyZWVtZW50LCBvdGhlciB0aGFuIGluIGFjY29yZGFuY2Ugd2l0aCB0aGUgdGVybXMgYW5k
IGNvbmRpdGlvbnMgb2YgYSBkZWZpbml0aXZlIGFncmVlbWVudCBpZiBhbmQgd2hlbiBuZWdvdGlh
dGVkLCBmaW5hbGl6ZWQgYW5kIGV4ZWN1dGVkIGJldHdlZW4gdGhlIHBhcnRpZXMuIFRoaXMgZW1h
aWwgYW5kIGFsbCBpdHMgY29udGVudHMgYXJlIHByb3RlY3RlZCBieSBJbnRlcm5hdGlvbmFsIGFu
ZCBVbml0ZWQgU3RhdGVzIGNvcHlyaWdodCBsYXdzLiBBbnkgcmVwcm9kdWN0aW9uIG9yIHVzZSBv
ZiBhbGwgb3IgYW55IHBhcnQgb2YgdGhpcyBlbWFpbCB3aXRob3V0IHRoZSBleHByZXNzIHdyaXR0
ZW4gY29uc2VudCBvZiBLJlMgaXMgcHJvaGliaXRlZC4NCg==
