Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8862F3D;
	Mon,  6 Nov 2023 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="FmsfTq1D"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB0983;
	Mon,  6 Nov 2023 00:55:35 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A67NKY4022772;
	Mon, 6 Nov 2023 08:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=wkGMmzcSZ/3JOudwAejZj9jGiIn5kQWXhGTUNPcmnrg=; b=
	FmsfTq1DlYwUkhhMo77eCfsQ4UrWeqrroxqlD4ymQOqrO2p/6Ard3K+/VHBT3Kn0
	gLcP0ygJD2VupOxD9DBf4zclgJqQE7oUra4gIJ1Vl5lYxiNXztTWNbexpXyeqwFh
	dO34aPLoZaXvuGpeIXoy0fO5h/AxVH4mnbzVYn0IfsjFZfRBi4pXwZ8sznHhh1B/
	fo1qs/7Tpd3fMGr/N82+pwxwCYovXvowMXEc8lfRfk58Jw11LWXj3+EhKpuKOLHM
	AmFkA1i/dOlxUKv0GtQQtP6ohFpI7ftTntuYOORZs3ibJwxwLnM5ZMILRd06KSWB
	ojtjPlCHxOGi6EO7AH+dqQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u5cx69e72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 08:54:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgGuyQdHgHLYNKVlVtGeHi+aRvis8McmOFNdOcASB2IoXeC0DOiDSfEnuKaoiik+5DzZA9diHUXxSYjAifmJbyx4h/niRAxoZ64bXXEUubM5pLNL88EtbRW3SM56cqid5da1JxEAMvLK1EdY8AwwI7nIdrEfn0ls2TpdoLjifQAz6L3KP3xy8Yw+eJ/zHzXjg9uAzng7ZbE8o6/ldeAbSl2+QFovRHEUim2D3SKArDsaZz7DCQjsH6cR8v3i8VOk7lYJFtmn+CuPX4og+imai8K5iSlhnQQqeqs0Z4WkfUojfNqsiI/W0DShU5lRmxKrPRbaxn/ugLE+VPZPjWN2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkGMmzcSZ/3JOudwAejZj9jGiIn5kQWXhGTUNPcmnrg=;
 b=Ou588+NIuIT7wLRAS/ehKHqDzDvLoAj92Rhi39O0JTru5WJTerR3uIYh3ln3pbTAdl8tJSq27eHK46pEo2mX1zejLaCIipLAFiLr2uvdDZsBuxLI3xIDfbXvxZ7UzqHO8xPqtO2sz6Flw1GpKxikXlL/uEhAIkZfFxbtvDiXkVl/W0BJAKyhQPd9U1lgLkF4rzONByhjV5uMzuKe55nCtnSUlGVp4p+1dlBQSaOBfSO8rPhOfoDJxY0KmIGw7gP8/F9SbofQrp5A0e12wG+mv+zoxXNPbbWwsKs84vG5JjmcxMjOsjYdDdgbT2SLlNWC41hlYn4DDRW5wjrUVcotVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:54:51 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f%5]) with mapi id 15.20.6954.025; Mon, 6 Nov 2023
 08:54:50 +0000
From: "Li, Meng" <Meng.Li@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt
	<rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        USB mailing list
	<linux-usb@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: RE: RE: USB: add check to detect host controller hardware removal
Thread-Topic: RE: USB: add check to detect host controller hardware removal
Thread-Index: 
 Adn9i9LFJguVckBOQnaI1KZe5N8FAAAbV+4AAJYf4gAABSReAAAOS6qwABjp6YAAHiq+0AAWuX8AACyeyIAABUsdgAAAoHwAACaVFgAAC20/gALBAh8AAApVjQAAcXa+cAALyDyAAABJdoA=
Date: Mon, 6 Nov 2023 08:54:50 +0000
Message-ID: 
 <PH0PR11MB519187340D0C1AD3F05DC74CF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
