Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5BA49;
	Tue,  7 Nov 2023 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="NekzaLxW"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E97184;
	Mon,  6 Nov 2023 19:08:24 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A72ocla018074;
	Tue, 7 Nov 2023 03:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=OpUTbINtmosOH/bP+2e2vExUDUcl1VLWhPi00kRTsAM=; b=
	NekzaLxWfY0Cqb9dVZBc5xPNJcr3yCehC9qH1U3e5vZiuU7lPOvyTkm27ohBRdzd
	sXFlS/z/HjXB2Z3nj50FRR5MWMAyF+F1KmiiB1pvTCCeSZhtg2M6tZix8QskXsHX
	TlAtvg1x8/zBUhGb1DwDHxKtqqvo+bJZYKirBHoHKDQhgWpvDvSh8X1CEn1F+g5A
	OG+yDmTDJ7xZcT/Xq8uAjNHZSeo9vubsR9rXJU3oz7dxxam9nINBzxGCOUQEhn9m
	hc8z1RWvh17ALkNRaA/lNs+SnRGCw4a0zX1zOtUEURtj3FiFw5p1lvv20qwjPGNG
	yyZaS3TJcjJlreNLAX3mBg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u5b5x2c3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 03:08:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiL+B07JgxMNPqsyjdar6jYQD2QJM2SybElAR3EgpJxKk1fkdR/ojDojmKSbT5+BDi2mNpIdJtRp8M8um8qUaF22vkfWhKyj++NVapPc1ho9Beq2lsRRbJQzLSVeKn8NK+R2DLcuNCPQ9t8W/dLe59aU50zbRJdtiR9RTdkfh6+ibubpahAqYo7Ulo77IUhQzikZmOLL8GNdxHU3xSx8R9LbimBaRKlGt5ReDiQrTHeY+xI23AtLfTjNFU5hLryFu1R/lB38Ce2rgBIBXyw4R88YDxUtRjdBQOkOly1HqpOOr2U3E5gSLo+U3GKP5wqOEsTQfsgL0I7cwRYyVpNSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpUTbINtmosOH/bP+2e2vExUDUcl1VLWhPi00kRTsAM=;
 b=ZXgm99jLsl6Ea3ztIPeLmcY38Xov4Q0/dBBZ+fmvA/6k3LccWvSJk9mQ1ONd7f69uyJAxKOSiyYgc70i8MageaRi+M6PkS1u4Qjek3UqQZGVa4aW8/H0bXy+YLFoi8h7/tOi4UQwPu5ebmqqFJvBYb702UUkkx2u3aBh0NoLEfeU9imLoYHscUeSO2M0G6FnNlX+VErYP7GHhbhofDTSg4gQD+sDIJWblSdOuXTuGwpAxEAHw5i3XrurBnQaURMX8pnLF++JSlF4iM2DVsZ8QxmdFae7KRylpMegsTXB0sA5z6x6rk9GBBCrRgehiRqsqtIEFUb3jQw0SVbYyNUaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by DS0PR11MB7971.namprd11.prod.outlook.com (2603:10b6:8:122::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Tue, 7 Nov
 2023 03:08:13 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f%5]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 03:08:13 +0000
From: "Li, Meng" <Meng.Li@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt
	<rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        USB mailing list
	<linux-usb@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: RE: RE: RE: USB: add check to detect host controller hardware removal
Thread-Topic: RE: RE: USB: add check to detect host controller hardware
 removal
Thread-Index: 
 Adn9i9LFJguVckBOQnaI1KZe5N8FAAAbV+4AAJYf4gAABSReAAAOS6qwABjp6YAAHiq+0AAWuX8AACyeyIAABUsdgAAAoHwAACaVFgAAC20/gALBAh8AAApVjQAAcXa+cAALyDyAAABJdoAAASRdAAAljb5Q
