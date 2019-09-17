Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B407C4CECD
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 11:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC8921881
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 11:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfIQLJf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:09:35 -0400
Received: from mailin.dlr.de ([194.94.201.12]:11516 "EHLO mailin.dlr.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfIQLJf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 07:09:35 -0400
IronPort-SDR: cBtovh5XzhNhnRJdRZvnrB2FTHhEcnb2LtJBbMN9Vds2MpLwy//2KPQnI9ZiW9DUZBgIxsF9Ec
 dELQN1sSXDOQ==
IronPort-PHdr: =?us-ascii?q?9a23=3AR3710B8qtOe9tf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B31OocTK2v8tzYMVDF4r011RmVBN6dsqwP07ue8/i5HzBZu9DZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMLjYZjJao91h?=
 =?us-ascii?q?/EqWZMd+hK2G9kP12ekwvi6suq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjeK7WYNEUSn?=
 =?us-ascii?q?dbXstJVyJPHJ6yb5cBAeQCM+ZXrYj9qEcBoxSxHgSsGPjgxztUinPqwaE30e?=
 =?us-ascii?q?IsGhzG0gw6GNIOtWzZodLyOqgIS+C10KjIzTPZY/xW2Df98pTIchA6rP6RWb?=
 =?us-ascii?q?Jwa9DdxlQxGA7ciFibtI/rPyuN2+gQr2SX9fdsWOGghmI9tg18rDuiyt0xho?=
 =?us-ascii?q?TGno4Z10zI+T9kzIs2KtC0UlN3bNCnHZdKqS2XN4R7Tts/T2xpvCs20KMKtJ?=
 =?us-ascii?q?60cSQQyJkr3RrSZ+CBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl8Emv3ziB2Q/T5O9EJk46lq3VJYQ9zrM/mZ?=
 =?us-ascii?q?QcsFrOEjX3mEXwkK+WbF8r9vK15OTjeLXqvIKTOJFshgH/NKQhhNC/DPwlPg?=
 =?us-ascii?q?QSRWSX5Oex2bL58UHkTrhHjec6nrTWvZzCIMQUvK+5Awtb0oY57Ba/Ci+r3t?=
 =?us-ascii?q?MCknkdMFJFeRSHg5LpNFHPOvD4Efe/jk+xnzdv3fDKJKDuDYvVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcr1t9f5p1UBa8bL/LoWk78r9jYDh4/Mwyp3+bnEtJ91oUfWWOAGK?=
 =?us-ascii?q?OWLb3du0eS5u0zO+mMeJMVuDHlJvgh5v7ui2I5mFAEcamzwZsbcW24Hu94LE?=
 =?us-ascii?q?WDenrhmckBEWgUsQokVuDqi0ONUSRVZ3msW6Iw/DY7CJipDdSLeof41LaA0y?=
 =?us-ascii?q?qyBYx+YmFAF0yWFnHpZ8OIVqFfRjiVJ5o1tzUeSbmnDbAgzw2unAP+0fxrI7?=
 =?us-ascii?q?yHqWUjqZv/2Y0ttKXonhYo+GksAg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HWAABAvoBd/w6KuApmHQEBBQEHBQG?=
 =?us-ascii?q?BVAcBCwEBgm+BQwqEF5EYmSCBewkBAQEBAQEBAQE3AQGEPwIXgwM1CA4CAwk?=
 =?us-ascii?q?BAQUBAQEBAQUEAQEChiNCARABgWYignABAQECASMRRQULAgEiAgYdAwICAjA?=
 =?us-ascii?q?UARACBA4FCIUWrUSBMopPgQwoAY4OgVeDCoRGS4I+MoImBIxGgweOQo5gB4E?=
 =?us-ascii?q?+lgONdYslqQoBgg5xgzuRB3OFIYoygSMBAQ?=
X-IronPort-AV: E=Sophos;i="5.64,516,1559512800"; 
   d="scan'208";a="22121786"
From:   <Martin.Wirth@dlr.de>
To:     <bigeasy@linutronix.de>
CC:     <linux-rt-users@vger.kernel.org>
Subject: AW: Long latencies during disk-io
Thread-Topic: Long latencies during disk-io
Thread-Index: AdViKHO+FfcazwTSRQyE6lOjoeuKGABxyK6AADCJtLAADzHggAC3oaWwAJaf+oAABPD7EP//8ZGA//toPFCACpoVAP//3gIw
Date:   Tue, 17 Sep 2019 11:09:31 +0000
Message-ID: <1A2AF5F768264E479963C4D8C015EB696C521875@DLDEFFMIMP02EXC.intra.dlr.de>
References: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190905154115.mnid6rue65x6vvt6@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51159F@DLDEFFMIMP02EXC.intra.dlr.de>
 <CABsbf=EsGK0-teWZ7vGuKS=edz+uCoxcd6KdoU5Cf_2gdeEhtg@mail.gmail.com>
 <1A2AF5F768264E479963C4D8C015EB696C515541@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913133655.2pbhnxm5ndcje3bk@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51C1F1@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913150645.nqt4ekv466yby2a4@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C520504@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190917105236.yf5btniiq4bjhimo@linutronix.de>
In-Reply-To: <20190917105236.yf5btniiq4bjhimo@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: 0242332E1220D0BD3CA87A0980AF885FE7CED34F2028BF31EE46B6FF1132030C2000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgU2ViYXN0aWFuLA0KDQo+IFZvbjogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciBbbWFpbHRv
OmJpZ2Vhc3lAbGludXRyb25peC5kZV0NCj4gR2VzZW5kZXQ6IERpZW5zdGFnLCAxNy4gU2VwdGVt
YmVyIDIwMTkgMTI6NTMNCj4gDQoNCj4gRHVlIHRvIHRoZSBzb2Z0aXJxIHJld29yayB3ZSBjYW4n
dCBoYXZlIG11bHRpcGxlIHNvZnRpcnFzIHZlY3RvcnMNCj4gcnVubmluZyBpbiBwYXJhbGxlbCBf
b3JfIGhhdmUgbXVsdGlwbGUgbG9jYWxfYmhfZGlzYWJsZSgpIHNlY3Rpb24gd2hpY2gNCj4gYXJl
IGV4ZWN1dGVkIGluIHBhcmFsbGVsIG9uIHRoZSBzYW1lIENQVS4gVGhpcyBtYWRlIHRoZSBzb2Z0
aXJxIGNvZGUgbm90DQo+IG9ubHkgc2ltcGxlciBidXQgYWxzbyBhbGxvd2VkIHVzIHRvIHJlbW92
ZSBhIGxpdHRsZSBiaXQgZHVjdCB0YXBlIGZyb20NCj4gcGxhY2VzIHdoaWNoIHdlcmUgZXhwZWN0
aW5nIHRoaXMga2luZCBvZiBiZWhhdmlvdXIuDQoNCk9rIHRoYXQgZXhwbGFpbnMgd2h5IEkgaGF2
ZW7igJl0IHNlZW4gdGhpcyB3aXRoIG9sZGVyIFJUIGtlcm5lbHMsIA0KYWx0aG91Z2ggdGhlIGZv
cmNlLXRocmVhZGluZyB3YXMgYWx3YXlzIHRoZXJlLi4uDQoNCj4gSW4gdGhlIGxvbmcgdGVybSB3
ZSBuZWVkIHRvIGZpZ3VyZSBvdXQgaWYgd2Ugd2FudCB0byBnbyBkb3duIHRoYXQgcm9hZA0KPiBh
Z2FpbiBhbmQgaWYgc28gd2UgbmVlZCB0byBmaWd1cmUgb3V0IGhvdyB0byBhdm9pZCB0aGF0IGR1
Y3QgdGFwZeKApg0KDQpNYXliZSBub3QuIEJ1dCB0aGlzIG1lYW5zIHRoYXQgYSBsb3Qgb2YgZHJp
dmVycyB3aGljaCBoYXZlIG5vIHJlcXVpcmVtZW50IA0KdG8gYmUgcHJvdGVjdGVkIGFnYWluc3Qg
c29mdGlycSB3aWxsIGhhdmUgdG8gYmUgY29udmVydGVkIHRvIG1ha2UgdGhlbSBmaXQgZm9yIFJU
LiANCkJ1dCBtYXliZSBJJ20gd3JvbmcgYW5kIG1vc3QgUlQgYXBwbGljYXRpb25zIGFyZSB0cmln
Z2VyZWQgYnkgdGhlIHRpbWVyIA0KYW5kIG5vdCBieSBzb21lIGlvLWNhcmQuLi4NCg0KVGhhbmtz
IGFnYWluIGZvciBhbGwgdGhlIHdvcmshDQoNCk1hcnRpbg0K
