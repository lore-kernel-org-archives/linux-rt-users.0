Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E285C433ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 20:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E89861879
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 20:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhEKUPm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 May 2021 16:15:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKUPm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 May 2021 16:15:42 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620764074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylIu6xlXUVLmgWdaKXp1kD6P8eexx5uijtWA+I03Rt8=;
        b=HIbAcLzFZQ5hOpDTUnMnb8d1RbKNDCajHBOulh9Z+6GW9J9Q1UgU9Iq8nIiabx8mHMYR+x
        PCdtEErU8rBuVF+z54BJy6NmXm013fhT6T9cMZ+QqzV4Jta5EQrP9HMGuU8oB8xwrVf8M7
        vp2VFhmH7CUIEZLdW0DAu62VEOKNgggBCnWOdbRiFwBXw3vMZrnLKP+TSmXZnVZkIcSvXZ
        3KM5I18GPxlUPGJKOJMN7UDXIT4DHFhkl8a17JnlWYxJEkntLffr4f+qpwjWh2NEaktR+A
        wd2fIVVWRwTWjyrzX79SaU672mYQ4COj/UjyfuBDVZ1+Bhz6htDxnHGJ37DeEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620764074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylIu6xlXUVLmgWdaKXp1kD6P8eexx5uijtWA+I03Rt8=;
        b=mRudHyzoLnjJ6wEEEmh6iw8VomvC6n1Ps3KrnfeIreaDNV4pgH45ASmZbaM7X6cFdBnGzE
        qHC/KKgnks5bbrDg==
To:     Angelo Dureghello <angelo@kernel-space.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: big rt latencies compared to non rt
In-Reply-To: <736a53fb-d80e-3faa-1a66-d40538e0fe26@kernel-space.org>
References: <736a53fb-d80e-3faa-1a66-d40538e0fe26@kernel-space.org>
Date:   Tue, 11 May 2021 22:14:34 +0200
Message-ID: <87im3p6n9x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiAyMDIxLTA1LTExLCBBbmdlbG8gRHVyZWdoZWxsbyA8YW5nZWxvQGtl
cm5lbC1zcGFjZS5vcmc+IHdyb3RlOg0KPiBjeWNsaWN0ZXN0IC0tZHVyYXRpb249MTgwIC10PTEg
LW0gLVNwOTkgXA0KPiAgwqDCoMKgIMKgwqDCoCAtaTIwMDAgLWgzMDAwIC1xID4gaGlzdG9ncmFt
DQo+DQo+IEF2ZXJhZ2UgaXMgbmVhciAxNnVTIGJ1dCB0aGVyZSBhcmUgc29tZSBvdXRzaWRlDQo+
IHZhbHVlcyBuZWFyIDQwMDAwLCBhcw0KDQpUaGUgZmlyc3QgY29sdW1uIGlzIHRoZSBsYXRlbmN5
IGluIG1pY3Jvc2Vjb25kcy4gVGhlIG90aGVyIGNvbHVtbnMNCigybmQtNXRoKSBpcyB0aGUgY291
bnQgb2YgdGltZXMgdGhhdCBsYXRlbmN5IHdhcyBzZWVuIGZvciBhIENQVS4NCg0KPiAwMDAwMDkg
MDAwMDAwwqDCoMKgIDAwMDAwMMKgwqDCoCAwMDAwMDDCoMKgwqAgMDAwMDAwDQo+IDAwMDAxMCAw
MDAwMDHCoMKgwqAgMDAwMDAwwqDCoMKgIDAwMDAwMsKgwqDCoCAwMDAwMDANCj4gMDAwMDExIDAw
MDAwMsKgwqDCoCAwMDAwMDDCoMKgwqAgMDAwMDAwwqDCoMKgIDAwMDAwMA0KPiAwMDAwMTIgMDAw
MDIzwqDCoMKgIDAwMDAwNsKgwqDCoCAwMDAwMDjCoMKgwqAgMDAwMDA0DQo+IDAwMDAxMyAwMDE1
NjXCoMKgwqAgMDAxNTA0wqDCoMKgIDAwMjAxMMKgwqDCoCAwMDEzNjcNCj4gMDAwMDE0IDAwMDQy
NcKgwqDCoCAwMDE5NTnCoMKgwqAgMDAwNjQ5wqDCoMKgIDAwMDcwMA0KPiAwMDAwMTUgMDAxNDQ3
wqDCoMKgIDAwMTkxN8KgwqDCoCAwMDExMjnCoMKgwqAgMDAxNDE1DQo+IDAwMDAxNiAwMzQwODTC
oMKgwqAgMDI2MTE4wqDCoMKgIDA0MDMyOMKgwqDCoCAwMzIzMzQNCj4gMDAwMDE3IDA0MDUzN8Kg
wqDCoCAwMTUwMDDCoMKgwqAgMDMzNzczwqDCoMKgIDA0MTA5MsKgIDwtLS0tLQ0KDQpDUFUzIHNh
dyBhIGxhdGVuY3kgb2YgMTd1cyA0MTA5MiB0aW1lcy4NCg0KSm9obiBPZ25lc3MNCg==
