Return-Path: <SRS0=9F+M=AV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52640C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jul 2020 11:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283902076A
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jul 2020 11:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="dIRSgc0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGJLIH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:08:07 -0400
Received: from ns.omicron.at ([212.183.10.25]:36018 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgGJLIE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jul 2020 07:08:04 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2020 07:08:02 EDT
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 06AAx7hf006095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 12:59:07 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 06AAx7hf006095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1594378747;
        bh=DULiteVTG8G+8WtjLkgErdGSK2rKCnDlh/dEAv57M2o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dIRSgc0AeINgTGVwNYUSW1To8K5aV1eXAOajvetvqvsyuMb6zMhwV5/RVKKCZ/ERt
         hrTajyz+//ZuETG8NZ4si7ZOCovH/mi7GT8SfIqsPr+CMNT/lv8OrsBK0IancRT4hp
         xjAfpbHO+wNvF/dDRnoc4uYmaM72WD8r1/Jglx+Q=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id 2E0FEA0072;
        Fri, 10 Jul 2020 12:59:07 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id 27070A006D;
        Fri, 10 Jul 2020 12:59:07 +0200 (CEST)
Received: from EXC03-ATKLA.omicron.at ([172.22.100.188])
        by MGW01-ATKLA.omicron.at  with ESMTP id 06AAx7sm008681-06AAx7so008681
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL);
        Fri, 10 Jul 2020 12:59:07 +0200
Received: from EXC03-ATKLA.omicron.at (172.22.100.188) by
 EXC03-ATKLA.omicron.at (172.22.100.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 10 Jul 2020 12:59:00 +0200
Received: from EXC03-ATKLA.omicron.at ([fe80::1c82:5ed6:8fbc:82bc]) by
 EXC03-ATKLA.omicron.at ([fe80::1c82:5ed6:8fbc:82bc%5]) with mapi id
 15.01.1979.003; Fri, 10 Jul 2020 12:59:00 +0200
From:   Thomas Graziadei <thomas.graziadei@omicronenergy.com>
To:     "'Sebastian Andrzej Siewior'" <bigeasy@linutronix.de>,
        Mark Marshall <markmarshall14@gmail.com>
CC:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
Thread-Topic: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
Thread-Index: AQHWIfgHQa/IakhQQkCZJl1nz3sGM6i/EM8AgAAoLICAAAo9AIAABisAgDu8JACABgVxQA==
Date:   Fri, 10 Jul 2020 10:59:00 +0000
Message-ID: <eeeae7d9-c028-47f0-ab5b-7983e32f36cb@EXC03-ATKLA.omicron.at>
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
 <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
 <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
 <20200529161518.svpxhkeljafbtdz2@linutronix.de>
 <20200529163722.mdxzrj4n3lyzjtfu@linutronix.de>
 <20200706165004.7m57fvspmwnjcjxh@linutronix.de>
In-Reply-To: <20200706165004.7m57fvspmwnjcjxh@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.95.180]
Content-Type: multipart/mixed;
        boundary="_002_eeeae7d9c02847f0ab5b7983e32f36cbEXC03ATKLAomicronat_"