References: 
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
 <20231103154624.WEWPMHTp@linutronix.de>
 <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
 <PH0PR11MB5191B5D71DBD450210E2BEDFF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20231106082829.iBvQ9hCY@linutronix.de>
In-Reply-To: <20231106082829.iBvQ9hCY@linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|BN9PR11MB5323:EE_
x-ms-office365-filtering-correlation-id: 47b29883-8e49-4e67-3d4b-08dbdea6092a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zx1wRZ9NADd7iavsulKQXq7JGYyupvD1rmYCxOEp0MS/a/KkBwGviNex9KhKd47v6RI0T/q1pZhg5QFGrMaYI0YKg716gIw6ZQTDiNjb3HdC+yJ2HBu1gjyGsM8jkjyHrWV+AV/zNnanRsFRxnc3AVq+Wk6fzdzulpyLrt6Augy/62xL5UWtB3HmzPqrKG1DTmoeAgfPgVJ3Ki8duuoQMQhpOX3v+aUJiQ33nbKmhm1XZgE2aL8PTP0GW2/0Ka80ykWUBIOWQWZy5xFwk22GYF3sU9v3PKH3kfBHQTlr6P6y+csL8yGKSFSf+ZWiBxJgsXLs4pDXJvzBvfh7g6jxlC1Aik6d6N6yT8rlrgxI7PN4QrOKvaQCHzVNbw8kOJLynYQRnMGeH9w8OIHa+0ARf6cTlNN4RKGn6T+iwICyx913YJbi+g4LzDJtQelcXYwlrj51+8kD7/JK3mfw9oxNmrp/Wn6bvPGAxZejECqGuatKYCYkGU+io7Tq54+RVCHQvsr34osyiLvucwXLv87Jw62T6gmeYD6N/cZUOmYo+9ySI8pthOy5pwVagWBUo9y5/vupPpIaWPIXoq1ggxyHaVuW7mBLLy9ZQQiIx3/AULSL6UIy9OUkK7E2X0e4bGmVgmp59KhEPGSI9iEzIBFpOXM0niYyYn77GOJbNpxvyJk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(396003)(376002)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799009)(55016003)(2906002)(38100700002)(4326008)(8676002)(8936002)(41300700001)(33656002)(83380400001)(5660300002)(86362001)(76116006)(9686003)(52536014)(122000001)(316002)(66556008)(66476007)(64756008)(54906003)(66446008)(66946007)(6916009)(6506007)(7696005)(53546011)(71200400001)(38070700009)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U3Z3V2cwZlA3QnI3NFlzUXk3RjMxZ3FyaHlTcDhrUDUyYitKYmJhNllPTkkx?=
 =?utf-8?B?UlJhZFN2UExUcGpxeHRESUNKUE1JTmJTblA5MFhJQ21XVzRObU43Nm5qSGpq?=
 =?utf-8?B?TnVEWjIzaXR3NXBybUR1czBDdVFnVnIxUHB2UEczdUhSay93dmRFY2puUkNo?=
 =?utf-8?B?WWY5a3JWdG5LdXNJZGlZUkxhU0k2TVpMU0J1QXRXc09zcGxhMDR3ZE5vN250?=
 =?utf-8?B?QmpERURHMXZQT0xqbVltRzNqY2lxRGgzL2RGOThFOXdkVVZjK0RYS2wzNnRO?=
 =?utf-8?B?TFVzT0lmRHZXbUlFTTZIQlZHenRIMTc2QVM5Nm5xeUo2WjJjaDlMem1ZcXZj?=
 =?utf-8?B?TDRvTGR2NUh5UXAwU3loekdWbDRBMHd6aDVrbHlDWWovTU5YS3BPV21QcTNn?=
 =?utf-8?B?b2R0eVNqT0czNU5CMDlZcDBuenN4SVVvTk5ZTDlPV2hPaE9tR1Y2dmJsWjdj?=
 =?utf-8?B?U0M2UTBtNWxyeG1sZjgvRTk4VVBCejRhbTBtWjc0cHhaY2ZrUFdka3JSZStP?=
 =?utf-8?B?ejN1NlZaTU1McEIrcmlnamZoQU1VZ2w4b0RxQzIvby9ueXZwajlKcW92d0FH?=
 =?utf-8?B?alZEMWRBdEY2ZGVYcHVjckc0cElyNy9Sb2F3eGVTNWoxc0hWaXhpNnhyRjNI?=
 =?utf-8?B?Skw4aUwwRGdOeVovdlJORWMxOENWZ0pXTDFiMzU2cFZvTG1CckhZdzdrYjZZ?=
 =?utf-8?B?aCtLTUw4UkJyS0V2YTJMNkF6bUtDRWpXS2VTeGpGcXhnbGxHZUg0bElDRXpP?=
 =?utf-8?B?VkY5bnNCVjlEdFY4NUQ2c25IKzBRcjQxNHEreG1BQnFIZVJzMyt3U3VaU3M4?=
 =?utf-8?B?ck5FblZxaFh3NEt6dmJLZmJLYmI0aGhyZCsvUkZ4MzVJVldqUjVSSmhqYjk1?=
 =?utf-8?B?WG1hQ3JPV09OTVNqdy9OUFJGOVgrOXpOSi9RdzFLUXJCWWhHYzIxb21qTUVv?=
 =?utf-8?B?eS9PR2F2eW1jRHdhZWVaM1E0b3BmOFN2eWlpUnYwTUtueU9RWTQyeHRPRWZD?=
 =?utf-8?B?UGIycDd3a3JxN3B2TUNGZmt5aEtEYlEzemZ1NjYyaU9PSVpISU4yN2lRc2Zm?=
 =?utf-8?B?TXFxZHRjem5MQktoaHJic2JCVlJObks4M0NVOFZjV0MyM3ZyWmJMaUdESnpn?=
 =?utf-8?B?Vm1ZV0grOG5qdWY5RXM2ZG9pMEtqNHRrV1hHT1NEVUphRldpVjU5ZnJBaXlX?=
 =?utf-8?B?eTNqOG9ZNnU3dk9SME1oUEVlY0wxbC9QT1I2eUpTby9QaWtqRU1qTlI5OEw1?=
 =?utf-8?B?ODlVNkd3cHVkM1pxalZkYStlOXlqUm1CNWt0MzlqQWgzWFRNczZXa1ZwZkl6?=
 =?utf-8?B?ZDFVOW9XVkxXZlNKVVFmUTAySk00bVZzMjhYa1FNVnpRYkF1bndKbVVYUnVv?=
 =?utf-8?B?d2srWmFZVzl4S3dBTHBmeUIzVC9FSXdPYVBGdjliU0plbW8zanJhVTQ2VjFF?=
 =?utf-8?B?Z005S2xjVURBd2E4WE93YU5FTitrR3NLWTlEcktYVXJzcDQ5V2wyTkZsV1Qx?=
 =?utf-8?B?bXRSSkhnb1piQkRVK3BGbVdaOVNjU0FINUVURHhEa3FFbG1YT0RJTmh0Y2Q1?=
 =?utf-8?B?bVgrcFRkeEV0eUgzMnpudWZiZmllOHg0SHE0RzlJOHhMR3U0TE0rWkF3MXhZ?=
 =?utf-8?B?NStsdkVuT2JEbXdNTHE2RHMzait5RlU1TFk1SG16V2g3dWxCTHZOcVZXS3di?=
 =?utf-8?B?N3hNSWhuakpyRGh1cWhLbzJZaHJJNmIwT0ZSZ1dZQmM2Qk12Q2p2NEVnc3Vh?=
 =?utf-8?B?dHRERUdkZ1FuMmg3K0tHamhNc0wzNWZtUEwrcmJMOTFTY3I1R2F5bVoxNW9y?=
 =?utf-8?B?bG5RcW1WRkdLdE9XZmdjRzkwTHZiczdheGxTa1ZzVHR6Zm5OVWRZd0hycUUy?=
 =?utf-8?B?TnJSdFQ1WUtDK2ZKMFRDamJ0eFYxbTJXT1d2K0VlOEZSQWlRWFRyODVqb2p6?=
 =?utf-8?B?OUcwRG5LSmZTdzVPMXhGUnMvbXhPQ3MvNVVKaFZZSEhiRTBBdElZK0VhZkRi?=
 =?utf-8?B?ZGpEQy9zWnlBcEJab0VpQ3ljS0RUcm5TVFdXTk9keVA0LzZYWStPOEJaM1VP?=
 =?utf-8?B?Rms2VVJpMk9QOU0wK0gxa3E5WkREd3BZdzRNU3BRUXZwUTBIbGNkcXdjTmdF?=
 =?utf-8?Q?YVqY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b29883-8e49-4e67-3d4b-08dbdea6092a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 08:54:50.2340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUVAqBlQfFgujpGXXijsw2zhK+KHorJyNdPmg5I6PbS3hlYlgXG3FODeYzrckp6KeTBPXYGdDK/+LEVsVEwdHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-Proofpoint-GUID: PjdNpmycwDiShdGkFKH-Wh1hdYDVWlg6
