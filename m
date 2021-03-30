Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA64C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Mar 2021 05:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C6D6192F
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Mar 2021 05:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhC3FYn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 30 Mar 2021 01:24:43 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:7297
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231192AbhC3FYP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 Mar 2021 01:24:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnRZT0aX2ZF3oc+kWVxbXJpl5KZy6YdP4D6izFix9YBAJo6Qi4Qg7rE/mF3dOItc2i+g8SOYdZQcNfMzDoWffBx9a0TRTeLDkfErJb/J60K+ivA45xfg254zmvTitmzNzBTjkNzELf9rB+hub7hSaa/S90YoamnvxiPslkfFbObMuC2Z7olFG8d5r6rlvLUxohBuLpINIcKuuJvS7o374yAAZWHZ3pL2OxABHwr20IX7OLKe0dyW6BhklsIvGZz1COcH9ep5j3lNcK5Vgf/SL6rvmm8Iyv4B+4imUnY3neakiflOUzbUQJ6o2nJ1yPT/yovUrtKhxOFZFLCPqhFHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgLegZCyD3CyDL3suTIRoWMA+WPzStpsq862LSqWjXA=;
 b=YsQNFdyYgCQaXulDrtmfJlJteLG+a+/IbsBBh2wmlLYTlN8DNXDbTC3BLuXtscWJDd5TutVQg4fHNQshyaShy/h5oYNK/hemzPt1S/mZ8DlWQPhrEOKTjBZtv2qNMviAaXd5/M3X4KhOoRPLKKH9PSZKroEmngrHIZEEfuINecWuyapPM9BQEbRtuhmFOefi9NU4RMjhgnvDQ4G/IOVn5UbONGy3ONYxFKYILgkchHhEg9lDMgX8irFf8cmQ97NqQPkgD9xDvewbdAZ0LhvR4exywCBOE1TZAsicsQRw7xrL7HOuIod0jrjzawNh68llmYfrzExGNm5xAh1AfEGnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgLegZCyD3CyDL3suTIRoWMA+WPzStpsq862LSqWjXA=;
 b=WtUrOMBdYJ6oDrOBSGfWuKnbuveXao9L2/6FB65kG9TzLLlHIBhyKSzhsaFw0NJ7KNretAKeLXNGNiI/LqdxuWSBm1Sod19/qvzr+lUmpBGL4I8aDAKmZOxXu/yvGjBwlIKLgNwfARk//mubMSegYxv1/q/EQwlx3XrhyFFmCkg=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AS8PR04MB7879.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 05:24:13 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::397c:7653:9a9b:a577]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::397c:7653:9a9b:a577%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 05:24:13 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: RE: [PATCH v2] rt: cpufreq: Fix cpu hotplug hang
Thread-Topic: [PATCH v2] rt: cpufreq: Fix cpu hotplug hang
Thread-Index: AQHXJRH5jNkqQNzTc0CKkEQYgBe0fKqb9QcAgAAGTKA=
Date:   Tue, 30 Mar 2021 05:24:13 +0000
Message-ID: <AM6PR04MB5413B90D5F6F75D2186180A0F17D9@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20210330031513.17903-1-ran.wang_1@nxp.com>
 <20210330044602.gtouftuzklm4sdnr@vireshk-i7>
