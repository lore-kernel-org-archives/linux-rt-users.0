Return-Path: <SRS0=p5Ea=VV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F9FC76186
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Jul 2019 17:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AEA21873
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Jul 2019 17:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfGXRHg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:07:36 -0400
Received: from out59-ams.mf.surf.net ([145.0.1.59]:58152 "EHLO
        out59-ams.mf.surf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfGXRHf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Jul 2019 13:07:35 -0400
Received: from out41-ams.mf.surf.net (out41-ams.mf.surf.net [145.0.1.41])
        by fbout2-ams.mf.surf.net (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id x6OH74oM060167
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2019 19:07:04 +0200
Received: from smtp-prd1.ic.uva.nl (smtp-prd1.ic.uva.nl [146.50.108.156])
        by outgoing2-ams.mf.surf.net (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id x6OH7R2T007298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2019 19:07:27 +0200
Received: from [145.109.126.138] (wcw-self-145-109-126-138.wireless.uva.nl [145.109.126.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-prd1.ic.uva.nl (Postfix) with ESMTPSA id 1272D3D
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2019 19:07:31 +0200 (CEST)
Subject: Re: Boot issue on odroid-XU4
From:   Benjamin Rouxel <benjamin.rouxel@uva.nl>
To:     linux-rt-users@vger.kernel.org
References: <cfa2b805-380d-39fd-2955-ab19c5a11aaa@uva.nl>
Message-ID: <d6033713-25b7-7ef0-b0ad-8b7100d7d4b0@uva.nl>
Date:   Wed, 24 Jul 2019 19:07:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cfa2b805-380d-39fd-2955-ab19c5a11aaa@uva.nl>
Content-Type: multipart/mixed;
 boundary="------------AB364D24CC57C7A2DA32AE97"
Content-Language: en-GB
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: MIMEDefang 2.84 on 146.50.108.156
X-Bayes-Prob: 0.0001 (Score 0, tokens from: uva-out:default, uva:default, base:default, @@RPTN)
X-CanIt-Geo: ip=146.50.108.156; country=NL; region=North Holland; city=Amsterdam; latitude=52.3534; longitude=4.9087; http://maps.google.com/maps?q=52.3534,4.9087&z=6
X-CanItPRO-Stream: uva-out:default (inherits from uva:default,base:default)
X-Canit-Stats-ID: 0v0EF7rt6 - 8e96ae67ffc4 - 20190724 (trained as not-spam)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------AB364D24CC57C7A2DA32AE97
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

I thought it would be harder to debug/fix. Please find attached a patch
that corrects this boot issue, the exynos5 i2c driver was still using
the "spinlock_t" structure and all initial utility functions, I just
changed it to use the "raw_spinlock_t" struct.

Was it the good fix?

Best,

Benjamin Rouxel.

Le 24/07/2019 à 18:17, Benjamin Rouxel a écrit :
> Hi,
>
> platform: odroid-xu4
>
> kernel: 4.14.134 + hardkernel drivers
>
> rt patch: patch-4.14.134-rt63
>
> preempt rt: full
>
> I am having issues at boot time for the aforementioned
> platform+kernel+rt patch. Adding "initcall_debug" to the kernel
> parameter made me realise that the call to "exynos5_i2c_driver_init"
> never returns, so I believe it is lock somehow. I am requesting some
> help to debug and fix it please. Attached is the bootlog. What else
> should I provide?
>
> Best,
>
> Benjamin Rouxel.
>

--------------AB364D24CC57C7A2DA32AE97
Content-Type: text/plain; charset=UTF-8;
 name="patch-xu4-preempt-rt-full.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch-xu4-preempt-rt-full.txt"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZXh5bm9zNS5jIGIvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1leHlub3M1LmMKaW5kZXggYjAyNDI4NDk4ZjZkLi45YTJhMzJm
NDJjNTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZXh5bm9zNS5jCisr
KyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtZXh5bm9zNS5jCkBAIC0xODksNyArMTg5LDcg
QEAgc3RydWN0IGV4eW5vczVfaTJjIHsKIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2OwogCWludAkJ
CXN0YXRlOwogCi0Jc3BpbmxvY2tfdAkJbG9jazsJCS8qIElSUSBzeW5jaHJvbml6YXRpb24g
Ki8KKwlyYXdfc3BpbmxvY2tfdAkJbG9jazsJCS8qIElSUSBzeW5jaHJvbml6YXRpb24gKi8K
IAogCS8qCiAJICogU2luY2UgdGhlIFRSQU5TX0RPTkUgYml0IGlzIGNsZWFyZWQgb24gcmVh
ZCwgYW5kIHdlIG1heSByZWFkIGl0CkBAIC00MTQsNyArNDE0LDcgQEAgc3RhdGljIGlycXJl
dHVybl90IGV4eW5vczVfaTJjX2lycShpbnQgaXJxbm8sIHZvaWQgKmRldl9pZCkKIAogCWky
Yy0+c3RhdGUgPSAtRUlOVkFMOwogCi0Jc3Bpbl9sb2NrKCZpMmMtPmxvY2spOworCXJhd19z
cGluX2xvY2soJmkyYy0+bG9jayk7CiAKIAlpbnRfc3RhdHVzID0gcmVhZGwoaTJjLT5yZWdz
ICsgSFNJMkNfSU5UX1NUQVRVUyk7CiAJd3JpdGVsKGludF9zdGF0dXMsIGkyYy0+cmVncyAr
IEhTSTJDX0lOVF9TVEFUVVMpOwpAQCAtNTEzLDcgKzUxMyw3IEBAIHN0YXRpYyBpcnFyZXR1
cm5fdCBleHlub3M1X2kyY19pcnEoaW50IGlycW5vLCB2b2lkICpkZXZfaWQpCiAJCWNvbXBs
ZXRlKCZpMmMtPm1zZ19jb21wbGV0ZSk7CiAJfQogCi0Jc3Bpbl91bmxvY2soJmkyYy0+bG9j
ayk7CisJcmF3X3NwaW5fdW5sb2NrKCZpMmMtPmxvY2spOwogCiAJcmV0dXJuIElSUV9IQU5E
TEVEOwogfQpAQCAtNjAyLDcgKzYwMiw3IEBAIHN0YXRpYyB2b2lkIGV4eW5vczVfaTJjX21l
c3NhZ2Vfc3RhcnQoc3RydWN0IGV4eW5vczVfaTJjICppMmMsIGludCBzdG9wKQogCSAqIEVu
YWJsZSBpbnRlcnJ1cHRzIGJlZm9yZSBzdGFydGluZyB0aGUgdHJhbnNmZXIgc28gdGhhdCB3
ZSBkb24ndAogCSAqIG1pc3MgYW55IElOVF9JMkMgaW50ZXJydXB0cy4KIAkgKi8KLQlzcGlu
X2xvY2tfaXJxc2F2ZSgmaTJjLT5sb2NrLCBmbGFncyk7CisJcmF3X3NwaW5fbG9ja19pcnFz
YXZlKCZpMmMtPmxvY2ssIGZsYWdzKTsKIAl3cml0ZWwoaW50X2VuLCBpMmMtPnJlZ3MgKyBI
U0kyQ19JTlRfRU5BQkxFKTsKIAogCWlmIChzdG9wID09IDEpCkBAIC02MTAsNyArNjEwLDcg
QEAgc3RhdGljIHZvaWQgZXh5bm9zNV9pMmNfbWVzc2FnZV9zdGFydChzdHJ1Y3QgZXh5bm9z
NV9pMmMgKmkyYywgaW50IHN0b3ApCiAJaTJjX2F1dG9fY29uZiB8PSBpMmMtPm1zZy0+bGVu
OwogCWkyY19hdXRvX2NvbmYgfD0gSFNJMkNfTUFTVEVSX1JVTjsKIAl3cml0ZWwoaTJjX2F1
dG9fY29uZiwgaTJjLT5yZWdzICsgSFNJMkNfQVVUT19DT05GKTsKLQlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZpMmMtPmxvY2ssIGZsYWdzKTsKKwlyYXdfc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmaTJjLT5sb2NrLCBmbGFncyk7CiB9CiAKIHN0YXRpYyBpbnQgZXh5bm9zNV9pMmNf
eGZlcl9tc2coc3RydWN0IGV4eW5vczVfaTJjICppMmMsCkBAIC03NDcsNyArNzQ3LDcgQEAg
c3RhdGljIGludCBleHlub3M1X2kyY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQogCS8qIENsZWFyIHBlbmRpbmcgaW50ZXJydXB0cyBmcm9tIHUtYm9vdCBvciBtaXNj
IGNhdXNlcyAqLwogCWV4eW5vczVfaTJjX2Nscl9wZW5kX2lycShpMmMpOwogCi0Jc3Bpbl9s
b2NrX2luaXQoJmkyYy0+bG9jayk7CisJcmF3X3NwaW5fbG9ja19pbml0KCZpMmMtPmxvY2sp
OwogCWluaXRfY29tcGxldGlvbigmaTJjLT5tc2dfY29tcGxldGUpOwogCiAJaTJjLT5pcnEg
PSByZXQgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOwo=
--------------AB364D24CC57C7A2DA32AE97--
