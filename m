Return-Path: <SRS0=UNtE=RL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D53C43381
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Mar 2019 00:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B082054F
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Mar 2019 00:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCHAKR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:10:17 -0500
Received: from mail5.windriver.com ([192.103.53.11]:47414 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfCHAKR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Mar 2019 19:10:17 -0500
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2807qdM032383
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 7 Mar 2019 16:08:02 -0800
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.68]) by
 ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0439.000; Thu, 7
 Mar 2019 16:07:41 -0800
From:   "Liu, Yongxin" <Yongxin.Liu@windriver.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "Gortmaker, Paul" <Paul.Gortmaker@windriver.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [PATCH RT] nvdimm: make lane acquirement RT aware
Thread-Topic: [PATCH RT] nvdimm: make lane acquirement RT aware
Thread-Index: AQHU1AQaa42orSwEx0mmBzBs0WZNkaYAw5wAgAAVVLA=
Date:   Fri, 8 Mar 2019 00:07:41 +0000
Message-ID: <597B109EC20B76429F71A8A97770610D12A52669@ALA-MBD.corp.ad.wrs.com>
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
 <20190307143344.ytsnbmot5tjzjhip@linutronix.de>
In-Reply-To: <20190307143344.ytsnbmot5tjzjhip@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.162.171]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1rZXJuZWwtb3duZXJA
dmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yDQo+IFNlbnQ6IFRo
dXJzZGF5LCBNYXJjaCA3LCAyMDE5IDIyOjM0DQo+IFRvOiBMaXUsIFlvbmd4aW4NCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJ0LXVzZXJzQHZnZXIua2VybmVsLm9y
ZzsNCj4gdGdseEBsaW51dHJvbml4LmRlOyByb3N0ZWR0QGdvb2RtaXMub3JnOyBkYW4uai53aWxs
aWFtc0BpbnRlbC5jb207DQo+IHBhZ3VwdGFAcmVkaGF0LmNvbTsgR29ydG1ha2VyLCBQYXVsOyBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUlRdIG52ZGlt
bTogbWFrZSBsYW5lIGFjcXVpcmVtZW50IFJUIGF3YXJlDQo+IA0KPiBPbiAyMDE5LTAzLTA2IDE3
OjU3OjA5IFsrMDgwMF0sIFlvbmd4aW4gTGl1IHdyb3RlOg0KPiA+IEluIHRoaXMgY2hhbmdlLCB3
ZSByZXBsYWNlIGdldF9jcHUvcHV0X2NwdSB3aXRoIGxvY2FsX2xvY2tfY3B1Lw0KPiA+IGxvY2Fs
X3VubG9ja19jcHUsIGFuZCBpbnRyb2R1Y2UgcGVyIENQVSB2YXJpYWJsZSAibmRsX2xvY2FsX2xv
Y2siLg0KPiA+IER1ZSB0byBwcmVlbXB0aW9uIG9uIFJULCB0aGlzIGxvY2sgY2FuIGF2b2lkIHJh
Y2UgY29uZGl0aW9uIGZvciB0aGUNCj4gPiBzYW1lIGxhbmUgb24gdGhlIHNhbWUgQ1BVLiBXaGVu
IENQVSBudW1iZXIgaXMgZ3JlYXRlciB0aGFuIHRoZSBsYW5lDQo+ID4gbnVtYmVyLCBsYW5lIGNh
biBiZSBzaGFyZWQgYW1vbmcgQ1BVcy4gIm5kbF9sb2NrLT5sb2NrIiBpcyB1c2VkIHRvDQo+ID4g
cHJvdGVjdCB0aGUgbGFuZSBpbiB0aGlzIHNpdHVhdGlvbi4NCj4gDQo+IHNvIHdoYXQgd2FzIHRo
ZSByZWFzb24gdGhhdCBnZXRfY3B1KCkgY2FuJ3QgYmUgcmVwbGFjZWQgd2l0aA0KPiByYXdfc21w
X3Byb2Nlc3Nvcl9pZCgpPw0KPiANCj4gU2ViYXN0aWFuDQoNClRoZSBsYW5lIGlzIGNyaXRpY2Fs
IHJlc291cmNlIHdoaWNoIG5lZWRzIHRvIGJlIHByb3RlY3RlZC4gT25lIENQVSBjYW4gdXNlIG9u
bHkgb25lDQpsYW5lLiBJZiBDUFUgbnVtYmVyIGlzIGdyZWF0ZXIgdGhhbiB0aGUgbnVtYmVyIG9m
IHRvdGFsIGxhbmUsIHRoZSBsYW5lIGNhbiBiZSBzaGFyZWQNCmFtb25nIENQVXMuIA0KDQpJbiBu
b24tUlQga2VybmVsLCBnZXRfY3B1KCkgZGlzYWJsZSBwcmVlbXB0aW9uIGJ5IGNhbGxpbmcgcHJl
ZW1wdF9kaXNhYmxlKCkgZmlyc3QuDQpPbmx5IG9uZSB0aHJlYWQgb24gdGhlIHNhbWUgQ1BVIGNh
biBnZXQgdGhlIGxhbmUuDQoNCkluIFJUIGtlcm5lbCwgaWYgd2Ugb25seSB1c2UgcmF3X3NtcF9w
cm9jZXNzb3JfaWQoKSwgdGhpcyBkb2Vzbid0IHByb3RlY3QgdGhlIGxhbmUuIA0KVGh1cyB0d28g
dGhyZWFkcyBvbiB0aGUgc2FtZSBDUFUgY2FuIGdldCB0aGUgc2FtZSBsYW5lIGF0IHRoZSBzYW1l
IHRpbWUuDQoNCkluIHRoaXMgcGF0Y2gsIHR3by1sZXZlbCBsb2NrIGNhbiBhdm9pZCByYWNlIGNv
bmRpdGlvbiBmb3IgdGhlIGxhbmUuDQoNCiAgICAgICAgICBDUFUgQSAgICAgICAgICAgICAgICAg
IENQVSBCIChCID09IEEgJSBudW1fbGFuZXMpDQogDQogICAgdGFzayBBMSAgICB0YXNrIEEyICAg
ICB0YXNrIEIxICAgIHRhc2sgQjINCiAgICAgICB8ICAgICAgICAgIHwgICAgICAgICAgIHwgICAg
ICAgICAgfA0KICAgICAgIHxfX19fX19fX19ffCAgICAgICAgICAgfF9fX19fX19fX198DQogICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICBuZGxfbG9jYWxfbG9jayAg
ICAgICAgICAgbmRsX2xvY2FsX2xvY2sNCiAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgfA0KICAgICAgICAgICAgfF9fX19fX19fX19fX19fX19fX19fX198DQogICAgICAgICAgICAg
ICAgICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgICAgICAg
bmRsX2xvY2stPmxvY2sNCiAgICAgICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgICAg
ICAgICAgICB8DQogICAgICAgICAgICAgICAgICAgICAgbGFuZQ0KDQogDQpUaGFua3MsDQpZb25n
eGluDQo=
