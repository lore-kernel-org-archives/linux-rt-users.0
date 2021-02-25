Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B456C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Feb 2021 02:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C8464EC4
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Feb 2021 02:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhBYCcI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:32:08 -0500
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:24288
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229722AbhBYCcH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Feb 2021 21:32:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2yF957/3qqaj9aziQY5tI/IBvD3cw+nmkodTU3qgOaH41jG7PQRhr6MzONdyDp8XWEovDRji6LzRl2UbPMA/9eGucZCSInqkEIRpuxsUiaQdld7ExxgSF5hJ8GFY0mHt4oi9CN3EgJeBJpUCALM66Oo0s6Ddqv4MM0H3zPkCSU8GI/dpO3QsO55+1HZPLhTPRfFeQWHjqzfZa1dK8hDtVQrLLFEhruz1CdKOIXQfS0JVqvzTqv6SqzYr8yA8sccFmDA3K/AxJvv3KHAH1i85fWky0Xf9ekPxhkC/wGTl0y6GaK9QNRRGtWbiq06YEVfV2pRB1S3yMDZIsoTa2BLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc6spen/i7CzW6/w66nJQVtOm7mNgyUAn6tS8yaAVnQ=;
 b=AsZOnZbGqC1Ch4U9rM2iYZqoM1f7tLM1ADoYGMztWJaxU5hVR7GqZYxaIfuxxWkqfEEbi20gbqcfiP1nNTxru7q0gVPU1k+qAsNyT8SSFEEna7StJQj4X5sKouXYZ5weMR72VhAxcExKVGE2Ps8TXsPYkPQEYMt+pf1cv+jNTKJPs6WVLZj7ptitNIHfne82u5K/g5bv9b6xbANIFhhBEfKEvvGhIZMTjwpSCa0FiYSCpilF1n1SvrNDcsdBIJhpHpPNqlEO/IsHmAkIGvD72eiMsWvJAMkIMY99CbnfAQdeTYJcNE3mNQZyAi54yL6/AYB8zMTSifSpF3BO0rq91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc6spen/i7CzW6/w66nJQVtOm7mNgyUAn6tS8yaAVnQ=;
 b=mDQgnfkZ73Dnbk+pPTNXrgAGzMQXznIQd8gR+H5zYtqOLrq2j0zlGUms6ZCvRSoA+9REtrj5X1S8+8QSv76XIS/rfvvKd+PaNM3LoidboL37VgjfNpq6kLeZIzfRbQ4FpTZ2N3bByT7cWIfLdcHUFEvzwtc6m8QonIXmdDK9ZOw=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM6PR04MB4968.eurprd04.prod.outlook.com (2603:10a6:20b:7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Thu, 25 Feb
 2021 02:31:18 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::b4f2:d00e:93a1:8685]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::b4f2:d00e:93a1:8685%3]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 02:31:18 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Sebastian Siewior <bigeasy@linutronix.de>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH] rt: cpufreq: Fix cpu hotplug hang
Thread-Topic: [PATCH] rt: cpufreq: Fix cpu hotplug hang
Thread-Index: AQHXBppW83xUVC3dLUCScJ+gOFcU4apkOSCAgADNkPCAAA+5AIACcySAgACk7qA=
Date:   Thu, 25 Feb 2021 02:31:18 +0000
Message-ID: <AM6PR04MB5413EABA6643AA035183DDDEF19E9@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20210219084420.23379-1-ran.wang_1@nxp.com>
 <20210222140107.qk2ymlwyyxspluge@linutronix.de>
 <AM6PR04MB5413DB3654A87D50C909004CF1809@AM6PR04MB5413.eurprd04.prod.outlook.com>
 <20210223031308.rjwswy5whejrme43@vireshk-i7>
 <20210224163745.5lqhnjviznsjojtl@linutronix.de>