MIME-Version: 1.0
X-FE-Attachment-Name: check.patch
X-FE-Policy-ID: 1:1:1:SYSTEM
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--_002_eeeae7d9c02847f0ab5b7983e32f36cbEXC03ATKLAomicronat_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgU2ViYXN0aWFuLA0KDQp0aGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGlzLg0KDQpXZSBjb3Vs
ZCByZXByb2R1Y2UgdGhlIGlzc3VlIHdpdGggUUVNVS4NCkF0IHJ1bnRpbWUgeW91IG5lZWQgdG8g
c2V0IG1kZXYgYXMgdGhlIGtlcm5lbCdzIGhvdHBsdWcgY2xpZW50ICgvcHJvYy9zeXMva2VybmVs
L2hvdHBsdWcpIGFuZCBnaXZlIGl0IGEgZHVtbXkgL2V0Yy9tZGV2LmNvbmYgbGlrZSAoLiogMTox
IDc3NykuIFRoZW4ganVzdCBkbyBhIGxvb3AgYW5kIGluc21vZC9ybW1vZCBjcmM0LmtvIGFuZCBj
cmM3LmtvLg0KDQpTd2FwcGluZyB0aGUgbW0gYXNzaWdubWVudCBkaWQgbm90IHdvcmsgLT4gZXhj
ZXB0aW9uIGFmdGVyIDE5MDAgaXRlcmF0aW9ucw0KWW91ciBzZWNvbmQgc3VnZ2VzdGlvbiB3aXRo
IGNoZWNrLnBhdGNoIChhdHRhY2hlZCB0byB0aGlzIGVtYWlsIGZvciBjb21wbGV0ZW5lc3MsIG9u
bHkgcHJvdGVjdGluZyB0aGUgZXhlY19tbWFwIGZ1bmN0aW9uKSBkaWQgbm90IHdvcmsgZWlnaHRl
ciAtPiBleGNlcHRpb24gYWZ0ZXIgMjYwMCBpdGVyYXRpb25zDQoNCllvdXIgdGhpcmQgc3VnZ2Vz
dGlvbiAoYSBtb2RpZmljYXRpb24gdG8gdGhlIG9yaWdpbmFsIHJldmVydCkgZW5jbG9zZWQgaW4g
dGhpcyBlLW1haWwgZG9lcyBzZWVtIHRvIHdvcmsuIFN0aWxsIG5vIHByb2JsZW1zIGFmdGVyIDMw
MDAwIGl0ZXJhdGlvbnMuDQoNCkJ5IHRoZSB3YXksIGFzIG5vdGljZWQgaW4geW91ciBrZXJuZWwg
Y29uZmlnLCB3ZSB3b3VsZCBiZSBxdWl0ZSBpbnRlcmVzdGVkIGluIGEgZ2NjIDkgY29tcGlsZXIg
Zm9yIG91ciBwbGF0Zm9ybS4gSXMgdGhlcmUgYSBtYWlubGluZS9tYWludGFpbmVkIHZlcnNpb24g
b3IgZm9yayBmb3IgdGhpcyBvciBhbm90aGVyIHBvc3NpYmlsaXR5IHRvIGdldCBpdD8NCiANClJl
Z2FyZHMsDQpUaG9tYXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNlYmFz
dGlhbiBBbmRyemVqIFNpZXdpb3IgW21haWx0bzpiaWdlYXN5QGxpbnV0cm9uaXguZGVdIA0KU2Vu
dDogTW9uZGF5LCBKdWx5IDA2LCAyMDIwIDY6NTAgUE0NClRvOiBNYXJrIE1hcnNoYWxsIDxtYXJr
bWFyc2hhbGwxNEBnbWFpbC5jb20+DQpDYzogbGludXgtcnQtdXNlcnMgPGxpbnV4LXJ0LXVzZXJz
QHZnZXIua2VybmVsLm9yZz47IE1hcmsgTWFyc2hhbGwgPG1hcmsubWFyc2hhbGxAb21pY3JvbmVu
ZXJneS5jb20+OyBUaG9tYXMgR3JhemlhZGVpIDx0aG9tYXMuZ3JhemlhZGVpQG9taWNyb25lbmVy
Z3kuY29tPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyByb3N0ZWR0QGdvb2RtaXMub3JnDQpTdWJqZWN0OiBSZTogS2Vy
bmVsIGNyYXNoIGR1ZSB0byBtZW1vcnkgY29ycnVwdGlvbiB3aXRoIHY1LjQuMjYtcnQxNyBhbmQg
UG93ZXJQQyBlNTAwDQoNCk9uIDIwMjAtMDUtMjkgMTg6Mzc6MjIgWyswMjAwXSwgVG8gTWFyayBN
YXJzaGFsbCB3cm90ZToNCj4gT24gMjAyMC0wNS0yOSAxODoxNToxOCBbKzAyMDBdLCBUbyBNYXJr
IE1hcnNoYWxsIHdyb3RlOg0KPiA+IEluIG9yZGVyIHRvIGdldCBpdCBiYWNrIGludG8gdGhlIFJU
IHF1ZXVlIEkgbmVlZCB0byB1bmRlcnN0YW5kIHdoeSANCj4gPiBpdCBpcyByZXF1aXJlZC4gV2hh
dCBleGFjdGx5IGlzIGl0IGZpeGluZy4gTGV0IG1lIHN0YXJlIGF0IGZvciBhIA0KPiA+IGxpdHRs
ZeKApg0KPiANCj4gaXQgdXNlZCB0byBiZSBsb2NhbF9pcnFfZGlzYWJsZSgpIHdoaWNoIHRoZW4g
YmVjYW1lIHByZWVtcHRfZGlzYWJsZSgpDQo+IGxvY2FsX2lycV9kaXNhYmxlKCkgZHVlIHRvIEFS
TSdzIGxpbWl0YXRpb24uDQoNCkFueSBsdWNrIG9uIHlvdXIgc2lkZT8NCg0KSSAqdGhpbmsqIGlm
IHlvdSBzd2FwIHRoZSBtbSBhc3NpZ25tZW50IGluIGV4ZWNfbW1hcCgpIHRoZW4gaXQgc2hvdWxk
IGJlIGdvbmUuIEJhc2ljYWxseToNCnwgICAgICAgICB0c2stPmFjdGl2ZV9tbSA9IG1tOw0KfCAg
ICAgICAgIHRzay0+bW0gPSBtbTsNCg0KSG93ZXZlciBJIHRoaW5rIHRvIGFwcGx5IHNvbWV0aGlu
ZyBsaWtlIHRoaXM6DQoNCmRpZmYgLS1naXQgYS9mcy9leGVjLmMgYi9mcy9leGVjLmMNCi0tLSBh
L2ZzL2V4ZWMuYw0KKysrIGIvZnMvZXhlYy5jDQpAQCAtMTAzNSwxMSArMTAzNSwxNSBAQCBzdGF0
aWMgaW50IGV4ZWNfbW1hcChzdHJ1Y3QgbW1fc3RydWN0ICptbSkNCiAJCX0NCiAJfQ0KIAl0YXNr
X2xvY2sodHNrKTsNCisNCisJdGFza19sb2NrX21tKCk7DQogCWFjdGl2ZV9tbSA9IHRzay0+YWN0
aXZlX21tOw0KIAltZW1iYXJyaWVyX2V4ZWNfbW1hcChtbSk7DQogCXRzay0+bW0gPSBtbTsNCiAJ
dHNrLT5hY3RpdmVfbW0gPSBtbTsNCiAJYWN0aXZhdGVfbW0oYWN0aXZlX21tLCBtbSk7DQorCXRh
c2tfdW5sb2NrX21tKCk7DQorDQogCXRzay0+bW0tPnZtYWNhY2hlX3NlcW51bSA9IDA7DQogCXZt
YWNhY2hlX2ZsdXNoKHRzayk7DQogCXRhc2tfdW5sb2NrKHRzayk7DQpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9zY2hlZC90YXNrLmggYi9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaA0KLS0t
IGEvaW5jbHVkZS9saW51eC9zY2hlZC90YXNrLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc2NoZWQv
dGFzay5oDQpAQCAtMTc2LDQgKzE3NiwzMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdGFza191bmxv
Y2soc3RydWN0IHRhc2tfc3RydWN0ICpwKQ0KIAlzcGluX3VubG9jaygmcC0+YWxsb2NfbG9jayk7
DQogfQ0KIA0KKyNpZmRlZiBDT05GSUdfUFJFRU1QVF9SVA0KKy8qDQorICogUHJvdGVjdHMgLT5t
bSBhbmQgLT5hY3RpdmVfbW0uDQorICogQXZvaWRzIHNjaGVkdWxpbmcgc28gc3dpdGNoX21tKCkg
b3IgZW50ZXJfbGF6eV90bGIoKSB3aWxsIG5vdCByZWFkIA0KK3RoZQ0KKyAqIG1lbWJlcnMgd2hp
bGUgdGhleSBhcmUgdXBkYXRlZC4NCisgKi8NCitzdGF0aWMgaW5saW5lIHZvaWQgdGFza19sb2Nr
X21tKHZvaWQpDQorew0KKwlwcmVlbXB0X2Rpc2FibGUoKTsNCit9DQorDQorc3RhdGljIGlubGlu
ZSB2b2lkIHRhc2tfdW5sb2NrX21tKHZvaWQpIHsNCisJcHJlZW1wdF9lbmFibGUoKTsNCit9DQor
DQorI2Vsc2UNCisNCitzdGF0aWMgaW5saW5lIHZvaWQgdGFza19sb2NrX21tKHZvaWQpDQorew0K
K30NCisNCitzdGF0aWMgaW5saW5lIHZvaWQgdGFza191bmxvY2tfbW0odm9pZCkgeyB9ICNlbmRp
Zg0KKw0KICNlbmRpZiAvKiBfTElOVVhfU0NIRURfVEFTS19IICovDQpkaWZmIC0tZ2l0IGEvbW0v
bW11X2NvbnRleHQuYyBiL21tL21tdV9jb250ZXh0LmMNCi0tLSBhL21tL21tdV9jb250ZXh0LmMN
CisrKyBiL21tL21tdV9jb250ZXh0LmMNCkBAIC0yNSw2ICsyNSw3IEBAIHZvaWQgdXNlX21tKHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KIAlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzayA9IGN1cnJlbnQ7
DQogDQogCXRhc2tfbG9jayh0c2spOw0KKwl0YXNrX2xvY2tfbW0oKTsNCiAJYWN0aXZlX21tID0g
dHNrLT5hY3RpdmVfbW07DQogCWlmIChhY3RpdmVfbW0gIT0gbW0pIHsNCiAJCW1tZ3JhYihtbSk7
DQpAQCAtMzIsNiArMzMsNyBAQCB2b2lkIHVzZV9tbShzdHJ1Y3QgbW1fc3RydWN0ICptbSkNCiAJ
fQ0KIAl0c2stPm1tID0gbW07DQogCXN3aXRjaF9tbShhY3RpdmVfbW0sIG1tLCB0c2spOw0KKwl0
YXNrX3VubG9ja19tbSgpOw0KIAl0YXNrX3VubG9jayh0c2spOw0KICNpZmRlZiBmaW5pc2hfYXJj
aF9wb3N0X2xvY2tfc3dpdGNoDQogCWZpbmlzaF9hcmNoX3Bvc3RfbG9ja19zd2l0Y2goKTsNCkBA
IC01NSwxMCArNTcsMTIgQEAgdm9pZCB1bnVzZV9tbShzdHJ1Y3QgbW1fc3RydWN0ICptbSkNCiAJ
c3RydWN0IHRhc2tfc3RydWN0ICp0c2sgPSBjdXJyZW50Ow0KIA0KIAl0YXNrX2xvY2sodHNrKTsN
CisJdGFza19sb2NrX21tKCk7DQogCXN5bmNfbW1fcnNzKG1tKTsNCiAJdHNrLT5tbSA9IE5VTEw7
DQogCS8qIGFjdGl2ZV9tbSBpcyBzdGlsbCAnbW0nICovDQogCWVudGVyX2xhenlfdGxiKG1tLCB0
c2spOw0KKwl0YXNrX3VubG9ja19tbSgpOw0KIAl0YXNrX3VubG9jayh0c2spOw0KIH0NCiBFWFBP
UlRfU1lNQk9MX0dQTCh1bnVzZV9tbSk7DQotLQ0KMi4yNy4wDQoNCj4gPiA+IEJlc3QgcmVnYXJk
cywNCj4gPiA+IE1hcmsNCg0KU2ViYXN0aWFuDQo=

