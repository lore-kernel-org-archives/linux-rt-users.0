Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFDCC433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 02:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CED64E31
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 02:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBWC07 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:26:59 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:3342
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231569AbhBWC0v (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 21:26:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeIS8mlwRGpgoZ4o0wvmFBotn8+U5/71OHMJIJjmYJq1h6zC5zs+voPTMBo7HgqkH4dSTCYbhRg2r4jNw5qO1KDrEtRULNh39rnLE2Xedd1gi7Xs9oNb+CWCQI5sEAYNjzQ93YA30VEQyuTOtx8jwVhI07pq+R91CgIGvLhuEgaayOiI+bO8dKOSlTaWk66JZk/AkC5+Ky8YSv9W3UMnPtLC2DUhyo5C1IDCLe+vqPgretnyNPqsJ2qdraYBrfmi+q5s3u+tMQPTaXuhT9q9lpvLMGNgRhLQfTjLMQe2PDHkGjYzAZ/JlvG2yQW2UQOXTXVav8Q/IVOvpypAd/UPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tk5ujPBBx1kVF+eEAaUdQwpeb/Jrs1gfXNIPuWGp0I=;
 b=MG/lrGf4zaNRo6bQfdYFpgVOTAqf0Rw44770M4lOAsKeM/HHN0aFFMAswGvPVYVFaIupNNxxw/XGTRITjXuaQbz/jdNcylvxjEgg1qLQi7UsSut3DKQnmtlg1w8lI07/WzZxi8nuQPCHAUedL13fWb6B5fylIsoVpSrr5/GLHi+NwGK8Um8nu6MVTNh0JNWH9iJJIPnWGJlGhcDrcELdTi1nSz/aV2m7CKu41e4fAij/aFwSHUtJ+jY1sUFMMwVOqCHybj0mU7ME/sndZHjmxjWpHHYhi/f5y6Yn1XIgUmHYWY5V2zSlz0hQQT2HANQgY+PkdF7FveaF8uaRbnsU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tk5ujPBBx1kVF+eEAaUdQwpeb/Jrs1gfXNIPuWGp0I=;
 b=q/Zm/kLtc9E3Oaqjikb/o4R0HKXE+HdRenZUP5zjQEOcfWYWtq0PrynBKa4CtzRICG0aWfy5uIEJDNTouKk4ZswixWRVI1JeicPsj9sdKDtqjJekSbHvis0j50ulcsEgTHCOL5Q/IiBNKgF1+onZ+iHxWCE0fU01xvmDWv7Q5uk=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM6PR04MB5286.eurprd04.prod.outlook.com (2603:10a6:20b:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Tue, 23 Feb
 2021 02:26:02 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::b4f2:d00e:93a1:8685]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::b4f2:d00e:93a1:8685%3]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 02:26:02 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: RE: [PATCH] rt: cpufreq: Fix cpu hotplug hang
Thread-Topic: [PATCH] rt: cpufreq: Fix cpu hotplug hang
Thread-Index: AQHXBppW83xUVC3dLUCScJ+gOFcU4apkOSCAgADNkPA=
Date:   Tue, 23 Feb 2021 02:26:02 +0000
Message-ID: <AM6PR04MB5413DB3654A87D50C909004CF1809@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20210219084420.23379-1-ran.wang_1@nxp.com>
 <20210222140107.qk2ymlwyyxspluge@linutronix.de>
