Return-Path: <SRS0=srch=2A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF04C2D0BF
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Dec 2019 11:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B8220726
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Dec 2019 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6pwNAQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLJLYF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:24:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46359 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfLJLYF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Dec 2019 06:24:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so19492388wrl.13
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Dec 2019 03:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IrBu0OBXLGPgOu20RgdN6jkql1NtJ2OHIAH5rqYNqWo=;
        b=f6pwNAQrfZNwFXDXpre8/L+K7Y5iLy5O2UpoOOamwwhwfsMEH+f/rPW0gAg0xDjtMG
         e9/vrmhNzcD95DAD/ggrCD7Lzu4mO4RymIJQ/IkbpddnXYpFJ+GxsqsaRqIoPIaiTsiI
         oulPTpJwVTWOliUhvSKs9Njj/KtyoS/gmM0Wm8Uvk877ZhDVTqD2bMxM6cMgw9l+qMOX
         iYeZJPg9iY0EQHrU1eJCe17aXrGnTCZ5fHVQiq/C27YWCz6wFKpxpS24at+jAUY7tuHt
         9AWIHkKPbFv6LC5LLBH4qSfMM3gVGmlanyswmpxMPq17S045CWY7U02Z+RsyUaaXvnUw
         psVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=IrBu0OBXLGPgOu20RgdN6jkql1NtJ2OHIAH5rqYNqWo=;
        b=pB7ZR0lhPfBNfNro7YxlRCpBlWxdwVRKBtuMSeW4z92JtBrkJas1A0E8VeMqYY2OGa
         r9kttS6iBaiEBaWJTpC5AwOOKFbIvQGsD3UFpF0iWSHXgbxbHoG8+Q6Ja/D6Vdw8hGsN
         TxZRVFRwebUXnj4kz1PpYQGTGm3lQPWBq4hqXtNwxKr5qmJWG9n3R8UjnX+hklCYdepM
         YchGqatJsQ5s3kd04sPvdd9evjYt5WAmffTkomgDOQFNE7htT3tdP9nUF5XbwwO4Ijqp
         zpXUYhtkSHcCx75vwkK7spgL/rb2Prc9jCxMVgjFatFo0E1UtIyPrxp65/8Yx7+AO7TR
         nE0w==
X-Gm-Message-State: APjAAAUs1rP7oPACxJbBh7OXVW1tDbubbUlaPpLbW/aL0hk1+dHNbbAn
        1UKIzA1T2rh9QMHVJ/+fcM0=
X-Google-Smtp-Source: APXvYqwr2qi+1deMZjg5n6AYECNbf6DPWuhUjM6eKSe4a23W96pWoeFVhSXDl00YTMZkfYNLUC3m0g==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr2558048wru.173.1575977043264;
        Tue, 10 Dec 2019 03:24:03 -0800 (PST)
Received: from planxty.fritz.box ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id y6sm2934443wrl.17.2019.12.10.03.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 03:24:02 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:24:01 +0100 (CET)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty.fritz.box
To:     Daniel Wagner <wagi@monom.org>
cc:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@debian.org>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick
 also for all !x86 archs
In-Reply-To: <18a0be03-74dd-54f1-a0f0-4f4acdd061ad@monom.org>
Message-ID: <alpine.LFD.2.21.1912101223460.4472@planxty.fritz.box>
References: <20191208210625.5999-1-ukleinek@debian.org> <18a0be03-74dd-54f1-a0f0-4f4acdd061ad@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-1829164996-1575977042=:4472"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1829164996-1575977042=:4472
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 9 Dec 2019, Daniel Wagner wrote:

> Hi Uwe,
> 
> On 2019-12-08 22:06, Uwe Kleine-König wrote:
> > This fixes a build error on arm64, mips*, ppc and several others
> 
> Just wondering if the tool should print a warning if the fallback is used?
> IIRC, the code wants to use the TSC and clock_gettime is probably not so
> precise.
> 
> Thanks,
> Daniel
> 

I take patches!

John Kacur
---1463804494-1829164996-1575977042=:4472--