X-Proofpoint-ORIG-GUID: PjdNpmycwDiShdGkFKH-Wh1hdYDVWlg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_06,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=913 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2310240000 definitions=main-2311060075

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ViYXN0aWFuIEFuZHJ6
ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiBTZW50OiBNb25kYXksIE5vdmVt
YmVyIDYsIDIwMjMgNDoyOCBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNv
bT4NCj4gQ2M6IEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+OyBTdGV2ZW4g
Um9zdGVkdA0KPiA8cm9zdGVkdEBnb29kbWlzLm9yZz47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRo
YXQuY29tPjsgVVNCIG1haWxpbmcgbGlzdA0KPiA8bGludXgtdXNiQHZnZXIua2VybmVsLm9yZz47
IGxpbnV4LXJ0LXVzZXJzIDxsaW51eC1ydC11c2Vyc0B2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBSRTogVVNCOiBhZGQgY2hlY2sgdG8gZGV0ZWN0IGhvc3QgY29udHJvbGxlciBoYXJk
d2FyZSByZW1vdmFsDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24g
V2luZCBSaXZlciBlbWFpbCBhY2NvdW50IQ0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiBPbiAyMDIzLTExLTA2IDAzOjAyOjQyIFsrMDAwMF0s
IExpLCBNZW5nIHdyb3RlOg0KPiA+ID4gR29vZC4gIE1lbmcgTGksIGNhbiB5b3UgdGVzdCBhIHBh
dGNoIHRoYXQgcmVwbGFjZXMgdGhlDQo+ID4gPiBsb2NhbF9pcnFfZGlzYWJsZSgpIC0gdXNiX2hj
ZF9pcnEoKSAtIGxvY2FsX2lycV9lbmFibGUoKSBsaW5lcyB3aXRoDQo+ID4gPiBhIHNpbmdsZSBj
YWxsIHRvIGdlbmVyaWNfaGFuZGxlX2lycV9zYWZlKCk/DQo+ID4NCj4gPiBJdCBuZWVkcyBhbiBp
cnEgbnVtYmVyIGFzIHBhcmFtZXRlciwgd2hhdCBJIHNob3VsZCBwYXNzIHRvIHRoaXMNCj4gPiBm
dW5jdGlvbiwgMCBvciBkZXYtPmlycSBvciBvdGhlciB2YWx1ZT8NCj4gDQo+IGRldi0+aXJxIGlz
IHdoYXQgaXQgYXNrcyBmb3IuIEkgd291bGQgcmVhbGx5IGFwcHJlY2lhdGUgaWYgeW91IHdvdWxk
DQo+IGluc3RlYWQgdXNlIHRoZSBzeXNmcyBpbnRlcmZhY2UgdG8gcmVtb3ZlIHRoZSBkZXZpY2Ug
cHJpb3IgcGh5c2ljYWxseSByZW1vdmluZw0KPiBpdC4gVGhpcyBzaG91bGQgc29sdmUgeW91ciB0
cm91YmxlLg0KPiANCg0KVGhpcyBpcyBub3QgbXkgb3JpZ2luYWwgaXNzdWUgdGhhdCBJIGVuY291
bnRlcmVkLg0KSSBhZ3JlZSB0aGF0IHdlIHNob3VsZCByZW1vdmUgdGhlIGRldmljZSBmcm9tIHN5
cyBpbnRlcmZhY2UgZmlyc3RseSwgYW5kIHRoZW4gZG8gaG90LXBsdWcgYWN0aW9uLg0KTXkgb3Jp
Z2luYWwgaXNzdWUgd2FzIHRoZSBjYWxsdHJhY2Ugb24gUlQga2VybmVsIGlmIEkgcmVtb3ZlIHRo
ZSBkZXZpY2UgZnJvbSBzeXMgaW50ZXJmYWNlLg0KIyBlY2hvIDEgPiAvc3lzL2J1cy9wY2kvZGV2
aWNlcy8wMDAxOjAxOjAwLjAvcmVtb3ZlDQp4aGNpX2hjZCAwMDAxOjAxOjAwLjA6IHJlbW92ZSwg
c3RhdGUgMQ0KdXNiIHVzYjI6IFVTQiBkaXNjb25uZWN0LCBkZXZpY2UgbnVtYmVyIDENCnVzYiAy
LTQ6IFVTQiBkaXNjb25uZWN0LCBkZXZpY2UgbnVtYmVyIDINCnhoY2lfaGNkIDAwMDE6MDE6MDAu
MDogVVNCIGJ1cyAyIGRlcmVnaXN0ZXJlZA0KQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQg
ZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQga2VybmVsL2xvY2tpbmcvc3BpbmxvY2tfcnQuYzo0Ng0K
aW5fYXRvbWljKCk6IDAsIGlycXNfZGlzYWJsZWQoKTogMTI4LCBub25fYmxvY2s6IDAsIHBpZDog
NzY1LCBuYW1lOiBzaA0Kcm9vdEBueHAtbHMxMDQzOnByZWVtcHRfY291bnQ6IDAsIGV4cGVjdGVk
OiAwDQpSQ1UgbmVzdCBkZXB0aDogMCwgZXhwZWN0ZWQ6IDANCn4jIENQVTogMCBQSUQ6IDc2NSBD
b21tOiBzaCBUYWludGVkOiBHICAgICAgICBXICAgICAgICAgIDYuMS41Ny1ydDEwLXlvY3RvLXBy
ZWVtcHQtcnQgIzENCkhhcmR3YXJlIG5hbWU6IExTMTA0M0EgUkRCIEJvYXJkIChEVCkNCkNhbGwg
dHJhY2U6DQogZHVtcF9iYWNrdHJhY2UucGFydC4wKzB4YzgvMHhkNA0KIHNob3dfc3RhY2srMHgy
MC8weDMwDQogZHVtcF9zdGFja19sdmwrMHg2Yy8weDg4DQogZHVtcF9zdGFjaysweDE4LzB4MzQN
CiBfX21pZ2h0X3Jlc2NoZWQrMHgxNjAvMHgxYzANCiBydF9zcGluX2xvY2srMHgzOC8weGIwDQog
eGhjaV9pcnErMHg0NC8weDE2ZDANCiB1c2JfaGNkX2lycSsweDM4LzB4NWMNCiB1c2JfaGNkX3Bj
aV9yZW1vdmUrMHg4NC8weDE0Yw0KIHhoY2lfcGNpX3JlbW92ZSsweDc4LzB4YzANCiBwY2lfZGV2
aWNlX3JlbW92ZSsweDQ0LzB4Y2MNCiBkZXZpY2VfcmVtb3ZlKzB4NTQvMHg4Yw0KIGRldmljZV9y
ZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDFlYy8weDI2MA0KIGRldmljZV9yZWxlYXNlX2RyaXZl
cisweDIwLzB4MzANCiBwY2lfc3RvcF9idXNfZGV2aWNlKzB4OGMvMHhjYw0KIHBjaV9zdG9wX2Fu
ZF9yZW1vdmVfYnVzX2RldmljZV9sb2NrZWQrMHgyOC8weDQ0DQogcmVtb3ZlX3N0b3JlKzB4YTAv
MHhiMA0KIGRldl9hdHRyX3N0b3JlKzB4MjAvMHgzNA0KIHN5c2ZzX2tmX3dyaXRlKzB4NGMvMHg1
Yw0KIGtlcm5mc19mb3Bfd3JpdGVfaXRlcisweDEyOC8weDFmMA0KIHZmc193cml0ZSsweDFjMC8w
eDJmMA0KIGtzeXNfd3JpdGUrMHg3OC8weDExMA0KIF9fYXJtNjRfc3lzX3dyaXRlKzB4MjQvMHgz
MA0KIGludm9rZV9zeXNjYWxsKzB4NWMvMHgxMzANCiBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3Au
MCsweDRjLzB4ZjQNCiBkb19lbDBfc3ZjKzB4MzQvMHhjMA0KIGVsMF9zdmMrMHgyYy8weDg0DQog
ZWwwdF82NF9zeW5jX2hhbmRsZXIrMHhmNC8weDEyMA0KIGVsMHRfNjRfc3luYysweDE4Yy8weDE5
MA0KDQphbmQgdGhlbiBJIGNoZWNrZWQgdGhlIGNvbW1pdCBsb2cgdG8gZ2V0IHdoaWNoIGNvbW1p
dCBpbnRyb2R1Y2VkIHRoaXMgaXNzdWUuDQpJIGZvdW5kIG91dCB0aGUgY29tbWl0IGlzIA0KY29t
bWl0IGM1NDg3OTVhYmUwZDM1MjBiNzRlMThmMjNjYTBhMGQ3MmRlZGRhYjkNCkF1dGhvcjogQWxh
biBTdGVybiA8c3Rlcm5Acm93bGFuZC5oYXJ2YXJkLmVkdT4NCkRhdGU6ICAgV2VkIEp1biA5IDE3
OjM0OjI3IDIwMTAgLTA0MDANCg0KICAgIFVTQjogYWRkIGNoZWNrIHRvIGRldGVjdCBob3N0IGNv
bnRyb2xsZXIgaGFyZHdhcmUgcmVtb3ZhbA0KDQpBbmQgdGhlbiwgQWxhbiBTdGVybiB0b2xkIG1l
IHRoZSBiYWNrZ3JvdW5kIG9mIHRoaXMgaXNzdWUuIHNvLCBJIHN0YXJ0ZWQgdG8gZG8gaG90cGx1
ZyBvcGVyYXRpb24gb24gbXkgYm9hcmQgdG8gc2VlIHdoYXQgc3ltcHRvbSBvbiBteSBueHAtbHMx
MDQzLzYgYm9hcmQuDQpBbmQgdGhlbiB0aGVyZSB3ZXJlIGxvdHMgb2YgZGlzY3Vzc2lvbiBmb2xs
b3dlZC4NCg0KVGhhbmtzLA0KTGltZW5nDQoNCj4gPiBUaGFua3MsDQo+ID4gTGltZW5nDQo+IA0K
PiBTZWJhc3RpYW4NCg==