Date: Tue, 7 Nov 2023 03:08:13 +0000
Message-ID: 
 <PH0PR11MB51911F20E4AE1E1FD8D25FFCF1A9A@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
 <20231103154624.WEWPMHTp@linutronix.de>
 <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
 <PH0PR11MB5191B5D71DBD450210E2BEDFF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20231106082829.iBvQ9hCY@linutronix.de>
 <PH0PR11MB519187340D0C1AD3F05DC74CF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20231106090924.3qeWpk98@linutronix.de>
In-Reply-To: <20231106090924.3qeWpk98@linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|DS0PR11MB7971:EE_
x-ms-office365-filtering-correlation-id: 3ec6ffd9-4f45-4857-b873-08dbdf3ec798
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ILiGAQKRn81PkC4pCDReulJc8qBHz0WVDEP5UTncSb8y+3PUywuMDaejlw4xkUGgGuwozH6OSs1Y+LYsi/j6hYc/b822IoOisToixN3VP5N8ebxwWjCzCncvFHu3FOIUSBti8b2mVrqhPX8sfdR2zs7uhY2cwkjTKFFnlJA74R5r1HwytpvodVbUdf7siUg1xRPfOdOKFbTZH4WFT0FDKExnpRHGwwadq7YXs7CpMsDUiihvb4xMljY8m0bpu4AmStGwGM5wfEReHAXtBvXPyhpo69VxPfrCGPd7ylkVONMVHmmCnjlD+SlzWqBmqgtThkxuCMI6HsoW5VnKOsZE8Iy6/keGK7b8HC18dQRu4nAQ2d52L/UOfQQOkxQ8X3ov9e4IgWZBi1tNKnWvdCqHuPuMEdoBYfRKqFrvXtWTrY4v89LnKDF6Hari3olwZLjPKIneMiU3R/zf8Da02JZbuyeRnn7vSbLHLHw5+E+JQEUhdH7JVBmTEQEo8vgJR+LEcTEneVMVUjjp9VVyPtlUtZ1719+Yb24qJxdRHY9INBb6rM/pReePP6VLSJTJnIsCoaLPi3i29SvCG4QAPBketecjEVfKnf6F85t5NGCq9XThEHUF8j2I+IwWrUHNjIGBKZXZ237edNtzrgMHiOGiDDT4c3FRSEpK1j+YoD8OafE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39850400004)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799009)(186009)(64100799003)(66446008)(64756008)(55016003)(54906003)(66476007)(41300700001)(2906002)(4326008)(52536014)(5660300002)(38070700009)(8676002)(6916009)(8936002)(122000001)(33656002)(316002)(66556008)(7696005)(53546011)(86362001)(66946007)(76116006)(38100700002)(26005)(9686003)(6506007)(478600001)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SGNrQmRrQmlqdVlieU1WbWVkSDJjSEJ2TUFTai9xNW41M3htUGsxMmNXRTdo?=
 =?utf-8?B?amQvNnYyU3hzaldua080bWNZZjI3M0ZrL0lWNU9YeU12VytRbVFtMEw4enZU?=
 =?utf-8?B?TTBkSUhwZnNoRzJGcXBxTUgrdVpERXZIYVR0UlJ6c0lHZXZHRlFWcWl2OXVZ?=
 =?utf-8?B?MWZQRHhjOFNHZE9ndVVlZjlIRTEvL0lVMVFXNG1Ld05oYVJNR1FaTFNpekRm?=
 =?utf-8?B?WjhCd3hpMktVaGZMY0lDby9lWHFtZk9yUXM3ekVJOWFHRVQ0cWVjNlFPSkdn?=
 =?utf-8?B?OGhIVzZpT3czWGtIb3pYTXNuZEZMUTdqYTBxYjBjTWZ2VGFMKzkrVklycTdp?=
 =?utf-8?B?TkNad2VWbWduajdmSWJ2YitUaXBMa2lTbEp2Zm13bmwrSDZxZlFwZG9LVTdP?=
 =?utf-8?B?VnRuV3dNb0VGM21uQkp3U04ya08wSkVqWDFqQnlDbzJjUGJvRjJiZ2w0ZVlU?=
 =?utf-8?B?ZE5RUFFCQVp4ZkQyaWkyVC9LSUxCSkRzRFNVb3FNS1czNC8vQnZxQjI3aTJW?=
 =?utf-8?B?cUg0SXo1YlhlUE9MOFBQWXIzS3RvMmdQUlhWKzNzZVdWcndhbjFIVzFseVVi?=
 =?utf-8?B?UHBsUkJCSmE2aFZDb1F4UW9wdk5MRENkZm5OenVMaElSVWlWT09jaXVHU1Nk?=
 =?utf-8?B?S3pwVm1VSHhkOHovaE5LSXVvcWtqWmEvd21xTHdESWJ1VzZTSGlNR1BYUFI5?=
 =?utf-8?B?eVA2UzllVGUzRHEvelNFZFB1bDBRblNOVW9ZRGNpK29FR3BkSnlXQktVMWpz?=
 =?utf-8?B?V0hURXlHdmI0dHcvZ1VYVHFvUkRwUnlBUmlqWlV3QkF5OTRrejlieWRraXlm?=
 =?utf-8?B?TnhjSmtoalFvOE8vUUZlOU4zTTNUdXBubjdBQ29KWktzVlFtU2NKWDhNcUdk?=
 =?utf-8?B?cW5WV0lpMGo0NUZkc2xCM0JxM01aYjM3aDB4d3YvZU1Sclh6d3JvTXZWR1RO?=
 =?utf-8?B?WURrU3d6NENDdWNEUnNTTXBwM21GNXZWaHRoY1hpRUF5Z1JuZEphbExtNGRs?=
 =?utf-8?B?bTB4RmYxa25DTk5TRkduVUN3a0VUYzh5MUJ6Z0NFZ2Q1TXNGUmdTamtJcFpz?=
 =?utf-8?B?SmJjNkE0ZG1kTFN3eG1rM0VPeXMxbUEyTmdCNm9GYmhyaktjcXMxajI0VWMr?=
 =?utf-8?B?V0tCeFVSeld3WDVidGZEdEVScmJLdEZ0a3drU2hQNXE3WlBHVXk0MVVqdFNW?=
 =?utf-8?B?SDN0cjE0TDEzZmU0K20vWWl1WFMzbytiMG1oUCtQMllnYy9ob2tmUG9KOGhH?=
 =?utf-8?B?U2JTL0tGcndRSHZCcXBicnFrVkJ5d1A1eFhhSStDM2xleUFWWkRJTHBSc2Vt?=
 =?utf-8?B?N1ZxN1ZpTitocVVQcTJKeGY4MHo2WFVmRmZ1R2JxRk4xWVFKa25rbGM4NlNU?=
 =?utf-8?B?azIzNlY1UlBuUTYzVGdITjFZdXJiZ1ZmckRnM0JwaXZBUURibTRQb3NoZVhs?=
 =?utf-8?B?NndvTkwvUXFLZlR4bVUrcFRXSE9pNWFoSWtZRENUT3p0U1lmSnVoZXc4QlN1?=
 =?utf-8?B?Q244WXRRVTFYTFExS1Uwd24ybmdOWkswN1lEWFhScXdUVURZRmd2aTcwTnlG?=
 =?utf-8?B?YldSWm8wa0tXNGUwbGcvSUE1bFc4bGNiN1NMWWNyQWdCbWhpRk9vQlI3anhl?=
 =?utf-8?B?RkhhYmNIYzZ2MTU0Y0REL09pTll0bUJENkFQRzVXZ2ZLZXdidzI4YVcvZmNN?=
 =?utf-8?B?aTN0a3ZKOUlYTFptWDhOVm1RT0czQjE2WGMyb25YWjRIRzh0ZFlQWUx5Si9W?=
 =?utf-8?B?d1pUdzJ5ZjJIelM2YkVJWExJcFNxV2tBRnQxOG5UME81eEI5MTFHakp5T2xP?=
 =?utf-8?B?bHRaNG53THJaRmNHYWVKWERNWXVDUXRmM3k3cTY0WG11TjJaUEZLUm9JNXRT?=
 =?utf-8?B?aW5oc08waThSdXV6VDJKU3lMODVXUjhza2JPYzNIVU5IdW9NczduUkd4TmtP?=
 =?utf-8?B?SnNocU5OWVNiMytIaEpmY2lIK0ttVWprWEt2cHlWRDFGV09icnAyTFBYUHo0?=
 =?utf-8?B?ZzZUYVNEQmZqOU42MkdYQklLYmNLK3padjhUVFVoYTlIZWVLYlVPU0FrYlA3?=
 =?utf-8?B?bUpOUWdEK1NyUHpBL3hKcWFTcWpweVNnNGZuejB3YmJ1MzdUTmdMbStDdDdH?=
 =?utf-8?Q?KDbDWafsnqQkEcIfBsZcYmBU1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec6ffd9-4f45-4857-b873-08dbdf3ec798
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 03:08:13.2200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nP41fkVqVKY/ibIi59xfYG+s9HkuOgzCIUc0mFfMrT7UPK2Q32vjiHhohsifn2kkuhvXJvsklDIKaL/UT/XlIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7971
X-Proofpoint-GUID: nD4enpA3C84AB7jexoiaYte2uNexnk5w
X-Proofpoint-ORIG-GUID: nD4enpA3C84AB7jexoiaYte2uNexnk5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=851 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2311070025

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ViYXN0aWFuIEFuZHJ6
ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiBTZW50OiBNb25kYXksIE5vdmVt
YmVyIDYsIDIwMjMgNTowOSBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNv
bT4NCj4gQ2M6IEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+OyBTdGV2ZW4g
Um9zdGVkdA0KPiA8cm9zdGVkdEBnb29kbWlzLm9yZz47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRo
YXQuY29tPjsgVVNCIG1haWxpbmcgbGlzdA0KPiA8bGludXgtdXNiQHZnZXIua2VybmVsLm9yZz47
IGxpbnV4LXJ0LXVzZXJzIDxsaW51eC1ydC11c2Vyc0B2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBSRTogUkU6IFVTQjogYWRkIGNoZWNrIHRvIGRldGVjdCBob3N0IGNvbnRyb2xsZXIg
aGFyZHdhcmUNCj4gcmVtb3ZhbA0KPiANCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBjb21lcyBmcm9t
IGEgbm9uIFdpbmQgUml2ZXIgZW1haWwgYWNjb3VudCENCj4gRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQNCj4g
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gT24gMjAyMy0xMS0wNiAwODo1NDo1MCBb
KzAwMDBdLCBMaSwgTWVuZyB3cm90ZToNCj4gDQo+ID4gVGhpcyBpcyBub3QgbXkgb3JpZ2luYWwg
aXNzdWUgdGhhdCBJIGVuY291bnRlcmVkLg0KPiA+IEkgYWdyZWUgdGhhdCB3ZSBzaG91bGQgcmVt
b3ZlIHRoZSBkZXZpY2UgZnJvbSBzeXMgaW50ZXJmYWNlIGZpcnN0bHksDQo+ID4gYW5kIHRoZW4g
ZG8gaG90LXBsdWcgYWN0aW9uLg0KPiA+IE15IG9yaWdpbmFsIGlzc3VlIHdhcyB0aGUgY2FsbHRy
YWNlIG9uIFJUIGtlcm5lbCBpZiBJIHJlbW92ZSB0aGUNCj4gPiBkZXZpY2UgZnJvbSBzeXMgaW50
ZXJmYWNlLg0KPiA+ICMgZWNobyAxID4gL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMTowMTowMC4w
L3JlbW92ZQ0KPiA+IHhoY2lfaGNkIDAwMDE6MDE6MDAuMDogcmVtb3ZlLCBzdGF0ZSAxIHVzYiB1
c2IyOiBVU0IgZGlzY29ubmVjdCwNCj4gPiBkZXZpY2UgbnVtYmVyIDEgdXNiIDItNDogVVNCIGRp
c2Nvbm5lY3QsIGRldmljZSBudW1iZXIgMiB4aGNpX2hjZA0KPiA+IDAwMDE6MDE6MDAuMDogVVNC
IGJ1cyAyIGRlcmVnaXN0ZXJlZA0KPiA+IEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZy
b20gaW52YWxpZCBjb250ZXh0IGF0DQo+ID4ga2VybmVsL2xvY2tpbmcvc3BpbmxvY2tfcnQuYzo0
Ng0KPiA+IGluX2F0b21pYygpOiAwLCBpcnFzX2Rpc2FibGVkKCk6IDEyOCwgbm9uX2Jsb2NrOiAw
LCBwaWQ6IDc2NSwgbmFtZTogc2gNCj4gDQo+IFJpZ2h0Lg0KPiANCj4gPiBhbmQgdGhlbiBJIGNo
ZWNrZWQgdGhlIGNvbW1pdCBsb2cgdG8gZ2V0IHdoaWNoIGNvbW1pdCBpbnRyb2R1Y2VkIHRoaXMN
Cj4gaXNzdWUuDQo+ID4gSSBmb3VuZCBvdXQgdGhlIGNvbW1pdCBpcw0KPiA+IGNvbW1pdCBjNTQ4
Nzk1YWJlMGQzNTIwYjc0ZTE4ZjIzY2EwYTBkNzJkZWRkYWI5DQo+ID4gQXV0aG9yOiBBbGFuIFN0
ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KPiA+IERhdGU6ICAgV2VkIEp1biA5IDE3
OjM0OjI3IDIwMTAgLTA0MDANCj4gPg0KPiA+ICAgICBVU0I6IGFkZCBjaGVjayB0byBkZXRlY3Qg
aG9zdCBjb250cm9sbGVyIGhhcmR3YXJlIHJlbW92YWwNCj4gPg0KPiA+IEFuZCB0aGVuLCBBbGFu
IFN0ZXJuIHRvbGQgbWUgdGhlIGJhY2tncm91bmQgb2YgdGhpcyBpc3N1ZS4gc28sIEkNCj4gPiBz
dGFydGVkIHRvIGRvIGhvdHBsdWcgb3BlcmF0aW9uIG9uIG15IGJvYXJkIHRvIHNlZSB3aGF0IHN5
bXB0b20gb24gbXkNCj4gPiBueHAtbHMxMDQzLzYgYm9hcmQuDQo+ID4gQW5kIHRoZW4gdGhlcmUg
d2VyZSBsb3RzIG9mIGRpc2N1c3Npb24gZm9sbG93ZWQuDQo+IA0KPiBPa2F5LiBJIHNvbWVob3cg
bWFwcGVkIGl0IHRoYXQgeW91IHRyeSB0byBhZGQgdGhpcyB0byB4aGNpLg0KPiBUaGUgc3VnZ2Vz
dGVkIHJlcGxhY2VtZW50IHNob3VsZCBjb3ZlciBpdC4gQmV0dGVyIGlmIHdlIGNvdWxkIGdldCBy
aWQgb2YgaXQgOykNCj4gDQoNCmdlbmVyaWNfaGFuZGxlX2lycV9zYWZlKGRldi0+aXJxKSB3b3Jr
cyBmaW5kIG9uIG15IGJvYXJkLCB0aGVyZSBpcyBubyBjYWxsdHJhY2UgYW55bW9yZS4NCldpbGwg
eW91IGNyZWF0ZSBhIHBhdGNoIGluIGxhdGVyPw0KDQpUaGFua3MsDQpMaW1lbmcNCg0KPiA+IFRo
YW5rcywNCj4gPiBMaW1lbmcNCj4gDQo+IFNlYmFzdGlhbg0K
