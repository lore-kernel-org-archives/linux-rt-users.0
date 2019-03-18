Return-Path: <SRS0=5OrQ=RV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442DC43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Mar 2019 11:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DF220854
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Mar 2019 11:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCRLtR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:49:17 -0400
Received: from mail.windriver.com ([147.11.1.11]:34792 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfCRLtQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Mar 2019 07:49:16 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x2IBmTqF028694
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 18 Mar 2019 04:48:29 -0700 (PDT)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.68]) by
 ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0439.000; Mon,
 18 Mar 2019 04:48:28 -0700
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
Thread-Index: AQHU1AQaa42orSwEx0mmBzBs0WZNkaYAw5wAgAAVVLCAAStcgIADmlcQgAfK3QCAA0RWUIABHjGA//+MC+A=
Date:   Mon, 18 Mar 2019 11:48:28 +0000
Message-ID: <597B109EC20B76429F71A8A97770610D12A649C1@ALA-MBD.corp.ad.wrs.com>
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
 <20190307143344.ytsnbmot5tjzjhip@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A52669@ALA-MBD.corp.ad.wrs.com>
 <20190308094131.ge4wbsvz4p6xikdf@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A5643B@ALA-MBD.corp.ad.wrs.com>
 <20190315164236.rzbwe7reeprjv3um@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A63C81@ALA-MBD.corp.ad.wrs.com>
 <20190318114017.tazjaegln2obt3zg@linutronix.de>
In-Reply-To: <20190318114017.tazjaegln2obt3zg@linutronix.de>
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LWtlcm5lbC1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1rZXJuZWwtDQo+IG93bmVyQHZnZXIua2Vy
bmVsLm9yZ10gT24gQmVoYWxmIE9mIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3INCj4gU2VudDog
TW9uZGF5LCBNYXJjaCAxOCwgMjAxOSAxOTo0MA0KPiBUbzogTGl1LCBZb25neGluDQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1ydC11c2Vyc0B2Z2VyLmtlcm5lbC5v
cmc7DQo+IHRnbHhAbGludXRyb25peC5kZTsgcm9zdGVkdEBnb29kbWlzLm9yZzsgZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tOw0KPiBwYWd1cHRhQHJlZGhhdC5jb207IEdvcnRtYWtlciwgUGF1bDsg
bGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJUXSBudmRp
bW06IG1ha2UgbGFuZSBhY3F1aXJlbWVudCBSVCBhd2FyZQ0KPiANCj4gT24gMjAxOS0wMy0xOCAw
MTo0MToxMCBbKzAwMDBdLCBMaXUsIFlvbmd4aW4gd3JvdGU6DQo+ID4NCj4gPiBDb25zaWRlciB0
aGUgcmVjdXJzaXZlIGNhbGwgdG8gbmRfcmVnaW9uX2FjcXVpcmVfbGFuZSgpIGluIHRoZQ0KPiBm
b2xsb3dpbmcgc2l0dWF0aW9uLg0KPiA+IFdpbGwgdGhlcmUgYmUgYSBkZWFkIGxvY2s/DQo+ID4N
Cj4gPg0KPiA+ICAgICBUaHJlYWQgQSAgICAgICAgICAgICAgICAgICAgVGhyZWFkIEINCj4gPiAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgIENQVSAxICAgICAgICAgICAgICAgICAgICAg
ICBDUFUgMg0KPiA+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICBnZXQgbG9jayBmb3IgTGFu
ZSAxICAgICAgICAgZ2V0IGxvY2sgZm9yIExhbmUgMg0KPiA+ICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAg
fA0KPiA+ICBtaWdyYXRlIHRvIENQVSAyICAgICAgICAgICAgbWlncmF0ZSB0byBDUFUgMQ0KPiA+
ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICB3YWl0IGxvY2sgZm9yIExhbmUgMiAgICAgICAg
d2FpdCBsb2NrIGZvciBMYW5lIDENCj4gPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwNCj4gPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAg
ICAgX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiAgICAgICAgICAgICAgICAgICAg
fA0KPiA+ICAgICAgICAgICAgICAgICBkZWFkIGxvY2sgPw0KPiANCj4gQnVtbWVyLiBUaGF0IHdv
dWxkIGRlYWQgbG9jayBpbmRlZWQuDQo+IElzIGl0IGVhc2lseSBwb3NzaWJsZSB0byByZWNvZ25p
emUgdGhlIHJlY3Vyc2l2ZSBjYXNlPw0KDQpOb3QgZWFzaWx5LiBJIGRvbid0IGhhdmUgdGVzdCBj
YXNlIGZvciByZWN1cnNpdmUgY2FsbC4gDQpGb3Igbm93LCBqdXN0IGNvZGUgYW5hbHlzaXMuDQoN
Cg0KWW9uZ3hpbg0KDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gWW9nbnhpbg0KPiANCj4gU2ViYXN0
aWFuDQo=
