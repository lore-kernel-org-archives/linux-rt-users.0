Return-Path: <SRS0=2ve0=XL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336A3C49ED7
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 11:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED6B2067B
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 11:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfIPLaf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:30:35 -0400
Received: from mailin.dlr.de ([194.94.201.12]:17267 "EHLO mailin.dlr.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfIPLae (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Sep 2019 07:30:34 -0400
IronPort-SDR: O6Hi3hirLNjDj793PBmbz2bnIDKHNpQSqoQp/yH+u8BmbkWVBpJn1z8bQlZcP0l40TfxTdzjFP
 BvN01vfGI5DA==
IronPort-PHdr: =?us-ascii?q?9a23=3Azh7uoR8o4Qq9B/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B31OocTK2v8tzYMVDF4r011RmVBN6dsqkP17Ke8/i5HzBZu9DZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMLjYZsJao8xQ?=
 =?us-ascii?q?fFqWZMd+hK2G9kP12ekwvi6suq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjeK7WYNEUSn?=
 =?us-ascii?q?dbXstJVyJPHJ6yb5cBAeQCM+ZXrYj9qEcBoxSxHgSsGPjgxztUinPqwaE30e?=
 =?us-ascii?q?IsGhzG0gw6GNIOtWzZodLyOqgIS+C10KjIzTPZY/xW2Df98pTIchA6rP6RWb?=
 =?us-ascii?q?Jwa9DdxlQxGA7ciFibtI/rPyuN2+gQr2SX9fdsWOGghmI9tg18rDuiyt0xho?=
 =?us-ascii?q?THno4Z10zI+T9kzIs2KtC0UlN3bNCnHZdKqS2XN4R7Tts/T2xpvCs20KMKtJ?=
 =?us-ascii?q?60cSQQyJkr3RrSZ+CBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl8Emv3ziB2Q/T5O9EJk46lq3VJYQ9zrM+mZ?=
 =?us-ascii?q?QcsFrOEjX3mEXwkK+WbF8r9vK15OTjeLXqvIKTOJFshgH/NKQhhNC/DPwlPg?=
 =?us-ascii?q?QSRWSX5Oex2bL58UHkTrhHjec6nrTXvZzCIMQUvK+5Awtb0oY57Ba/Ci+r3t?=
 =?us-ascii?q?MCknkdMFJFeRSHg5LpNFHPOvD4Efe/jk+xnzdv3fDKJKDuDYvVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcr1t9f5p1UBa8bL/LoWk78r9jYDh4/Mwyp3+bnEtJ91oUfWWOAGK?=
 =?us-ascii?q?OWLb3du0eS5u0zO+mMeJMVuDHlJvgh5v7ui2I5mFAEcamzwZsbcW24Hu94LE?=
 =?us-ascii?q?WDenrhmckBEWgUsQokVuDqi0ONUSRVZ3msW6Iw/DY7CJipDdSLeof41LaA0y?=
 =?us-ascii?q?qyBYx+YmFAF0yWFnHpZ8OIVqFfRjiVJ5o1tzUeSbmnDbAgzw2unAP+0fxrI7?=
 =?us-ascii?q?yHqWUjqZv/2Y0ttKXonhYo+GksAg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FKAACOcX9d/w2KuApmHQEBBQEHBQG?=
 =?us-ascii?q?BUwgBCwEBgWcFgkYKhBeIHIh6mR+BewkBAQEBAQEBAQE3AQGEPwIXgnw0CQ4?=
 =?us-ascii?q?CAwkBAQUBAQEBAQUEAQEChiNCARABgWYignABAQECASMRRQULAgEiAgYdAwI?=
 =?us-ascii?q?CAjAUARACBA4FCBOFA6t5gTKKRoEMKAGODoFXgwqEJAEBIEuCPjKCJgSPSp0?=
 =?us-ascii?q?gB4E+lgKNdYskqQWCEXGDO4NpAQeNFnOFIYkQgSKBIwEB?=
X-IronPort-AV: E=Sophos;i="5.64,512,1559512800"; 
   d="scan'208";a="22069321"
From:   <Martin.Wirth@dlr.de>
To:     <bigeasy@linutronix.de>
CC:     <linux-rt-users@vger.kernel.org>
Subject: AW: Long latencies during disk-io
Thread-Topic: Long latencies during disk-io
Thread-Index: AdViKHO+FfcazwTSRQyE6lOjoeuKGABxyK6AADCJtLAADzHggAC3oaWwAJaf+oAABPD7EP//8ZGA//toPFA=
Date:   Mon, 16 Sep 2019 11:30:30 +0000
Message-ID: <1A2AF5F768264E479963C4D8C015EB696C520504@DLDEFFMIMP02EXC.intra.dlr.de>
References: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190905154115.mnid6rue65x6vvt6@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51159F@DLDEFFMIMP02EXC.intra.dlr.de>
 <CABsbf=EsGK0-teWZ7vGuKS=edz+uCoxcd6KdoU5Cf_2gdeEhtg@mail.gmail.com>
 <1A2AF5F768264E479963C4D8C015EB696C515541@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913133655.2pbhnxm5ndcje3bk@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51C1F1@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913150645.nqt4ekv466yby2a4@linutronix.de>
In-Reply-To: <20190913150645.nqt4ekv466yby2a4@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: 470DA0FAD5DE46E1AD199CC32A2B8E6B7071DF2ED51EB37381E329C0FD2013652000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgU2ViYXN0aWFuLA0KDQo+IFZvbjogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciBbbWFpbHRv
OmJpZ2Vhc3lAbGludXRyb25peC5kZV0NCj4gR2VzZW5kZXQ6IEZyZWl0YWcsIDEzLiBTZXB0ZW1i
ZXIgMjAxOSAxNzowNw0KPiBwdWguIFNvIHlvdSBuZWVkIHRvIHNwZWNpZnkgSVJRRl9PTkVTSE9U
IHNvIHRoYXQgdGhlIElSUS1jb3JlIGRpc2FibGVzDQo+IHRoZSBpbnRlcnJ1cHQgbGluZSB1bnRp
bCB0aGUgdGhyZWFkZWQgaGFuZGxlciBmaW5pc2hlcyBpdHMgd29yayAoYQ0KPiBkZXRhaWwgSSBm
b3Jnb3QgdG8gbWVudGlvbiBpbiB0aGUgcHJldmlvdXMgbWFpbCkuIFlvdSBhcmUgbm90IGFsbG93
ZWQgdG8NCj4gbWl4IHRoZSBJUlFGX09ORVNIT1QgZmxhZyB3aXRoIG11bHRpcGxlIGhhbmRsZXJz
IChlaXRoZXIgYWxsIHNob3VsZCBoYXZlDQo+IHRoZW0gb3Igbm9uZSkuIFNvIEkgdGhpbmsgaW4g
dGhlIGZvcmNlLXRocmVhZGVkIGNhc2UgeW91IHNob3VsZCBiZSBmaW5lDQo+IGJ1dCBpbiB0aGUg
bm9uLXRocmVhZGVkIGNhc2UgeW91IHdvdWxkIGhhdmUgdHJvdWJsZS4NCg0KSSB0cmllZCB0aGUg
cmVxdWVzdF90aHJlYWRlZF9pcnEoLi4sIHZJbnRlcnJ1cHRTZXJ2aWNlLCBJUlFGX1NIQVJFRHxJ
UlFGX09ORVNIT1QsIC4uLikgDQp2YXJpYW50IGFuZCBpbmRlZWQgdGhlIGxhdGVuY3kgc3Bpa2Vz
IGNhdXNlZCBieSBjb25jdXJyZW50IGRpc2staW8gZ28gYXdheSEhDQoNClNvIEkgbm93IGhhdmUg
YSB3b3JraW5nIHNvbHV0aW9uIGZvciBtZSBhbmQgYWxzbyBsZWFybmVkIGhvdyB0byBzZXBhcmF0
ZSBpbnRlcnJ1cHRzDQp1c2luZyAvcHJvYy9pcnEgYXMgYSBzZWNvbmQgb3B0aW9uIHRvIGNvcGUg
d2l0aCB0aGlzIHByb2JsZW0uDQoNCkJ1dCBpbiBnZW5lcmFsIEkgZmluZCBpdCBub3QgdmVyeSB0
cmFuc3BhcmVudCB0aGF0IHdpdGggdGhlIGxhdGVzdCBjaGFuZ2VzIHNvZnRpcnEgd29yayBjYW4g
YmxvY2sNCmhpZ2hlciBwcmlvcml0eSBpcnEgdGhyZWFkcyBmb3Igc2V2ZXJhbCBtcyBvciBtYXli
ZSBldmVuIGxvbmdlciBhbmQgbm90aGluZyBjYW4gYmUgZG9uZSANCmFnYWluc3QgaXQgd2l0aCBu
b3JtYWwgUlQgY29udHJvbC1rbm9icywgYnV0IGEgY2hhbmdlIHRvIHRoZSBkcml2ZXIgY29kZSBp
cyByZXF1aXJlZC4NCklzbid0IHRoZXJlIGFuIGF1dG9tYXRpYyB3YXkgdG8gZGVjaWRlLCB3aGVu
IGl0IGlzIHBvc3NpYmxlIHRvIGNvbnZlcnQgYSByZXF1ZXN0X2lycSB0byBhIA0KcmVxdWVzdF90
aHJlYWRlZF9pcnE/IA0KDQpNYXJ0aW4NCg==
