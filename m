Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6064CC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF3A235FA
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 09:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbhAHJ2R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:28:17 -0500
Received: from mail-db8eur05on2042.outbound.protection.outlook.com ([40.107.20.42]:44001
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728265AbhAHJ2O (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 04:28:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/fMyjQv2mjLPXJiDh1TGFoPO741BQdibcbTzOCZOQGMdZQ5Q3MYraV//UZa3D0qHh+l9M7A+W9BsxUwoY1SJbORyPgdiUL4HZ+qMvjuFjdsZlFQZ5EtV22N/9SyybrFNtVbiGSHIFWXme8RGQbqqHmmloFw6StjrUJyUnCyWW8NfNLS/U90iHfgPujviFssmf0AgEIFqxWpBsg0JlBE8jt/x4ke4cbUnx2Gfi8fPV3AY3YjzA3z6xB/+bY0BOwoF4kpnjZM+pbp3cDHkDVA3qRlUCbQFzNBuqR3tvfHXASOWPkIxV2wO4XwoMEnlgofjhn5UXBjcl4KDRTNXmBl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwSWeQQjFgN+cwlnguXzxZYACWvyhP+l41VSxF4ckTA=;
 b=XbwbR2LpuDbWqxXtyHEvSesgq4zhvIhhIRLWLXkNst1GZbP6Y0fOifWqh81afGiLgnHNJ3eh27dMwz/nnuhjVDZlIKfhU3Fnr8Zi+sftmZnCI54S7AjkY/fJX3ruxdw+yPoqVLoy8sg65Vxy7f4rp0XSTF14AE2sCw0exae9qKGfoGdQwEoFQml9DiW4ahWRRcDensJaYCqbUjfoU7HKKMGakAQ6P1Y+3KpbmjXxrT5MFbFKLgPzbQdI0RG2zEyHFuch3AY8nXSfUsaGV89jJ0+bS6xzTs3zWmWIOXYWQfS+dz69PIsnHF334ntGncPdh7baHZ6o6IkPywYB8Tr4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwSWeQQjFgN+cwlnguXzxZYACWvyhP+l41VSxF4ckTA=;
 b=TvOifYN+7zXyUtS+q+V8TzBXkuAcx1wl47ODaZco+LNSKWwLiH617K6bIJan6W9Mzr8vMkIrey9JQr/RQo4R0FKnmW4ucvJpWhuomhXt+TFjkArs6GPNH91ONXRIOpYzHhisByPpgjWHBHVvSa0Gjw0NUmG7Ea59Bamtzen6Yto=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM5PR0401MB2564.eurprd04.prod.outlook.com (2603:10a6:203:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 09:27:25 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::f067:a4a9:70e0:e910]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::f067:a4a9:70e0:e910%4]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 09:27:25 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Sebastian Siewior <bigeasy@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending
 too long when CPU un-plugged
Thread-Topic: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending
 too long when CPU un-plugged
Thread-Index: AQHW5NTeAJUSfO8HlkyY76riLvO0Vaob+tCAgABPFoCAAR//cIAABygAgAABgvA=
Date:   Fri, 8 Jan 2021 09:27:25 +0000
Message-ID: <AM6PR04MB5413BB118A086E333E95F4FFF1AE0@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20210107091841.19798-1-ran.wang_1@nxp.com>
 <X/bmU4byS7k46zWM@hirez.programming.kicks-ass.net>
 <20210107152843.gyljmpctkwybfewh@linutronix.de>
 <AM6PR04MB5413F9490E9264273E22264FF1AE0@AM6PR04MB5413.eurprd04.prod.outlook.com>
 <20210108090506.ijekysg6aenzno5t@linutronix.de>
In-Reply-To: <20210108090506.ijekysg6aenzno5t@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c3329b9-8c10-417e-c286-08d8b3b79c6d
x-ms-traffictypediagnostic: AM5PR0401MB2564:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR0401MB256411F497407D73E87C81F3F1AE0@AM5PR0401MB2564.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZYcfhG/xPAGlkumGlxbBqc4Mu+Qh2xrUBbJmxbppc7E1UiniT67nJTwzwp5RQKMkVIg8wCT5l/OVo6E51IaOSCgM+vAMrCFGeJG5ZQQ9d9MwS43+1dHvmsbwkgy14opYIBavG3wlPyil2CbIVhsk2wVoovI5ApnlnSJQEawaRsvWcHUhUn51YJ7Gm1MPs2fmKcY/JU6XQRIEqzozb8K8WcEyR9aTZK3mZqHF/D799rRKzsP4tw+4cgI357tpvbyAS24Ygg9XxPJSic2JMJXs+KjXVRu9OB+tlbtcUA9WofvyIRv+5NGDuDlcya1kk9b8r6zcgEtAooDp0CWgAnVjsnm3VTmgWye5xvXaIAjOiMsKumy9a7Knxltr+G0Xw+rDo/jmK1Oi6aQMoE9Dinj/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(8676002)(7416002)(5660300002)(52536014)(54906003)(55016002)(83380400001)(64756008)(4326008)(66946007)(66556008)(66476007)(316002)(186003)(26005)(86362001)(9686003)(66446008)(76116006)(6916009)(2906002)(71200400001)(53546011)(8936002)(33656002)(7696005)(6506007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?alpNVUppUjJsNjgwNjBNcGNTNkIrenQwK0JQT1F0Sk5EcmxlWmoxU1U5cjBq?=
 =?utf-8?B?aFMvZ3ZJdGZlbXBiSW5KeXpGSjVTdlFoUE0vbVlmcGx2UlVXL3FmMEFWa3p1?=
 =?utf-8?B?YlJyNmhzQkVuOXpvc2NjU2ZnWS8vL2VoUWVHaTkwSlpST0pKM20xRWZJNUpH?=
 =?utf-8?B?TEdxcnY3TE5ySVlEQ1F2V2RRYng0TmdtK0xWYk5mczJxVEtWeXZTUnQyLzVs?=
 =?utf-8?B?YmplK3dwc1F6UmRWRmF6WTBEdTFVckUyMkVSU0U2ZklSdVhWd0FQcVhvd0dl?=
 =?utf-8?B?dUowRlFkNVVJemtSUGZUakpWaE9BWUZZM3BmSERjYndKb01zZjIzK2Yxd1dP?=
 =?utf-8?B?YlkralZ3akVRaXNZU2dmckZCUE05aGJERFNpVlBzWU1nN01qaXpidFVCYVAv?=
 =?utf-8?B?bDI2N2p5Q3pDbUFTcGJhZkFoaTQ5blBtemx6Z3paUWxkdVRkNjh2Vzd1dzJZ?=
 =?utf-8?B?YW1zVkFkNGxCb2ErclVPTFRtRHdpVkxseHpsWllCOWtjR2grODlMbGYrblBC?=
 =?utf-8?B?OUxQUEIvZHFqUi84U1dzT0VwNkdnMkZNRXBTRFFJZUZTTzhHU1FSbjZDMGMx?=
 =?utf-8?B?SDRwVnlKbWptZGkwV2JDM25paC9aUHZPOE1LZERCbGt2azI1OXA5cHR6OVB4?=
 =?utf-8?B?OEw5NlVhcEE2ZWp2ZTJ5OXNVendyNUVBUit4ZTJ4NFVYN1orc1duT1FsMi9t?=
 =?utf-8?B?SWZSUWF0bXNHSk11SXdtMWM2a0lhcCtDbW9mQlNXV0NnNldRd0tVNTFQelRt?=
 =?utf-8?B?R3I1VDBZWW42NE1pZHhnNWJna2REak84bkFCV0R0Q3pDN0JoOE1vUDlFWVVZ?=
 =?utf-8?B?bWlXazJ4Njd3Mk45S2hZcStYVGV0MnJoaEkrT29JWGxZODlEd0tpUWQvMDV2?=
 =?utf-8?B?aU9HQmxNTHlMdlFDUmdqTUZla3hMS2hRblBhVktGb1Q5U0N2MkxIT0VUSG0z?=
 =?utf-8?B?ZHVlNjlkS3gwQ0l0ZTVrOTRVZ1lWNmhkU2JTWWVwek1NaDU3NXYrK2U0RW94?=
 =?utf-8?B?STc2VHUyZWhPQWFqSHpXQVJkakFzRlBERmovRGdMdStZY0FNd1hYT1JJNkRh?=
 =?utf-8?B?YVViLzNER0JHYm1MQmRJTk1pZ2N5Nk5mRkd1bzJDa1FuZG9kOEtIeHJDWjFu?=
 =?utf-8?B?UmM3bGZpTU9CSkdwakhjZmlRRENoZ1hRZHdPSVVNbWptQ1YrVFYwbGRTOWo0?=
 =?utf-8?B?VmdzSjloRTd0MURGSDQ4NWRkQ1ErQ0k0cDRVM0RvQkVnUkZDcks2SS9JelFD?=
 =?utf-8?B?a3NMZUpHTzVYckNIciszaWxKM1NnSmUrSFZOQTFhMEhKR21IOFpYQXNORUVZ?=
 =?utf-8?Q?rggehcNqZnDPE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3329b9-8c10-417e-c286-08d8b3b79c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 09:27:25.7141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbG8Y6yIpZXuOLA2suyWeKGsO8OBtSqDUXFZ8ciRadN2Fe8Ew++2HSGlbZH7f9a0f/+eu2Hr+z65LI6z3Xxejg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2564
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgU2ViYXN0aWFuLA0KDQpPbiBGcmlkYXksIEphbnVhcnkgOCwgMjAyMSA1OjA1IFBNLCBTZWJh
c3RpYW4gU2lld2lvciB3cm90ZToNCj4gDQo+IE9uIDIwMjEtMDEtMDggMDg6NDU6MTQgWyswMDAw
XSwgUmFuIFdhbmcgd3JvdGU6DQo+ID4gSGkgU2ViYXN0aWFuLCBQZXRlcg0KPiBIaSwNCj4gDQo+
ID4gPiBJIGhhZCBhIHNpbWlsYXIgcGF0Y2ggaW4gLVJUIGFuZCBkcm9wcGVkIGl0IGluIHY1LjEw
LXJjNy1ydDE2Lg0KPiA+ID4gSXQgd2FzIGFkZGVkIGJlY2F1c2UgUlQgY291bGRuJ3QgYm9vdCBz
aW5jZSBjcmVhdGluZyB0aGUgYm9vdC10aHJlYWRzIGRpZG4ndCB3b3JrIGJlZm9yZSB0aGUga3Nv
ZnRpcnFkIHdhcyB1cC4gVGhpcyB3YXMgZml4ZWQgYnkgY29tbWl0DQo+ID4gPiAgICAyNmM3Mjk1
YmUwYzVlICgia3RocmVhZDogRG8gbm90IHByZWVtcHQgY3VycmVudCB0YXNrIGlmIGl0IGlzDQo+
ID4gPiBnb2luZyB0byBjYWxsIHNjaGVkdWxlKCkiKQ0KPiA+DQo+ID4gSSB0cmllZCBhcHBseWlu
ZyBhYm92ZSBjb21taXQgdG8gbGludXgtNS42LnktcnQsIGl0IGNvdWxkIHJlc29sdmUgbXkgcHJv
YmxlbSBvbiBMWDIxNjBBUkRCLCBUSEFOS1MhDQo+IA0KPiBzbyBpbiBvdGhlciB3b3JkcyBhbGwg
dGhpcyBjb3VsZCBoYXZlIGJlZW4gYXZvaWRlZCBieSB1c2luZyBhIHN1cHBvcnRlZCBvciBtYWlu
dGFpbmVkIFJUIHNlcmllcy4gVGhlIHY1LjQgc2VyaWVzIGhhcyB0aGlzIHBhdGNoLCB2NS42IGlz
bid0DQo+IG1haW50YWluZWQgYW55bW9yZSBzbyBpdCBpcyBsaWtlbHkgdGhhdCB0aGVyZSBpcyBt
b3JlIG1pc3NpbmcuDQoNClRoYW5rcyBmb3IgbGV0IG1lIGtub3cgdGhpcy4NCg0KVGhlIHJlYXNv
biBJIHRyeWluZyBsaW51eC01LjYtcnQgaXMgdGhhdCBJIGhhdmUgZW5jb3VudGVyZWQgb3RoZXIg
bW9yZSBzZXJpb3VzIGlzc3VlcyBvbiBsYXRlciBSVCB2ZXJzaW9uIChldmVuIHdpdGggdjUuMTAt
cmM3LXJ0MTYpLCBvbmUgb2YgdGhlbQ0KaXMgQ1BVIGhvdCBwbHVnIGdvdCBzdHVjayBpbiBpcnFf
d29ya19zeW5jKCkgd2hpY2ggY2FsbGVkIGJ5IHN1Z292X3N0b3AoKSwgZmFpbHVyZSBoYXBwZW4g
YXQgMXN0IGxvb3Agc3RyZXNzIHRlc3QgZXZlcnkgdGltZS4NCkkgd2lsbCB0cnkgdG8gY29sbGVj
dCBtb3JlIGluZm9ybWF0aW9uIGFuZCBjcmVhdGUgYW5vdGhlciBtYWlsIHRocmVhZCBsYXRlci4N
Cg0KVGhhbmtzICYgUmVnYXJkcywNClJhbg0KDQo+IFNlYmFzdGlhbg0K