--_002_eeeae7d9c02847f0ab5b7983e32f36cbEXC03ATKLAomicronat_
Content-Type: application/octet-stream; name="check.patch"
Content-Description: check.patch
Content-Disposition: attachment; filename="check.patch"; size=437;
	creation-date="Fri, 10 Jul 2020 10:47:44 GMT";
	modification-date="Mon, 08 Jun 2020 18:04:36 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2V4ZWMuYyBiL2ZzL2V4ZWMuYw0KaW5kZXggNzc2MDNjZWVkNTFmOS4u
MTMxMGZiNGQ1ZjBkNCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZWMuYw0KKysrIGIvZnMvZXhlYy5jDQpA
QCAtMTAzNyw4ICsxMDM3LDEyIEBAIHN0YXRpYyBpbnQgZXhlY19tbWFwKHN0cnVjdCBtbV9zdHJ1
Y3QgKm1tKQ0KIAl0YXNrX2xvY2sodHNrKTsNCiAJYWN0aXZlX21tID0gdHNrLT5hY3RpdmVfbW07
DQogCW1lbWJhcnJpZXJfZXhlY19tbWFwKG1tKTsNCisNCisJcHJlZW1wdF9kaXNhYmxlKCk7DQog
CXRzay0+bW0gPSBtbTsNCiAJdHNrLT5hY3RpdmVfbW0gPSBtbTsNCisJcHJlZW1wdF9lbmFibGUo
KTsNCisNCiAJYWN0aXZhdGVfbW0oYWN0aXZlX21tLCBtbSk7DQogCXRzay0+bW0tPnZtYWNhY2hl
X3NlcW51bSA9IDA7DQogCXZtYWNhY2hlX2ZsdXNoKHRzayk7DQo=

--_002_eeeae7d9c02847f0ab5b7983e32f36cbEXC03ATKLAomicronat_--
