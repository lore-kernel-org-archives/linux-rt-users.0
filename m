Return-Path: <SRS0=GyRq=5E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D817C4332D
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463D320782
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="NRI7ALR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCSO5o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:57:44 -0400
Received: from ns.omicron.at ([212.183.10.25]:51274 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgCSO5o (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Mar 2020 10:57:44 -0400
X-Greylist: delayed 751 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 10:57:43 EDT
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 02JEjAxM014683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 15:45:10 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 02JEjAxM014683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1584629110;
        bh=Z0xImGUqUPyOsNfsdDjs9a2xI4J8OEnVnOO6mlpwpCU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NRI7ALR0E9zB9/dAt+1bHuh/ci8UGNMVsCrDelzHDHlnYNggoiSzc3nBLEjgzJYvf
         b0Ye+FjJkyOAbOFOYRU5BEmpTLHEuqb3t8PRDlui60+2oeLO42zbcOPOd9IrB1+bKC
         lzV3db8AiQQ4kHG950NWO+ElHfsGyN/YFYlfTkY4=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id 7C3C8A01EF;
        Thu, 19 Mar 2020 15:45:10 +0100 (CET)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id 77ECDA01ED;
        Thu, 19 Mar 2020 15:45:10 +0100 (CET)
Received: from EXC04-ATKLA.omicron.at ([172.22.100.189])
        by MGW01-ATKLA.omicron.at  with ESMTP id 02JEjAST007633-02JEjASV007633
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL);
        Thu, 19 Mar 2020 15:45:10 +0100
Received: from EXC03-ATKLA.omicron.at (172.22.100.188) by
 EXC04-ATKLA.omicron.at (172.22.100.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Mar 2020 15:45:09 +0100
Received: from EXC03-ATKLA.omicron.at ([fe80::1c82:5ed6:8fbc:82bc]) by
 EXC03-ATKLA.omicron.at ([fe80::1c82:5ed6:8fbc:82bc%5]) with mapi id
 15.01.1713.004; Thu, 19 Mar 2020 15:45:09 +0100
From:   Thomas Graziadei <thomas.graziadei@omicronenergy.com>
To:     "'Sebastian Andrzej Siewior'" <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] powerpc: Fix lazy preemption for powerpc 32bit
Thread-Topic: [PATCH] powerpc: Fix lazy preemption for powerpc 32bit
Thread-Index: AQHV/WVyTn4Lvv+Gzk2MsIjQn8mCsKhP6MAAgAAUoAA=
Date:   Thu, 19 Mar 2020 14:45:09 +0000
Message-ID: <95ef76b973f947fea9044b685e835de2@omicronenergy.com>
References: <0c91d808-b077-408c-b120-99e806efaeb5@EXC03-ATKLA.omicron.at>
 <20200319142452.dqmkuruts3i6wjyt@linutronix.de>
In-Reply-To: <20200319142452.dqmkuruts3i6wjyt@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.95.180]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

PiBGcm9tOiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yIFttYWlsdG86YmlnZWFzeUBsaW51dHJv
bml4LmRlXSANCj4gT24gMjAyMC0wMy0xOCAyMToyNjo0MCBbKzAxMDBdLCBUaG9tYXMgR3Jhemlh
ZGVpIHdyb3RlOg0KPj4gRnJvbTogVGhvbWFzIEdyYXppYWRlaSA8dGhvbWFzLmdyYXppYWRlaUBv
bWljcm9uZW5lcmd5LmNvbT4NCj4+IA0KPj4gVGhlIDMyYml0IHBvd2VycGMgYXNzZW1ibGVyIGlt
cGxlbWVudGF0aW9uIG9mIHRoZSBsYXp5IHByZWVtcHRpb24gc2V0IA0KPj4gdGhlIF9USUZfUEVS
U1lTQ0FMTF9NQVNLIG9uIHRoZSBsb3cgd29yZC4gVGhpcyBjb3VsZCBsZWFkIHRvIG1vZHByb2Jl
IA0KPj4gc2VnZmF1bHRzIGFuZCBhIGtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBdHRlbXB0
IHRvIGtpbGwgaW5pdCEgDQo+PiBpc3N1ZS4NCj4+IA0KPj4gRml4ZWQgYnkgc2hpZnRpbmcgdGhl
IG1hc2sgYnkgMTYgYml0IHVzaW5nIGFuZGlzIGFuZCBsaXMuDQo+DQo+IGJhaC4gVGhhbmsgeW91
IGZvciBjYXRjaGluZyB0aGlzLg0KPiBTdGlsbCBlNTAwIGJhc2VkIHBvd2VycGMgSSBhc3N1bWU/
DQoNCldlbGwgdGhhbmtzIGZvciB0aGUgZ3JlYXQgd29yayBhbmQgeWVzIHN0aWxsIGU1MDAgcG93
ZXJwYyBiYXNlZC4NCg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdyYXppYWRlaSA8dGhv
bWFzLmdyYXppYWRlaUBvbWljcm9uZW5lcmd5LmNvbT4NCj4NCj4gU2ViYXN0aWFuDQoNClRob21h
cw0K