In-Reply-To: <20210222140107.qk2ymlwyyxspluge@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0b5e746-e172-49a1-a79a-08d8d7a25d74
x-ms-traffictypediagnostic: AM6PR04MB5286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB528617B33C1C6090AF6E7A2BF1809@AM6PR04MB5286.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jajveY1LRnWPqCgTWab5iz2uWQC0fZOf00yqZ6+6Aj9ljfdMMlNtWOwdFibqa6IS0Zp5xHslXaNq2NbnOeaENV8IfMFxT/8hJpGHGPPnGvhyXB6OFJ3NgyPXqbsmrkPHz+COKxEqEU/Wg/TvsWXhCnDhZZGYpPT1s9+b0s2EoIsFb3+bdc9VWF3LRtBHio+joFlMlSgSJP3E1Ud0WG4OVCmiPeCO0O4aMfmtANw2hhewMlr2U3txv/7rrgPbG3nhUi901u+1csJeeLQiiXLs8L5EQ+i2eZ4vnH5V15JlViHBWiDLsOuy8HUSjBvP3306OSxV+cUopU/ayIXGDOMMWJPU7mX2w1s/Klz+gxZwHZ+gFscrEZBuo/10hl0mZccsqlwm2YEEF6qK5VPqG9nEPhnN24wU9toUsenQg11jwGqn4ARNAOeYraFxtpTRKivOtPcywYz1ga+ONos/im2YangbHE4CJCLrUyUQ9g3TcxKb8AJfxN83gVH1TcBveKUhhhLIQuRp3WATdczdfmfw5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(71200400001)(5660300002)(6916009)(52536014)(86362001)(26005)(33656002)(9686003)(83380400001)(2906002)(53546011)(66446008)(4326008)(6506007)(8936002)(54906003)(478600001)(66476007)(66556008)(7696005)(55016002)(66946007)(76116006)(8676002)(186003)(64756008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WmR6N0tkRHZBN2RtZlFDWXNyYVB6RC8wdnRVOGJMOWttUFgwWkdvYWZNNkgw?=
 =?utf-8?B?TWkvYk1hS1RuZ0NpL1R2N3h5Q0ovaUMzcGdIZi9MVG9tUzExUTUzS0oxYUlu?=
 =?utf-8?B?OExWZTl6ckVNYnNJbFlIV1E4aVRISWgzcFlieUhQamt0RFl0NWFCN25sdnNJ?=
 =?utf-8?B?cktGNjVhZmhDUDBxSFZ2ZTVRakU4RVVVaGI5aFVna01PWFpId0k3Zk9xVEIy?=
 =?utf-8?B?SXZJK1NWWCtxdTdwblpaUG14V0Zqa2I0TmlnYUxQb1FSVkNBR0FUbWJTUXgw?=
 =?utf-8?B?L2lXbnpWTFdiaEtLZG11ZFRJZFAzUFFRRTg3Szk4aVIvQ0UwVlpCUnJvTkY0?=
 =?utf-8?B?aWNPdU5FYlNzN2hNd0FWZjRzN2xXUzJoRHZPeGZUdnRCaTVkaUhRMWpRRXJu?=
 =?utf-8?B?aGx5T0svb0NxZUtiWnRmQ2RJK3ZEMXUzc0JpOWFWejNnM0JrbkhFTDNJMW83?=
 =?utf-8?B?akJ2aUtZUTFFb2Z0RzhLRmZEQjU5bG1RVm41WnYxUkZSWmFHVG5WOGNNYktT?=
 =?utf-8?B?NFJMYXREbmI5WUdMYkVIZlNEV0xETlFxSmVmcFF5cjRXS0NRNW9OeXI2bnJr?=
 =?utf-8?B?V3NxOVhxWnFSUXdEZVpzV0NKcjJkWG05YTlPenZzdmovUXpsdHRpYTJIYklG?=
 =?utf-8?B?dVIvQmY4blNuVTNtTGZudVBxTklYN1hjeU9QWWZlVUFRVHdXdllOeUlzVHBB?=
 =?utf-8?B?dDJkYVo2NVhxTVpJbUkwa2F5MU5iWThTengxZC9udFVjQkV4REx0RTRqempD?=
 =?utf-8?B?SnFDeGxGRWd0blF1TmttVmRjdW91RXB0cE1US2tZMmpGUEw2NmVoNHRtNTNz?=
 =?utf-8?B?VFhkbTlSTEVaWUppQUdMUmFVUjRmZFcyTkVPQWpuNnVhTk1DT0ZxZmlENXJj?=
 =?utf-8?B?VVphbDQ3a0xUVVZ4RTZGYWFldGZJNXM5SEE4d2Z2clhxNVBGMU5GdDhEVnFM?=
 =?utf-8?B?cjkxdlNKZkZOZEw2K201OHVaYk9jWngwZ2o4VVhDdGM1Wm0ycGlJRkJnbXFC?=
 =?utf-8?B?c2ZRM2ZIdG0zWHNJbGllMGNFaFEwTWk4ZlU2dXlsYWRYcHF2Sis3UXlJdHlh?=
 =?utf-8?B?SGtmRnExZUVZazA5Y2tJWi9nQTQ3eUltdERBeVo1K25rR2V1UDE5eWN1VGRP?=
 =?utf-8?B?MnBYYTBvU0ZHa2l4M1NjZkZqaXV4NEQwKzUyQ1hJeFFTTlNSdEI4b1pGWktH?=
 =?utf-8?B?eU90Q3ZaSXlDZUZtcFRwL21mZzFqVWkxa0o2VlNvWnRGNWl5ZXovRGRicWQy?=
 =?utf-8?B?R3ZTT2t0bEVEb0NlSDRYbXN0TnR3ZHBQMFJlVHFYUUJIYlRQeXkweVNjQ2xX?=
 =?utf-8?B?RlgySnhmTWdPRS84MkVwRXdQT0t5SWZXWkJRcDVqdHRsTStKUHNrYyt1a3pQ?=
 =?utf-8?B?VjN0VVBPVEQxM3hJWjhQdXIvVGRWNmM1L2YvdDhFOXBja0lPekZ0ODl6ZTBX?=
 =?utf-8?B?NHBnUGt1WWZTa1Azb01lYlZ1SU9tNFQwMlJZZDNUWlVDVGFGcTRYT2krb2ZD?=
 =?utf-8?B?VStOWWNGRk04c0ZUbnhIUzFoWU9yTDQySjNYVGNSNnJEbWdiWWpid0ZaQ0Uv?=
 =?utf-8?B?WUlMMlVabVRoT1l0aTF0TTVaWjAxTjN4MHU3dDlQbzMwNzg4N2EyRVhXblJm?=
 =?utf-8?B?TzFLZzVNeGhFQ1laQlY1a0txTk84c3dTNEZaYXlJQkloeU9TeVZGWjQ1ME5E?=
 =?utf-8?B?c0dRMXM2ZkpBeitLZ2lNQnBMNnlGNSt4ZEtPNjBLalVNNzRFUG1ObkNtbDZ5?=
 =?utf-8?Q?dvnWIuIB+oC63JWLiltZj+sPSwOxFyPFlok37Tx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b5e746-e172-49a1-a79a-08d8d7a25d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 02:26:02.5075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVQI51+VuFrPnRE6CgEAnvw1oeNcXZg+cia0uhyjduNHrCLDLXNVINWmp9pcxiuJyBsJZ6I7RGhex9cgfGLLwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5286
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGVsbG8gUmFmYWVsLA0KDQoNCk9uIE1vbmRheSwgRmVicnVhcnkgMjIsIDIwMjEgMTA6MDEgUE0s
IFNlYmFzdGlhbiBTaWV3aW9yIHdyb3RlOg0KPiANCj4gT24gMjAyMS0wMi0xOSAxNjo0NDoyMCBb
KzA4MDBdLCBSYW4gV2FuZyB3cm90ZToNCj4gPiBXaGVuIHNlbGVjdGluZyBQUkVFTVBUX1JULCBj
cHVmcmVxX2RyaXZlci0+c3RvcF9jcHUocG9saWN5KSBtaWdodCBnb3QNCj4gPiBzdHVjayBkdWUg
dG8gaXJxX3dvcmtfc3luYygpIHBlbmRpbmcgZm9yIHdvcmsgb24gbGF6eV9saXN0LiBUaGF04oCZ
cw0KPiA+IGJlY2F1c2UgbGF6eV9saXN0IG1heSBoYXZlIG5vIGNoYW5jZSB0byBiZSBzZXJ2ZWQg
aW4gc29mdGlycSBjb250ZXh0DQo+ID4gc29tZXRpbWVzLiBCZWxvdyBpcyBvbmUgb2Ygc2NlbmFy
aW9zIHRoYXQgd2FzIGNhcHR1cmVkOg0KPiA+DQo+ID4gLi4uDQo+ID4gcmV0X2Zyb21fZm9yaw0K
PiA+ICBrdGhyZWFkDQo+ID4gICBzbXBib290X3RocmVhZF9mbg0KPiA+ICAgIGNwdWhwX3RocmVh
ZF9mdW4NCj4gPiAgICAgY3B1aHBfaW52b2tlX2NhbGxiYWNrOiBzdGF0ZTogMTkzDQo+ID4gICAg
ICBjcHVocF9jcHVmcmVxX29ubGluZQ0KPiA+ICAgICAgIGNwdWZyZXFfb25saW5lDQo+ID4gICAg
ICAgIGNwdWZyZXFfZHJpdmVyLT5zdG9wX2NwdShwb2xpY3kpOw0KPiA+ICAgICAgICAgY3B1ZnJl
cV9kYnNfZ292ZXJub3Jfc3RvcA0KPiA+ICAgICAgICAgIHN1Z292X3N0b3AgIC8vIGtlcm5lbC9z
Y2hlZC9jcHVmcmVxX3NjaGVkdXRpbC5jDQo+ID4gICAgICAgICAgIGlycV93b3JrX3N5bmMoJnNn
X3BvbGljeS0+aXJxX3dvcmspOw0KPiA+DQo+ID4gVGhpcyBpcyBvYnNlcnZlZCBvbiBMWDIxNjBB
UkRCICgxNiBBNzIgY29yZXMpIHdpdGggY3B1ZnJlcSBnb3Zlcm5vciBvZg0KPiA+IOKAmHNjaGVk
dXRpbOKAmSBvciDigJhvbmRlbWFuZOKAmS4NCj4gDQo+IFdoaWxlIHN0YXJpbmcgYXQgaXQsIHdo
eSBkbyB3ZSBpbnZva2Ugc2NoZWR1bGVfd29ya19vbigpIGFuZA0KPiBrdGhyZWFkX3F1ZXVlX3dv
cmsoKSBmcm9tIGluc2lkZSBpcnFfd29yaygpIGluc3RlYWQgaW52b2tpbmcgaXQgZGlyZWN0bHk/
IEl0IHJhaXNlcyBhbiBpbnRlcnJ1cHQgaW4gd2hpY2ggaXQga2lja3MgYSB1c2VyIHRocmVhZC4N
Cj4gQ291bGRuJ3Qgd2UgZG8gaXQgd2l0aG91dCBpcnFfd29yaz8NCg0KQ291bGQgeW91IHBsZWFz
ZSBoZWxwIGNvbW1lbnQgb24gYWJvdmUgcXVlc3Rpb24gKEkganVzdCBmb2xsb3cgQ1BVIEZyZXEg
c2NhbGluZyBmcmFtZXdvcmssIGNhbid0IHRlbGwgd2h5KSBUaGFuayB5b3UgdmVyeSBtdWNoLg0K
DQpSZWdhcmRzLA0KUmFuDQo=
