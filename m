Return-Path: <SRS0=xoO4=RO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C20C43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Mar 2019 00:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E566D20652
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Mar 2019 00:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfCKApu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 10 Mar 2019 20:45:50 -0400
Received: from mail.windriver.com ([147.11.1.11]:44571 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfCKApt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 10 Mar 2019 20:45:49 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x2B0j0ib009225
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 10 Mar 2019 17:45:00 -0700 (PDT)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.68]) by
 ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0439.000; Sun,
 10 Mar 2019 17:44:59 -0700
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
Thread-Index: AQHU1AQaa42orSwEx0mmBzBs0WZNkaYAw5wAgAAVVLCAAStcgIADmlcQ
Date:   Mon, 11 Mar 2019 00:44:58 +0000
Message-ID: <597B109EC20B76429F71A8A97770610D12A5643B@ALA-MBD.corp.ad.wrs.com>
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
 <20190307143344.ytsnbmot5tjzjhip@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A52669@ALA-MBD.corp.ad.wrs.com>
 <20190308094131.ge4wbsvz4p6xikdf@linutronix.de>
In-Reply-To: <20190308094131.ge4wbsvz4p6xikdf@linutronix.de>
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
RnJpZGF5LCBNYXJjaCA4LCAyMDE5IDE3OjQyDQo+IFRvOiBMaXUsIFlvbmd4aW4NCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJ0LXVzZXJzQHZnZXIua2VybmVsLm9y
ZzsNCj4gdGdseEBsaW51dHJvbml4LmRlOyByb3N0ZWR0QGdvb2RtaXMub3JnOyBkYW4uai53aWxs
aWFtc0BpbnRlbC5jb207DQo+IHBhZ3VwdGFAcmVkaGF0LmNvbTsgR29ydG1ha2VyLCBQYXVsOyBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUlRdIG52ZGlt
bTogbWFrZSBsYW5lIGFjcXVpcmVtZW50IFJUIGF3YXJlDQo+IA0KPiBPbiAyMDE5LTAzLTA4IDAw
OjA3OjQxIFsrMDAwMF0sIExpdSwgWW9uZ3hpbiB3cm90ZToNCj4gPiBUaGUgbGFuZSBpcyBjcml0
aWNhbCByZXNvdXJjZSB3aGljaCBuZWVkcyB0byBiZSBwcm90ZWN0ZWQuIE9uZSBDUFUgY2FuDQo+
IHVzZSBvbmx5IG9uZQ0KPiA+IGxhbmUuIElmIENQVSBudW1iZXIgaXMgZ3JlYXRlciB0aGFuIHRo
ZSBudW1iZXIgb2YgdG90YWwgbGFuZSwgdGhlIGxhbmUNCj4gY2FuIGJlIHNoYXJlZA0KPiA+IGFt
b25nIENQVXMuDQo+ID4NCj4gPiBJbiBub24tUlQga2VybmVsLCBnZXRfY3B1KCkgZGlzYWJsZSBw
cmVlbXB0aW9uIGJ5IGNhbGxpbmcNCj4gcHJlZW1wdF9kaXNhYmxlKCkgZmlyc3QuDQo+ID4gT25s
eSBvbmUgdGhyZWFkIG9uIHRoZSBzYW1lIENQVSBjYW4gZ2V0IHRoZSBsYW5lLg0KPiA+DQo+ID4g
SW4gUlQga2VybmVsLCBpZiB3ZSBvbmx5IHVzZSByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpLCB0aGlz
IGRvZXNuJ3QNCj4gcHJvdGVjdCB0aGUgbGFuZS4NCj4gPiBUaHVzIHR3byB0aHJlYWRzIG9uIHRo
ZSBzYW1lIENQVSBjYW4gZ2V0IHRoZSBzYW1lIGxhbmUgYXQgdGhlIHNhbWUgdGltZS4NCj4gPg0K
PiA+IEluIHRoaXMgcGF0Y2gsIHR3by1sZXZlbCBsb2NrIGNhbiBhdm9pZCByYWNlIGNvbmRpdGlv
biBmb3IgdGhlIGxhbmUuDQo+IA0KPiBidXQgeW91IHN0aWxsIGhhdmUgdGhlIG5kbF9sb2NrLT5s
b2NrIHdoaWNoIHByb3RlY3RzIHRoZSByZXNvdXJjZS4gU28gaW4NCj4gdGhlIHVubGlrZWx5IChi
dXQgcG9zc2libGUgZXZlbnQpIHRoYXQgeW91IHN3aXRjaCBDUFVzIGFmdGVyIG9idGFpbmluZw0K
PiB0aGUgQ1BVIG51bWJlciB5b3UgYmxvY2sgb24gdGhlIGxvY2suIE5vIGhhcm0gaXMgZG9uZSwg
cmlnaHQ/DQoNClRoZSByZXNvdXJjZSAibGFuZSIgY2FuIGJlIGFjcXVpcmVkIHJlY3Vyc2l2ZWx5
LCBzbyAibmRsX2xvY2stPmxvY2siIGlzIGEgY29uZGl0aW9uYWwgbG9jay4NCg0KbmRsX2NvdW50
LT5jb3VudCBpcyBwZXIgQ1BVLg0KbmRsX2xvY2stPmxvY2sgaXMgcGVyIGxhbmUuDQoNCkhlcmUg
aXMgYW4gZXhhbXBsZToNClRocmVhZCBBICBvbiBDUFUgNSAtLT4gbmRfcmVnaW9uX2FjcXVpcmVf
bGFuZSAtLT4gbGFuZSMgNSAtLT4gZ2V0ICJuZGxfbG9jay0+bG9jayINCi0tPiBuZF9yZWdpb25f
YWNxdWlyZV9sYW5lIC0tPiBsYW5lIyA1IC0tPiBieXBhc3MgIm5kbF9sb2NrLT5sb2NrIiBkdWUg
dG8gIm5kbF9jb3VudC0+Y291bnQrKyIuDQoNClRocmVhZCBCIG9uIENQVSA1IC0tPiBuZF9yZWdp
b25fYWNxdWlyZV9sYW5lIC0tPiBsYW5lIyA1IC0tPiBieXBhc3MgIm5kbF9sb2NrLT5sb2NrIiAo
Im5kbF9jb3VudC0+Y291bnQiDQp3YXMgY2hhbmdlZCBieSBUaHJlYWQgQSkNCg0KSWYgd2UgdXNl
IHJhd19zbXBfcHJvY2Vzc29yX2lkKCksIG5vIG1hdHRlciB3aGljaCBDUFUgdGhlIHRocmVhZCB3
YXMgbWlncmF0ZWQgdG8sIA0KaWYgdGhlcmUgaXMgYW5vdGhlciB0aHJlYWQgcnVubmluZyBvbiB0
aGUgb2xkIENQVSwgdGhlcmUgd2lsbCBiZSByYWNlIGNvbmRpdGlvbiANCmR1ZSB0byBwZXIgQ1BV
IHZhcmlhYmxlICJuZGxfY291bnQtPmNvdW50Ii4NCg0KDQpUaGFua3MsDQpZb25neGluDQoNCj4g
DQo+IFNlYmFzdGlhbg0K
