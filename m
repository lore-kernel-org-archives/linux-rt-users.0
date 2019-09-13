Return-Path: <SRS0=sGjS=XI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E2C49ED7
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Sep 2019 14:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CCC20717
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Sep 2019 14:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbfIMOJq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:09:46 -0400
Received: from mailin.dlr.de ([194.94.201.12]:14674 "EHLO mailin.dlr.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388542AbfIMOJp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Sep 2019 10:09:45 -0400
IronPort-SDR: V+R0VApFi0fiWBwTX7BnIErgJVmwiRsNfO+DXLgEbV1OvhTa/F5NkMmBWN2KALiMvdWPb59N13
 PSug5VhnfFsA==
IronPort-PHdr: =?us-ascii?q?9a23=3AAj1B6RzOuvKbtNjXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2ukWIJqq85mqBkHD//Il1AaPAdyAraobwLWM++C4ACpcuMzH6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjfu8UMnYdvKKk9xx?=
 =?us-ascii?q?nXrnBVf+ha2X5kKUickhrh+Mu85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y6XQds4YS2?=
 =?us-ascii?q?VcRMZcTyxPDJ2hYYsTAeQPPuhYoIv8p1QSohWxChKhBP/0xTJMmnP6wbE23u?=
 =?us-ascii?q?YnHArb3AIgBdUOsHHModjyM6kdS/q1zLXJzTXFdf9Z2Tb96JLUchAhuvyDQL?=
 =?us-ascii?q?ZwcdDLxUYyCQzIl1OdopHmMTONzukBrnSX4/B9We+shGMrsRx9rzasy8s2l4?=
 =?us-ascii?q?XFm5oZxk3Y+Slj3Yo4JtK1RFRmbdOqE5ZcrT+WOot5T886Xm1luSI3xqcYtZ?=
 =?us-ascii?q?O7cyUG0pQqywTbZvCbdYWD/wjtW/yLIThigXJoYLe/hxGv/ke+0uD8Tcy00E?=
 =?us-ascii?q?pSripCj9nMqmgB1xzN5ciDTftw5kmv1zCB2Q7c6u9KIUc6m6ncJZA73rI8i5?=
 =?us-ascii?q?UdvkXdEyPsmUX2irOWdl8+9eSy9uvnZq/mqoWBOIBqkg3+M6IuldKjAekgLw?=
 =?us-ascii?q?QCQ3KX9fm/2bDs50H1XbtHg/4snqXErZzWPcEbqbS4Aw9R3IYj8RG/DzK+3d?=
 =?us-ascii?q?ofh3YHNk5FeBOBj4TzO17OIer4Deu/g1m3jThrw+rGMqf8DZrTNnTDiqvufa?=
 =?us-ascii?q?5h605Azwo+1ctQ55NbCr4fOv3zQU/wucfcDh84NQy03vrnCM961oMYWGKODb?=
 =?us-ascii?q?WVP77MvlWQ/OIgP/GMZJMJuDb6M/Ul4//ujXkkmV4SZKWpx4cXZGmlHvR9PU?=
 =?us-ascii?q?qZe2Hsj8wfEWcFoAU+VvbmiF6cXj5JYXa9QaY86is8CIK8AofJXpqtj6CZ3C?=
 =?us-ascii?q?enAp1WYXhLBUqREXfza4WEWvEMZDiWIs9glDwESLegRpQu1RGrrgD6yr5nIv?=
 =?us-ascii?q?DI9S0fsJKwnORysrnZlB4//CdlJ8Cc1XyRVWZyn3NOSzJgj45lpkkonnKKy7?=
 =?us-ascii?q?R5hbpnFMZP59tFVh18OZOKnL8yMMz7Rg+UJoTBc12hWNjzWTw=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2H0AADVontd/wuKuApmHgEGBwaBUwk?=
 =?us-ascii?q?LAQGCb4FDCoQXkROZHoF7CQEBAQEBAQEBATcBAYQ/AheCbTQJDgIDCQEBBQE?=
 =?us-ascii?q?BAQEBBgQBAQKGI0IBEAGBZiKCcAEBAQIBIxFFBQsCASICBh0DAgICMBQBEAI?=
 =?us-ascii?q?EDgUIE4UDqmOBMoo+gQwoAY4OgRFGgwqERkuCPjKCJgSMOIMEnQsHgT2VeY1?=
 =?us-ascii?q?piyGoZ4IRcYM7kQdzhQeJfoEjAQE?=
X-IronPort-AV: E=Sophos;i="5.64,501,1559512800"; 
   d="scan'208";a="21995786"
From:   <Martin.Wirth@dlr.de>
To:     <bigeasy@linutronix.de>
CC:     <linux-rt-users@vger.kernel.org>, <austin.linux@gmail.com>
Subject: AW: Long latencies during disk-io
Thread-Topic: Long latencies during disk-io
Thread-Index: AdViKHO+FfcazwTSRQyE6lOjoeuKGABxyK6AADCJtLAADzHggAC3oaWwAJaf+oAABPD7EA==
Date:   Fri, 13 Sep 2019 14:09:22 +0000
Message-ID: <1A2AF5F768264E479963C4D8C015EB696C51C1F1@DLDEFFMIMP02EXC.intra.dlr.de>
References: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190905154115.mnid6rue65x6vvt6@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51159F@DLDEFFMIMP02EXC.intra.dlr.de>
 <CABsbf=EsGK0-teWZ7vGuKS=edz+uCoxcd6KdoU5Cf_2gdeEhtg@mail.gmail.com>
 <1A2AF5F768264E479963C4D8C015EB696C515541@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913133655.2pbhnxm5ndcje3bk@linutronix.de>
In-Reply-To: <20190913133655.2pbhnxm5ndcje3bk@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: 960290D6097BE63A925DE78534A532242DC904C28DB5B43CE9D4D27C60B146CA2000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgU2ViYXN0aWFuDQoNCj4gVm9uOiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIFttYWlsdG86
YmlnZWFzeUBsaW51dHJvbml4LmRlXQ0KPiBTbyB0aGlzIGRlbGF5IGlzIGNhdXNlZCBieSB0aGUg
c29mdGlycSByZXdvcmsuIEkgZGlkbid0IHRoaW5rIGFib3V0IHRoaXMNCj4gYnV0IG5vdyB0aGF0
IHlvdSBzaG93IHRoZSB0cmFjZSBpdCBpcyBvYnZpb3VzLg0KPiANCj4gSWYgeW91IHVzZQ0KPiAJ
cmVxdWVzdF90aHJlYWRlZF9pcnEoLCBOVUxMLCB2SW50ZXJydXB0U2VydmljZSwg4oCmKTsNCj4g
DQo+IGluc3RlYWQgb2YNCj4gCXJlcXVlc3RfaXJxKCwgdkludGVycnVwdFNlcnZpY2UsIOKApik7
DQo+IA0KPiB0aGVuIHRoZSBJUlEgd2lsbCBub3QgYmUgZm9yY2UgdGhyZWFkZWQgKGJ1dCB0aHJl
YWRlZCBvbiByZXF1ZXN0KSBhbmQNCj4gdGhlcmUgd2lsbCBiZSBubyBsb2NhbF9iaF9kaXNhYmxl
KCkgYmVmb3JlIHRoZSB0aHJlYWQgaXMgaW52b2tlZC4gU28gbm8NCj4gd2FpdGluZyB1bnRpbCB0
aGUgQUhDSSB0aHJlYWQgaXMgZG9uZS4NCj4gDQo+IElmIHZJbnRlcnJ1cHRTZXJ2aWNlKCkgZG9l
cyBub3RoaW5nIGVsc2UgdGhhbiBqdXN0IHdha2UgdXAgdXNlcmxhbmQgdGhlbg0KPiB5b3UgY291
bGQgdXNlIHN3YWl0X2V2ZW50X+KApigpIC8gc3dha2VfdXBfb25lKCkgaW5zdGVhZCBvZiB0aGUN
Cj4gd2FpdF9ldmVudF/igKYgLyB3YWtlX3VwKCkgY29tYm8uIFRoYXQgd291bGQgYmUgYWxsb3dl
ZCBmcm9tIHRoZSBwcmltYXJ5DQo+IGhhbmRsZXIgYW5kIHlvdSBjb3VsZCBhdm9pZCB0aGUgc3dp
dGNoIHRvIHRoZSB0aHJlYWRlZC1oYW5kbGVyLg0KDQp0aGFua3MgZm9yIHRoZSB0aG9yb3VnaCBh
bmFseXNpcyENCg0KSSB3aWxsIHRyeSB0aGUgcmVxdWVzdF90aHJlYWRlZF9pcnEoLCBOVUxMLCB2
SW50ZXJydXB0U2VydmljZSwg4oCmKSBzb2x1dGlvbiBvbiANCk1vbmRheSBhbmQgcmVwb3J0IGJh
Y2suIFNpbmNlIHRoZSBkcml2ZXIgYWxzbyBhbGxvd3MgdG8gcG9sbCBzZXZlcmFsIGNhcmRzIA0K
KHdoaWNoIEkgZG9uJ3QgdXNlIGF0IHRoZSBtb21lbnQpIEkgdGhpbmsgaXQgaXMgbm90IHBvc3Np
YmxlIHRvIHN3aXRjaCB0byBzd2FpdC9zd2FrZS4uLg0KQW5kIHRoZSBpbnRlcnJ1cHQgbGluZSBt
YXkgYmUgc2hhcmVkIGFuZCBpZiBJIHJlbWVtYmVyIGNvcnJlY3RseSBpbiB0aGlzIGNhc2UgaXQg
aXMgYWxzbyANCm5vdCBwb3NzaWJsZSB0byB1c2UgcHJpbWFyeSBoYW5kbGVycywgb3IgYW0gSSB3
cm9uZz8gIA0KIA0KQ2hlZXJzLA0KTWFydGluDQo=