In-Reply-To: <20210224163745.5lqhnjviznsjojtl@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 426dc40b-b7c7-4ef5-3e65-08d8d9356e76
x-ms-traffictypediagnostic: AM6PR04MB4968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4968FB721C18511ADB166E1AF19E9@AM6PR04MB4968.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0o9an8nghiSA0cMOXY4nejAf/saTAbJfTBKDwd5VEe00d9ZUNveiE1hiirVRE7uPUyXogWIJnHVAEBWEgGH1/KiFOlzPgF0xE/ZLfZjWZHjkesOETwPm1lvI6YPYFU4gnEx/YSOFtBCMhdFMqGla//8jCVGRTbhvA2MRkCcF/6QcMDYfi0+fpWiKwCilITbzv9wPCAg10Id2D+pXnQnt+5LBxznaisU6wx8HfSsTgDpw0wEoI7FNRGVm8VNEUJH2VtYJILUJ83NDiaoQCd4G2dxwIaTpmt7/eYVNQrPzOk1FEMa8mwD8GwQ7nr6D+EmOms2sa0UZ6cM1seerMeL+Qu6ANMnRKkmHNzLCKYgygdIULNcR5NjOA73hYJA8LUtvqgdXVxtj1v5ebShCUl/HjKRqqGq6SQ/E/uaTQDTLFpDSyOzNXsTPnzd2Eyzr/lrp+zcd1mEKXxWJigL9TChBrlljHrVduU9tGEr1iRk9HyQ7SUDUD/rzCfAAWMqSdARVMjSQZtDLtewdEYqMPGII/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(64756008)(7696005)(86362001)(4326008)(66946007)(66476007)(33656002)(66556008)(316002)(76116006)(66446008)(54906003)(2906002)(6506007)(6916009)(8936002)(478600001)(55016002)(9686003)(53546011)(71200400001)(5660300002)(83380400001)(52536014)(186003)(26005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c2VGaGRvd3ptSEl1a25uTXFxVnVrM3J2aWtpdEkzdmFXNzY1Tzl5UnNHMkln?=
 =?utf-8?B?RVJoRU1oRGZCRkh1ekcxU0RiWTNtcDFBRXdJTVFXRWIrM1lXOE1xcy9NSjhm?=
 =?utf-8?B?em1sL21xLzh1ckNlUnJTYTBYdkRqaDEwKzlUVFJoK1duSnZJV2YzZGlhcDAy?=
 =?utf-8?B?M2RuU3N2QkEyb09ZSmFFQnFPUmR4Y1p0ZU1UVGxlZFFRUEtoRXQ1MDR0VGpD?=
 =?utf-8?B?c3lDTnA4dERiMzRjUGkxNkx6OE1Za08xNzFzR0hNNzhUSXNtMmVpNzFMS0N0?=
 =?utf-8?B?em9DYk56K0oxVjlDbkdTaWJ4RHpMTHJMTWFoank4QTAxQmpBU3BVdG1QeStN?=
 =?utf-8?B?a2c2MlA1MXhXa0dQemNNbFZyVDBiUHRCYUZGR0puNnZaeEUxdTJ3eXlKeVFs?=
 =?utf-8?B?aldQUzVTRUl4WWZDOHJEeEJoQjkyN01KejN5RnpzQVlpTEZYUEdwVHpad3Zz?=
 =?utf-8?B?WE1jekUxUVdQM2lZSXpkSUc2TXhkeG0rOEM5NkU2WllBRFZNdkVUVDBsWGx2?=
 =?utf-8?B?azdES2ZpOWpubG1SNHpmRnV1OFBkNlZLVXA0TXVpQmMwVzlMQnBnMnRzS3o3?=
 =?utf-8?B?L29iS3NhblVaalFITklwb09CQ01oRlhaSC9KSk9Dc2IybnVpcm5Wd2FaS2JU?=
 =?utf-8?B?Q1luLzZGcVViakxVYW1pWk1aN01tU3kxMWZ1c3N2L0Nxa1llT0M1UGkyK3J2?=
 =?utf-8?B?djlHN2dZamJrWXJxbXBJUHlUck4yaFo5Yy9YR2l5bWVSQStKcWlSaS9IUmhI?=
 =?utf-8?B?cjR3OGhBakZzNFFWM3ViTHZ3QXFWOFpCdDg0SFdFU0VTTHZ6VC9qZzhwdDZt?=
 =?utf-8?B?d0RLaTZKUUZXZmQwRG1lb0IvZmZUbitjT0VFYVpiaEUrdFhGa1BOWXYwU2Fi?=
 =?utf-8?B?ZzQzTGloVUR2YitDQ0oyMENsNlZoSjQ3aklnOVJyb080d2hCNkZpanQ5eGpv?=
 =?utf-8?B?cEhCbnlBR3BEZU41cVY2RHZRV1Q2bWR0bFl2V2orSmpWOHV1THlteDJmK1BZ?=
 =?utf-8?B?d1JkS3Q4UG9NVEw2cndXOENXZXVaQWFzZm9OU0RNT0pEaTJLV1dBRUdJRFBi?=
 =?utf-8?B?Q0lxTXRjZXh4bU1Wb0d4VS9TNW04Q3c2TXg1TlRCc1JYUVpkL3o1TWJod2hH?=
 =?utf-8?B?TGhybHc5VEo0Tk1EZ3h6eG9ScDMxNlNsWExPaStSdmFUeWd4RW96STR4bjk5?=
 =?utf-8?B?bHBwRWlJcngvMEZIMlFKSEQyQ1dEdy9lc1UzMkFhVlZVYjhncG5yc1V0YlJx?=
 =?utf-8?B?Um8xSk9IRzZXdVFUbjdMN2RiOUdnc3ZHcHhkYzNnUTlWbXNwWHp3TXg1dCsy?=
 =?utf-8?B?dWVlQ0FTTXJQazJaZ2p3ODdKcEs5dEMvazFqL2pRUEpNNUlFOFBmRkNSNmln?=
 =?utf-8?B?cC9iUzY4K1FTYVpnRnU4ak1FcFNpVmVrWXFocU5YdFd3aDZTNERqVElNZVZJ?=
 =?utf-8?B?SUZrUU1OTk9hTFRINlhIQ3p3dSthYmZoUkhRNU96WGVmZDZJMlpkS1hiemFE?=
 =?utf-8?B?OS9iSFJ1dVM2ck55UWtqWkJ3NUZEMXd2NFpqWTZ4a1JwbUd0L0Viazl4cnVt?=
 =?utf-8?B?L05CUllhNlNTdk9WclFjVXFoZjR1cmcrbndiaGh6aGRrM2ZpQ1BINVNZaGJm?=
 =?utf-8?B?V3hVRnhBTWN2Ty9McTE1N2VpNlE2S04va0NnaHFaQi9lYUt2QTJJcnNBNW9B?=
 =?utf-8?B?c21QV3RwOWllTHdUVUZlUENsa2d3RlRzZ3ZrVTdycTRsbXBWQWlCNmkyWExq?=
 =?utf-8?Q?0BxX9YTMZNsLKt9POcKwoEH0wSXOsPLKvLsBX/4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426dc40b-b7c7-4ef5-3e65-08d8d9356e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 02:31:18.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yb+pvo+mxzx5P7iOjvXJd1XilyQvFaHDyHcGQ3uahXW+r/lumDxcP3JbNYfK55BeOvf79S2gC4za9ismhvD8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4968
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgU2ViYXN0aWFuLA0KDQpPbiBUaHVyc2RheSwgRmVicnVhcnkgMjUsIDIwMjEgMTI6MzggQU0s
IFNlYmFzdGlhbiBTaWV3aW9yIHdyb3RlOg0KPiANCj4gT24gMjAyMS0wMi0yMyAwODo0MzowOCBb
KzA1MzBdLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+ID4gT24gMjMtMDItMjEsIDAyOjI2LCBSYW4g
V2FuZyB3cm90ZToNCj4gPiA+IE9uIE1vbmRheSwgRmVicnVhcnkgMjIsIDIwMjEgMTA6MDEgUE0s
IFNlYmFzdGlhbiBTaWV3aW9yIHdyb3RlOg0KPiA+ID4gPiBPbiAyMDIxLTAyLTE5IDE2OjQ0OjIw
IFsrMDgwMF0sIFJhbiBXYW5nIHdyb3RlOg0KPiA+ID4gPiA+IFdoZW4gc2VsZWN0aW5nIFBSRUVN
UFRfUlQsIGNwdWZyZXFfZHJpdmVyLT5zdG9wX2NwdShwb2xpY3kpDQo+ID4gPiA+ID4gbWlnaHQg
Z290IHN0dWNrIGR1ZSB0byBpcnFfd29ya19zeW5jKCkgcGVuZGluZyBmb3Igd29yayBvbg0KPiA+
ID4gPiA+IGxhenlfbGlzdC4gVGhhdOKAmXMgYmVjYXVzZSBsYXp5X2xpc3QgbWF5IGhhdmUgbm8g
Y2hhbmNlIHRvIGJlDQo+ID4gPiA+ID4gc2VydmVkIGluIHNvZnRpcnEgY29udGV4dCBzb21ldGlt
ZXMuIEJlbG93IGlzIG9uZSBvZiBzY2VuYXJpb3MgdGhhdCB3YXMgY2FwdHVyZWQ6DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiAuLi4NCj4gPiA+ID4gPiByZXRfZnJvbV9mb3JrDQo+ID4gPiA+ID4gIGt0
aHJlYWQNCj4gPiA+ID4gPiAgIHNtcGJvb3RfdGhyZWFkX2ZuDQo+ID4gPiA+ID4gICAgY3B1aHBf
dGhyZWFkX2Z1bg0KPiA+ID4gPiA+ICAgICBjcHVocF9pbnZva2VfY2FsbGJhY2s6IHN0YXRlOiAx
OTMNCj4gPiA+ID4gPiAgICAgIGNwdWhwX2NwdWZyZXFfb25saW5lDQo+ID4gPiA+ID4gICAgICAg
Y3B1ZnJlcV9vbmxpbmUNCj4gPiA+ID4gPiAgICAgICAgY3B1ZnJlcV9kcml2ZXItPnN0b3BfY3B1
KHBvbGljeSk7DQo+ID4gPiA+ID4gICAgICAgICBjcHVmcmVxX2Ric19nb3Zlcm5vcl9zdG9wDQo+
ID4gPiA+ID4gICAgICAgICAgc3Vnb3Zfc3RvcCAgLy8ga2VybmVsL3NjaGVkL2NwdWZyZXFfc2No
ZWR1dGlsLmMNCj4gPiA+ID4gPiAgICAgICAgICAgaXJxX3dvcmtfc3luYygmc2dfcG9saWN5LT5p
cnFfd29yayk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGlzIG9ic2VydmVkIG9uIExYMjE2
MEFSREIgKDE2IEE3MiBjb3Jlcykgd2l0aCBjcHVmcmVxDQo+ID4gPiA+ID4gZ292ZXJub3Igb2Yg
4oCYc2NoZWR1dGls4oCZIG9yIOKAmG9uZGVtYW5k4oCZLg0KPiA+ID4gPg0KPiA+ID4gPiBXaGls
ZSBzdGFyaW5nIGF0IGl0LCB3aHkgZG8gd2UgaW52b2tlIHNjaGVkdWxlX3dvcmtfb24oKSBhbmQN
Cj4gPiA+ID4ga3RocmVhZF9xdWV1ZV93b3JrKCkgZnJvbSBpbnNpZGUgaXJxX3dvcmsoKSBpbnN0
ZWFkIGludm9raW5nIGl0IGRpcmVjdGx5PyBJdCByYWlzZXMgYW4gaW50ZXJydXB0IGluIHdoaWNo
IGl0IGtpY2tzIGEgdXNlciB0aHJlYWQuDQo+ID4gPiA+IENvdWxkbid0IHdlIGRvIGl0IHdpdGhv
dXQgaXJxX3dvcms/DQo+ID4NCj4gPiBCZWNhdXNlIHdlIHJlYWNoIHRoZXJlIGZyb20gc2NoZWR1
bGVyJ3MgY29udGV4dCwgd2hpY2ggbXVzdCBiZQ0KPiA+IGhhcmQtaXJxIGNvbnRleHQuLg0KPiAN
Cj4gT2hhLiBUb28gYmFkLg0KPiBSYW4sIGFueSBjaGFuY2UgdG8gZmlndXJlIG91dCB3aHkgdGhl
IHNvZnRpcnEgY2FuIG5vdCBiZSBzZXJ2ZWQ/DQo+IGtzb2Z0aXJxZCBhbmQgdGhlIHRpbWVyIHNo
b3VsZCBiZSB1cC4NCj4gQW55IG51bWJlcnMgb24gaG93IG9mdGVuIHRoYXQgaXMgaXJxX3dvcmsg
aXMgc2NoZWR1bGVkPw0KDQpTdXJlLCBsZXQgbWUgYWRkIHNvbWUgdHJhY2UgZXZlbnRzIHRvIGNv
bGxlY3QgbW9yZSBpbmZvLg0KIA0KUmVnYXJkcywNClJhbg0K