In-Reply-To: <20210330044602.gtouftuzklm4sdnr@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 039f1a90-8bc2-41db-a62c-08d8f33c0e12
x-ms-traffictypediagnostic: AS8PR04MB7879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB78795F41D9EB3918F5BB0C85F17D9@AS8PR04MB7879.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cw5VP5tP7WQm3pZZj/xspQWkTptdp3ZQHsFSOql+ErZEleVRrBJzZM1DtnPla3czeVE1TPPZe/Hu8iCxDpK/+VZVm56vbbeIb9uoyIAitoFQG3yvxOeumJpZeaZBXPaxCB6I7sfZHHs+iGtDxWBk8lc2MS7v02gkHLceHldfOR38i2bwcjpjqDsl/iEA8+3R+9z/5pf1hI7+/JqIdyDVWpQD7vN+6V84EQoa3ASV8m7An9zeAw9okDXfnPGZOq9bWUnqGqwGd0DHAUNQpUC5I/gTOlbbxlrRBqncncfrKKd4eDMTmQeL//t2JHkzdMyHRoc1hoqLNL6srnyCETdwlrV3hKvJOAHT0dZ6cCN+uKh4UU8fBGrDpPBvl2XzQ6EJ5O8wF9LzuGFS1hqwVSmuBZB99PnVBf6DLQthg4/v1AlqX1dthPgc85ANYJgNWtOeolUmtyShy8ns80ndsDyjPznPLebURZRAtev8rPlMUF5xe6speSnbdD6MME/IHm8cw3rMqfkKdRWAOgG9hi/Id7TMJ7/HE8tTAFWok1g73y0lK9NGdf3f9+dUrCnl5ix/K4WXeFYoxZNpvxH3Rf97HzFiGpxGtL7ZX/7RdHuzxScux0uUurOo59fC7C1f6au7WfIkCYDIYaTL2L79EqkpUrtmdXSyjo0MixhHgbQmN0Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(9686003)(71200400001)(52536014)(55016002)(4326008)(6916009)(66556008)(5660300002)(6506007)(7696005)(53546011)(33656002)(8676002)(66446008)(8936002)(86362001)(316002)(2906002)(54906003)(64756008)(83380400001)(66946007)(76116006)(66476007)(38100700001)(186003)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MDBoWVFvMTZUa3ZqRW9sdlAvSHRZM0JPbEtUbnJ6WWVqSHhqT0xLQ0I2T0ta?=
 =?utf-8?B?MlJNbE42c1dxTEdLekNuQUIrL3RSRW1TcEUxNXVMWDVXSHZuWlZmai9rTnVG?=
 =?utf-8?B?cmJTdWRveFR1T0VXYkZwL2RRY3FsNTVCV3lLMEFBL2xzRitPZStxQ0ZlTmV5?=
 =?utf-8?B?QlBVdDF6ZnBsSXRSUDFtMGxieU96S3ZCdmVzSWVWMVZ0U1VzT2RkTFNJZkln?=
 =?utf-8?B?dG03eDN5d3NWVytDTE92Tmt2L3N6YzlBQ1pnUUk0b0tMSHpiM3hPbCtXWDRk?=
 =?utf-8?B?bXF5VGJCa3BWdHRkK2dHRWRmSW1hMTdjMkk4ZW5kK0Q4cGhzUWp0YWJ6SUlZ?=
 =?utf-8?B?SEhLWXZ4TmFGODBlNXdyWFZUeTdURmJ1T0VvbkNEWW92b0dtR3hlWmJCN3Ny?=
 =?utf-8?B?QXAyVVpoZnZ2eFBCN0lGSTdzdzh6K1RSZHptNncwNkhDMlZQM1RzMFhLcmVP?=
 =?utf-8?B?Z0RVY1RKUjBsdkM1cUJYT1RYZmtzS2Y0MTZFZW83ZDFEVXF6YUtJbFRiMGV0?=
 =?utf-8?B?WllSRVJCYk1JZngxdE8rRlVQWVpZbHhIVmYrcnBqelBBbnR2ekVaR1pJbUtX?=
 =?utf-8?B?VXBIRzc0REZiU1lTWFhzZzd2SEg3TEt3TUZKMzI5V3h6eGtxWjN0NWZraU1a?=
 =?utf-8?B?N3gvUUhlMk1yRlFzK0lseXR3NDBxQTRXZm5HbWlCcGZ2Nm1ZdDFvQjBhbkxD?=
 =?utf-8?B?ekhTaXJ1bS9rL0lHN2pRbG03TS9uTnFSd3UzRFROZFM4akFXOTJaZ3NWK1k3?=
 =?utf-8?B?aEdJTVZwYTZ3anZPQk9jdDJQTlZ1aUkxTWdUOFozdCtJOXhJeEFldGUyd1VC?=
 =?utf-8?B?N0V1b1V6eWgzbituZHVRTjNkY3FLdDZhc2Z6Z2pCazFMc09uTGsvbitVYmxM?=
 =?utf-8?B?ZEZBTGdaVUJnY2FITEt5N2E2YkEvNDRXT2g4SG5GTURMNUlQUUY3Y0oya0p0?=
 =?utf-8?B?ZUJ5cVpESTRrTjBuQkxLcFp2UHdxR081NVpVMTZ2MW5HK0czVEZ0TXpaN2pD?=
 =?utf-8?B?VTdRbzRaK2w3ZTRxcUsrWEJIaVpTZTFsUXlVV3ZFMEpFUTdMcDdOZlBGYm1N?=
 =?utf-8?B?NjdVbU1GTDFHelJPTjN2SnhvUDV5dVEzUTJ1VlEyVWZRR01qWlA3WjEza1FY?=
 =?utf-8?B?aThFMzNXdXFQaUxRUDJzNUc0Z1d1VHZucTROclgxZnFUUjJ2OE1BblBXU1Vt?=
 =?utf-8?B?djRBZTNwZG83L3cwT0ZsclNGNWgwUlhrN1VoWEo2aGN4NitLaVN1OTB2M1Ew?=
 =?utf-8?B?SFRwN25DY2FXWFpTdTFVQjNHZ2g5NTgxdUd0aW9vT0RlNm5JeEsyRDY0dCtY?=
 =?utf-8?B?N1J6K3c0Y2QxRWRwc0FBVkw4Y0VwdE53RzhPNDU0bDMzbjgxaG03U1RmQlJp?=
 =?utf-8?B?YWtRYmNrRTlVRFB1VkJIVlFYdDlLTmhWbEdWYXZvaExVdTlRMWlpQTF0OFpB?=
 =?utf-8?B?RFlwRXhHRC8vYzU0VFhNTUdRVjd3aDJSOFcxazUrNnZXbU1jWkl5amYwNitU?=
 =?utf-8?B?NytBTlU4dERibHc4QkphY3l5dXdtYlFXbi9jY1V5U001R3IxK1NVbGx4d1ZT?=
 =?utf-8?B?RlBKdHNsaWFOWXFwOFJpWjFhUU1LcWg2TnJWazF1enZPTzdPbk9WOWZ0TWpu?=
 =?utf-8?B?NkUxaHhCVHhxbFBRWEMwQXlIaXBzRXZlMklTMWpHcUo5Q3Nrenh6OXdPYWdN?=
 =?utf-8?B?WXJrSU90QStaMFYxV1cxeUhISXl5TUdwRVR2Z1ZKQ2dvb1ptNUZnVFVnZkRG?=
 =?utf-8?Q?ow1Vy1h19RskahtpQOmR96Qd4hprRTeqbl4f2ST?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039f1a90-8bc2-41db-a62c-08d8f33c0e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 05:24:13.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qme2N4ndV4e4jiL+A0hRj6tW8BCA38ePYzTBv9jcEM+5lDMOmGNsB8BM8aMTvEmpp+kGPn78BqbtYacjlcuV9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7879
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgS3VtYXIsDQoNCk9uIFR1ZXNkYXksIE1hcmNoIDMwLCAyMDIxIDEyOjQ2IFBNLCBWaXJlc2gg
S3VtYXIgd3JvdGU6DQo+IA0KPiBPbiAzMC0wMy0yMSwgMTE6MTUsIFJhbiBXYW5nIHdyb3RlOg0K
PiA+IFdoZW4gc2VsZWN0aW5nIFBSRUVNUFRfUlQsIGNwdWZyZXFfZHJpdmVyLT5zdG9wX2NwdShw
b2xpY3kpIG1pZ2h0IGdldA0KPiA+IHN0dWNrIGR1ZSB0byBpcnFfd29ya19zeW5jKCkgcGVuZGlu
ZyBmb3Igd29yayBvbiBsYXp5X2xpc3QsIHdoaWNoIGhhZA0KPiA+IG5vIGNoYW5jZSB0byBiZSBz
ZXJ2ZWQgaW4gc29mdGlycSBjb250ZXh0IHNvbWV0aW1lcy4NCj4gPg0KPiA+IFRoZSByZWFzb24g
b2YgbGF6eV9saXN0IHdhcyBub3Qgc2VydmVkIGlzIGJlY2F1c2UgdGhlIG5lYXJlc3QNCj4gPiBh
Y3RpdmF0ZWQgdGltZXIgbWlnaHQgaGF2ZSBiZWVuIHNldCB0byBleHBpcmUgYWZ0ZXIgbG9uZyB0
aW1lIChzdWNoIGFzIDEwMCsgc2Vjb25kcykuDQo+ID4gVGhlbiBmdW5jdGlvbiBydW5fbG9jYWxf
dGltZXJzKCkgd291bGQgbm90IGNhbGwNCj4gPiByYWlzZV9zb2Z0aXJxKFRJTUVSX1NPRlRJUlEp
IHRvIGhhbmRsZSBlbnF1ZXVlZCBpcnFfd29yay4NCj4gPg0KPiA+IFRoaXMgaXMgb2JzZXJ2ZWQg
b24gTFgyMTYwQVJEQiBhbmQgTFMxMDg4QVJEQiB3aXRoIGNwdWZyZXEgZ292ZXJub3Igb2YNCj4g
PiDigJhzY2hlZHV0aWzigJkgb3Ig4oCYb25kZW1hbmTigJkuDQo+ID4NCj4gPiBDb25maWd1cmUg
cmVsYXRlZCBpcnF3b3JrIHRvIHJ1biBvbiByYXctaXJxIGNvbnRleHQgY291bGQgZml4IHRoaXMg
aXNzdWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYW4gV2FuZyA8cmFuLndhbmdfMUBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZSBpbiB2MjoNCj4gPiAgLSBVcGRhdGUgY29tbWl0IG1l
c3NhZ2UgdG8gZXhwbGFpbiByb290IGNhdXNlIG1vcmUgY2xlYXIuDQo+ID4NCj4gPiAgZHJpdmVy
cy9jcHVmcmVxL2NwdWZyZXFfZ292ZXJub3IuYyB8IDIgKy0NCj4gPiAga2VybmVsL3NjaGVkL2Nw
dWZyZXFfc2NoZWR1dGlsLmMgICB8IDIgKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
cHVmcmVxL2NwdWZyZXFfZ292ZXJub3IuYw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFf
Z292ZXJub3IuYw0KPiA+IGluZGV4IDYzZjdjMjE5MDYyYi4uNzMxYTdiMTQzNGRmIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxX2dvdmVybm9yLmMNCj4gPiArKysgYi9k
cml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9nb3Zlcm5vci5jDQo+ID4gQEAgLTM2MCw3ICszNjAsNyBA
QCBzdGF0aWMgc3RydWN0IHBvbGljeV9kYnNfaW5mbyAqYWxsb2NfcG9saWN5X2Ric19pbmZvKHN0
cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saQ0KPiA+ICAJcG9saWN5X2Ricy0+cG9saWN5ID0gcG9s
aWN5Ow0KPiA+ICAJbXV0ZXhfaW5pdCgmcG9saWN5X2Ricy0+dXBkYXRlX211dGV4KTsNCj4gPiAg
CWF0b21pY19zZXQoJnBvbGljeV9kYnMtPndvcmtfY291bnQsIDApOw0KPiA+IC0JaW5pdF9pcnFf
d29yaygmcG9saWN5X2Ricy0+aXJxX3dvcmssIGRic19pcnFfd29yayk7DQo+ID4gKwlwb2xpY3lf
ZGJzLT5pcnFfd29yayA9IElSUV9XT1JLX0lOSVRfSEFSRChkYnNfaXJxX3dvcmspOw0KPiA+ICAJ
SU5JVF9XT1JLKCZwb2xpY3lfZGJzLT53b3JrLCBkYnNfd29ya19oYW5kbGVyKTsNCj4gPg0KPiA+
ICAJLyogU2V0IHBvbGljeV9kYnMgZm9yIGFsbCBDUFVzLCBvbmxpbmUrb2ZmbGluZSAqLyBkaWZm
IC0tZ2l0DQo+ID4gYS9rZXJuZWwvc2NoZWQvY3B1ZnJlcV9zY2hlZHV0aWwuYyBiL2tlcm5lbC9z
Y2hlZC9jcHVmcmVxX3NjaGVkdXRpbC5jDQo+ID4gaW5kZXggNTBjYmFkODlmN2ZhLi4xZDVhZjg3
ZWM5MmUgMTAwNjQ0DQo+ID4gLS0tIGEva2VybmVsL3NjaGVkL2NwdWZyZXFfc2NoZWR1dGlsLmMN
Cj4gPiArKysgYi9rZXJuZWwvc2NoZWQvY3B1ZnJlcV9zY2hlZHV0aWwuYw0KPiA+IEBAIC02MTEs
NyArNjExLDcgQEAgc3RhdGljIGludCBzdWdvdl9rdGhyZWFkX2NyZWF0ZShzdHJ1Y3QNCj4gPiBz
dWdvdl9wb2xpY3kgKnNnX3BvbGljeSkNCj4gPg0KPiA+ICAJc2dfcG9saWN5LT50aHJlYWQgPSB0
aHJlYWQ7DQo+ID4gIAlrdGhyZWFkX2JpbmRfbWFzayh0aHJlYWQsIHBvbGljeS0+cmVsYXRlZF9j
cHVzKTsNCj4gPiAtCWluaXRfaXJxX3dvcmsoJnNnX3BvbGljeS0+aXJxX3dvcmssIHN1Z292X2ly
cV93b3JrKTsNCj4gPiArCXNnX3BvbGljeS0+aXJxX3dvcmsgPSBJUlFfV09SS19JTklUX0hBUkQo
c3Vnb3ZfaXJxX3dvcmspOw0KPiA+ICAJbXV0ZXhfaW5pdCgmc2dfcG9saWN5LT53b3JrX2xvY2sp
Ow0KPiA+DQo+ID4gIAl3YWtlX3VwX3Byb2Nlc3ModGhyZWFkKTsNCj4gDQo+IFdpbGwgdGhpcyBo
YXZlIGFueSBpbXBhY3Qgb24gdGhlIG5vbi1wcmVlbXB0LXJ0IGNhc2UgPyBPdGhlcndpc2UsDQoN
Ck15IHVuZGVyc3RhbmRpbmcgaXMsIGluIG5vbi1wcmVlbXB0LXJ0IGNhc2UsIGl0IHdpbGwgYmUg
cXVldWVkIHRvIHJhaXNlZF9saXN0IGluc3RlYWQNCmFuZCBjYWxsIGFyY2hfaXJxX3dvcmtfcmFp
c2UoKSBpbW1lZGlhdGVseSB0byByYWlzZSBhIElQSSB0byBzZXJ2ZS4gU28gdGhhdCBpdCB3b3Vs
ZCBiZQ0Kc2ltaWxhciB0byB3aGF0IHRoaXMgcGF0Y2ggZG8gaW4gcHJlZW1wdC1ydCBjYXNlLCBz
ZWUgZnVuY3Rpb24gX19pcnFfd29ya19xdWV1ZV9sb2NhbCgpOg0KDQogNTMgLyogRW5xdWV1ZSBv
biBjdXJyZW50IENQVSwgd29yayBtdXN0IGFscmVhZHkgYmUgY2xhaW1lZCBhbmQgcHJlZW1wdCBk
aXNhYmxlZCAqLyAgDQogNTQgc3RhdGljIHZvaWQgX19pcnFfd29ya19xdWV1ZV9sb2NhbChzdHJ1
Y3QgaXJxX3dvcmsgKndvcmspICAgICAgICAgICAgICAgICAgICAgICAgDQogNTUgeyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgDQogNTYgICAgICAgICBzdHJ1Y3QgbGxpc3RfaGVhZCAqbGlzdDsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogNTcgICAgICAg
ICBib29sIGxhenlfd29yazsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgDQogNTggICAgICAgICBpbnQgd29ya19mbGFnczsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogNTkgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgDQogNjAgICAgICAgICB3b3JrX2ZsYWdzID0gYXRvbWljX3Jl
YWQoJndvcmstPm5vZGUuYV9mbGFncyk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogNjEg
ICAgICAgICBpZiAod29ya19mbGFncyAmIElSUV9XT1JLX0xBWlkpICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgDQogNjIgICAgICAgICAgICAgICAgIGxhenlfd29yayA9
IHRydWU7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQog
NjMgICAgICAgICBlbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19QUkVFTVBUX1JUKSAmJiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogNjQgICAgICAgICAgICAgICAgICEod29ya19m
bGFncyAmIElSUV9XT1JLX0hBUkRfSVJRKSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KIDY1ICAgICAgICAgICAgICAgICAgICAgICAgIGxhenlfd29yayA9IHRydWU7ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KIDY2ICAgICAgICAgZWxzZSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KIDY3ICAgICAgICAgICAgICAgICBsYXp5X3dvcmsgPSBmYWxzZTsNCg0KQW5kIEkgaGF2
ZSB0ZXN0ZWQgb24gbWFpbmxpbmUgYW5kIHJ0IHRyZWUgd2l0aCBDT05GSUdfUFJFRU1QVCBzZWxl
Y3RlZCwgY291bGRuJ3QgcmVwcm9kdWNlIHN1Y2ggaXNzdWUuDQoNClJlZ2FyZHMsDQpSYW4NCg0K
PiBBY2tlZC1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4gDQo+
IC0tDQo+IHZpcmVzaA0K
