Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76FCC433E6
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 08:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535F5235FA
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Jan 2021 08:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbhAHIqF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Jan 2021 03:46:05 -0500
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:61249
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbhAHIqE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Jan 2021 03:46:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbVoPuMwEQKBKEYnLAuuMbEfk27cl07tgykY2sb276+yCPt/pk4upIWUdP5XlJUzjKs8WGddaqU0mexmcE1fFXxQV12BQKMeTHn9jpel63GOWrcc22h7bg1UkOxDSiVeH67qGYccKpjPRH7vhhnGGFEDF1QWl3hyEV/BqVa0P8kCzrPLfLF9R81rQu4Rra9x8aFVOdCRs2u71B6dOSwCBxwKwjLkhvxpZgCEvtx2P9ykzQCNTHc+muS3yyjZbDwhlYZUYp0amq60AsCkDaOwi38T5Kb7GueYCx+YA4StRWwvBbL01JFCjsaB6CN+nfI03wNJloBe0E9yVpFrK8uKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8P94qgp2Y/14sMCwVByDKJEhr2TKZ1tprdVAlrL3E8=;
 b=a6p0vJnWwLgAnOFc921B99fv1RhI1+p3Q9ra81Vp80xCV7UTsMF4l0yxob8LbfKhEFMF/REB22L0ezMhkC3XlgM61y0xKCsa4TuOg+h80BFt4mbKPGFZ7NNGDRW7CcSPYLA/qoWM1wmVs9jLhY2HNIPw2ztkO3OTrg90Gko+4UguKcXknDG+T0XYwoXKc+icauvaVrlRtTvXxSbq2D605g4OThT38ZI+tf14OY8onQXZr22hS8BrX909MdR1/nuoxd6ca8T8IWIkAbJtsp07Qm0NGqRw4XG8RMyEQLPCIDJUccKSR1xuNXlZtpTFxRpS7oRfZvV15gjNgIyLB+MPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8P94qgp2Y/14sMCwVByDKJEhr2TKZ1tprdVAlrL3E8=;
 b=c8Q9CGdWVWMEy7ztxEZ1cn1JadcrtqcAprGoj2G87voWz2AhgpL3GbDoMgb18peSxU4zkqwUOxZnHgjeiO6alIHGb7EO4Lz7KRvUQij/zNNogMy7U6bgwCOjBcPsxEq1mgp94k6ZAWLvxtzMvcbYRu+n8740EB9gjc8NN9RlhJg=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM6PR04MB5703.eurprd04.prod.outlook.com (2603:10a6:20b:a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 08:45:15 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::f067:a4a9:70e0:e910]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::f067:a4a9:70e0:e910%4]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 08:45:15 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Sebastian Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
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
Thread-Index: AQHW5NTeAJUSfO8HlkyY76riLvO0Vaob+tCAgABPFoCAAR//cA==
Date:   Fri, 8 Jan 2021 08:45:14 +0000
Message-ID: <AM6PR04MB5413F9490E9264273E22264FF1AE0@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20210107091841.19798-1-ran.wang_1@nxp.com>
 <X/bmU4byS7k46zWM@hirez.programming.kicks-ass.net>
 <20210107152843.gyljmpctkwybfewh@linutronix.de>
In-Reply-To: <20210107152843.gyljmpctkwybfewh@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f379f48-89b0-42dc-b21e-08d8b3b1b802
x-ms-traffictypediagnostic: AM6PR04MB5703:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB570364F624313A808ACC0D41F1AE0@AM6PR04MB5703.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVq8rHjqbnIIq8h6SzKi4kPZTMXkPRI2HpN1a+UTwy8YkmNCp2Y9DsBTEDMtPTP+HlhK4dJl1hXtcDuuw4jcCHhfycI0vvR+pqRneWZeeyvGdHFMMzWHYPkVxjaiaGZxrVDKsYyd3ZnmX2qIijapamHx5TF/Xsk4YzyUHsp9jlqpWTt8fsX7X7QeO6l8tftdH9C8hvLPWAMini7bn2fE3rtErtb/mUd3fo68IMMnoKy7JIVO+8wZtZbUaIqYI/TaoZvRwUXcsXAReTjWAR9f7jURSMyqVNgxosxlzFd6KvVRD1KlKU6m9+7OnDU4lEoR3ickJhRwbzvET4WDcWm2EyPCdFwA6t8EwFXWUCawmyENCqBKjUlZE5nTE6UQE+DzmGJG8PTvx049pnoIz4iRAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(110136005)(478600001)(316002)(186003)(86362001)(54906003)(55016002)(76116006)(52536014)(71200400001)(7696005)(2906002)(83380400001)(26005)(6506007)(53546011)(33656002)(66446008)(64756008)(66476007)(8676002)(8936002)(5660300002)(4326008)(66556008)(7416002)(66946007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OG9IUFpIMGtFNlJsU3FpeGZsT2JxQ216YXZiVkVZeVBKV2RZTE1yOU4vVDI5?=
 =?utf-8?B?U2FhWi9Ldy9HR1g5OUJIQlAwWG1yNzNYVnlydi9mQnFQZDgrSi9DQzVVMW9Y?=
 =?utf-8?B?VFdpMlFmSWozNzN2NWtkaktsenBrMWV2eHVOSkJMbUdSMngyUE1QK00vU1Zy?=
 =?utf-8?B?VCtoUVR6bWlibVhOSkVvckdJOU1pSlRyUkJJdVdHL01YRG5YR2ROVTZ4bVNj?=
 =?utf-8?B?TzNSeFpITGo5NkJlalE5RkxPN1V3OEUvYjF6ZmkzTSt2dmtGQncyOG5xT3px?=
 =?utf-8?B?QjFSY2svZncwRzFaMEhSTlhYQVk1Nzd4b0kvRWRRTkE1SjZsVFJhcmJPVzhv?=
 =?utf-8?B?RGR6M1BvM2ZsWGlyeHR5aStGeUVLSmZ3ZGZ6QTY4TDcvNC80STcyVDRzbVN5?=
 =?utf-8?B?T0tSRFAxRWpXUFMrT0JxV0Q3OGlyZDRicnk3SHJJb3FYczFheU84ajlnd1ZC?=
 =?utf-8?B?ZEE5R3pHZkU3cTZjamJrUXNpTmpCUWNSWlowYk9aTlJCNlUwZThRUlVwT0Nt?=
 =?utf-8?B?dGhscDVKSzh4MEkrbHU5V2R0SzdoS1VFV3ZtMkFZdXZrVEl2cEU4U2VMc1hX?=
 =?utf-8?B?SGxvcXNhL0F2Q0JxVnYvaFRwUkN2cjhXUmlJQ2JkWjJ4SVNiZ3hObUY5eXhk?=
 =?utf-8?B?d1VuN3U3K05ibmxIOEJRYXNONXJBcy9WK1JLVFduM1pINGtQSnphUW9YUmtK?=
 =?utf-8?B?U2FKQ2NyaklpN29QUHdSWS9ubkQ0SGY2ZHpzdXAwSUM5cXlvd3Y5UnJlNmdo?=
 =?utf-8?B?VUQrSlN2UStJWHdLdk9sQWhFWjZrV1RJOEN1RzA0WmVQTEVpUUVxRmxaVXRJ?=
 =?utf-8?B?RTVnY0wrRlBOa1lucEdyYnpYRVZ4M0lHVUh4OUdDM2hYQm1oTG8rTGNweWpU?=
 =?utf-8?B?MWRxbU1PUSt2ZkhtT2xDSGtlZUo4L1hqcDZNWnZZaTk4bCttK2JqTmo5bzlZ?=
 =?utf-8?B?K2xQYzROb0xkNjZLdnhvS3gxSHhlME90c2dpNHE0WnJIMUs5a0dwM3QxMFlr?=
 =?utf-8?B?OW9vc1RtcGlDRmFGMGwrZmcxdVM0SDdBR2JBeUhPUGhPNzhDY25BU1h5U05t?=
 =?utf-8?B?RklCYmFSVFRwQ3YraHIxeDl3aUVhYXFCT01rY2hWTm9oN3lsZ0FQRzdvS3kv?=
 =?utf-8?B?UDM3SlVWS1Q3M25uUG5MWUJpRU4zVklBYXVMUENBZVpvaUVOVThTRG9pYVZM?=
 =?utf-8?B?VWw4QnFzL2tMUkxkek5tWElXZzJIQ1QzM0dPeEFmY2JaNXZWNHpGSm16bzBu?=
 =?utf-8?B?SDNYWkFVUVVTcnpyRUw0YnBmb21sTnNIa0VHcU9Temo4RSsrVnF2TXhzNVVT?=
 =?utf-8?Q?XfOXCqx2efKRY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f379f48-89b0-42dc-b21e-08d8b3b1b802
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 08:45:14.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6fiiLUZ9BOHjpQc1ZF7Yj8FPPs568EuMUdfBUTnVoDZG6BNvx9SjIs4DS+9gJtPwaekdxar6ndB1Yprlvn6LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5703
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgU2ViYXN0aWFuLCBQZXRlcg0KDQpUaHVyc2RheSwgSmFudWFyeSA3LCAyMDIxIDExOjI5IFBN
LCBTZWJhc3RpYW4gU2lld2lvciB3cm90ZToNCj4gDQo+IE9uIDIwMjEtMDEtMDcgMTE6NDU6Mzkg
WyswMTAwXSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+ID4gT24gVGh1LCBKYW4gMDcsIDIwMjEg
YXQgMDU6MTg6NDFQTSArMDgwMCwgUmFuIFdhbmcgd3JvdGU6DQo+ID4gPiArDQo+ID4gPiArCQkJ
aWYgKElTX0VOQUJMRUQoQ09ORklHX1BSRUVNUFRfUlQpICYmDQo+ID4gPiArCQkJICAgICFzdHJu
Y21wKHAtPmNvbW0sICJrc29mdGlycWQvIiwgMTApKQ0KPiA+ID4gKwkJCQlzY2hlZHVsZV9ocnRp
bWVvdXQoJnRvLA0KPiA+ID4gKwkJCQkJSFJUSU1FUl9NT0RFX1JFTCB8IEhSVElNRVJfTU9ERV9I
QVJEKTsNCj4gPiA+ICsJCQllbHNlDQo+ID4gPiArCQkJCXNjaGVkdWxlX2hydGltZW91dCgmdG8s
IEhSVElNRVJfTU9ERV9SRUwpOw0KPiA+DQo+ID4gVGhpcyBpcyBob3JyaWZpYywgd2h5IGRpZCB5
b3Ugbm90IHNlbGYtY2Vuc29yIGFuZCBzcGFyZSBtZSB0aGUgbWVudGFsDQo+ID4gYW5ndWlzaCBv
ZiBoYXZpbmcgdG8gZm9ybXVsYXRlIGEgQ29DIGNvbXBsaWFudCByZXNwb25zZT8NCj4gPg0KPiA+
IEl0IGFsc28gdmlvbGF0ZXMgY29kaW5nIHN0eWxlLCBidXQgZ2l2ZW4gdGhlIHRvdGFsIGxhY2sg
b2YgYW55IHNlbnNlLA0KPiA+IHRoYXQgc2VlbXMgbGlrZSBhIG1pbm9yIGRldGFpbC4NCj4gPg0K
PiA+IFdoeSBjYW4ndCB3ZSB1c2UgSFJUSU1FUl9NT0RFX0hBUkQgdW5jb25kaXRpb25hbGx5Pw0K
PiANCj4gSSBoYWQgYSBzaW1pbGFyIHBhdGNoIGluIC1SVCBhbmQgZHJvcHBlZCBpdCBpbiB2NS4x
MC1yYzctcnQxNi4NCj4gSXQgd2FzIGFkZGVkIGJlY2F1c2UgUlQgY291bGRuJ3QgYm9vdCBzaW5j
ZSBjcmVhdGluZyB0aGUgYm9vdC10aHJlYWRzIGRpZG4ndCB3b3JrIGJlZm9yZSB0aGUga3NvZnRp
cnFkIHdhcyB1cC4gVGhpcyB3YXMgZml4ZWQgYnkgY29tbWl0DQo+ICAgIDI2YzcyOTViZTBjNWUg
KCJrdGhyZWFkOiBEbyBub3QgcHJlZW1wdCBjdXJyZW50IHRhc2sgaWYgaXQgaXMgZ29pbmcgdG8g
Y2FsbCBzY2hlZHVsZSgpIikNCg0KSSB0cmllZCBhcHBseWluZyBhYm92ZSBjb21taXQgdG8gbGlu
dXgtNS42LnktcnQsIGl0IGNvdWxkIHJlc29sdmUgbXkgcHJvYmxlbSBvbiBMWDIxNjBBUkRCLCBU
SEFOS1MhDQoNCj4gYW5kIGxpdmUgd2FzIGdvb2QgYWdhaW4uDQo+IHRnbHggKGFsc28pIHN1Z2dl
c3RlZCB0byBhZGQgSFJUSU1FUl9NT0RFX0hBUkQgdW5jb25kaXRpb25hbGx5IChpdCBsb29rZWQg
YXQgU1lTVEVNX1NUQVRFIGJhY2sgdGhlbikgYW5kIEkgd2FzIG9ubHkgd29ycmllZCBzb21lDQo+
IGFidXNlIHZpYSB1c2VybGFuZC4NCg0KR290IGl0Lg0KDQpSZWdhcmRzLA0KUmFuDQoNCj4gVGhp
cyBzbGVlcCBjYW4gYmUgdHJpZ2dlcmVkIGJ5IHB0cmFjZS9zdHJhY2UoKSBhbmQgd2l0aCBicmll
ZiB0ZXN0aW5nIEkgY2FuIHRyaWdnZXIgdGhlIHNsZWVwIHRoZXJlIGJ1dCBJIGRvbid0IGdldCBp
dCBhbnl3aGVyZSBuZWFyIHdoZXJlIEkNCj4gd291bGQgbm90aWNlIGl0IHdpdGggY3ljbGljdGVz
dC4NCj4gDQo+IFNlYmFzdGlhbg0K
