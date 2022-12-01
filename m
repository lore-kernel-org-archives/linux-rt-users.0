Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2216CC4321E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Dec 2022 14:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiLAOfT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Dec 2022 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiLAOfR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Dec 2022 09:35:17 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E866201A2
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Dec 2022 06:35:16 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id r7so2012426pfl.11
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Dec 2022 06:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SMjKdo3YBdXyeXj2JfZM2d23p19QE4Af7OamqZwDEWU=;
        b=TFduToSJNwfwEzYzJ7V76BhAEhlArrwk4t3nOLgkzBvnrAoNSHEbUxf32TbY4sNRPW
         jPACWgBuo9qmPb3Vb2VTg7iVhvyR9TezdeeCkXsFg1fG6IvcNal7isft1VcyDn6M96UB
         EiJk25Y4VajiTx3gNJf8eSLbDyXX5j4MaknnCAiO7UTLJFtS2xOCfQusTgaGeXxCn8lR
         LmNz5fA0ZpChFGMWoueX7XoO5LSSJj2ju8Fudyh95+S2MUv8kMaNdYE+gOvZyOjQ4kP4
         5friCfRtVPZgqnPkhdBjwUHBpRWOFZpw4Nnchq5OdK9kbRIjlZ8zpfK08zIXeFVAKOLN
         6Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMjKdo3YBdXyeXj2JfZM2d23p19QE4Af7OamqZwDEWU=;
        b=CgZgKZp8Y5D1a/yDpJaHm2xaMK8NsPqQ8iQaWZI7jKtqysET9AtzC2PN2nz0hi2UWV
         WKg4floBz0hNTOvM/C5kXu7KU1YD5nWikgqH7e+Z8gXlmkZP6/m0hQ82yNy4WHt1r6kZ
         dH0UvK0Sb+W8uuwZo9Al735SAfJeFKrKWBliwA+CGShLzip+jGh3Sbl2easRnIpGqnCC
         IbJ5hviil7fU0SR0/XP+Tp+DQ/uMnKuisv4GTZiS3Y1q6E6sCx2Dh+CC/+6v+u8x1C9b
         w8Ki2m7wy2/EJkQ5wyMOnl5ZMrXTdJbpTSYqKg15Hd1Fu2192dT4BIAksOcGKSKycH2Q
         l01w==
X-Gm-Message-State: ANoB5plJPyYufjW7a+rOUDpS1guFLtHc+QsLC1bKVhmx02oi960XZIYS
        VVhjyI44ef2HAsdPIRL+qRQDhJLdntY3IjElBscksbbeIG0=
X-Google-Smtp-Source: AA0mqf7G1bkRiisDmZJiLwG4pIplR8742Kzsbbn1mZnIgx7OkuHwhT9Zl4dABPyzs7+L9I91Y8Fc+MSHypd83o6az+s=
X-Received: by 2002:a65:53ca:0:b0:476:dd80:fb29 with SMTP id
 z10-20020a6553ca000000b00476dd80fb29mr60330590pgr.619.1669905315600; Thu, 01
 Dec 2022 06:35:15 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?VsOtY3RvciBMw7NwZXo=?= <lopez1987@gmail.com>
Date:   Thu, 1 Dec 2022 15:34:49 +0100
Message-ID: <CAA6Pxnhb2XwztmT8QpJkokC3A6k1mmMdUoYpr-WQw6rzhjAqJQ@mail.gmail.com>
Subject: Non-rt sleep is extremely inaccurate
To:     linux-rt-users@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000255dc005eec521a7"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--000000000000255dc005eec521a7
Content-Type: text/plain; charset="UTF-8"

I reported this on https://bugzilla.kernel.org/show_bug.cgi?id=216702
two weeks ago, but I believe that the bug tracker has less activity
than this mailing list.

Here's the bug report I pasted:
std::this_thread::sleep_for and other types of sleep in non-realtime
tasks are extremely inaccurate on some RT kernels.
A sleep of 10ms may sometimes take over 700ms to complete.
The PC is idle, and there are no RT tasks running.

This has been tested on modern Intel CPUs (1165G7 and 1260p) as well
as Ryzen 4800HS.

I have tested many combinations of CPU governors and performance
settings but the problem is not fixed by those.

I initially tried  5.10, 5.16, 5.19, and 6.0, and all except 5.10
exhibited the same behavior.

With a 5.10 kernel, I may run the sample code for 20 minutes and get
3-4 messages about the sleep taking at most 25ms.

With the other kernels, multiple times per minute I get sleeps of up to 700ms.

Later I tried v6.1-rc5-rt3 which exhibits the same problem too 7-8
messages per minute.

5.16.2 with 5.16.2-rt18 works better, with 1-2 messages per minute.

5.15.49 with 5.15.49-rt47  works almost flawlessly.

I have tried the same kernels without the RT patch on the same
computers, and the problem does not occur.

I have built the kernels myself, and have also tried with the ones from:
https://packages.debian.org/search?arch=amd64&keywords=linux-image-rt

I have tried using the config from 5.10 on the 6.0 kernel, but the
problem still appears on the 6.0 rt kernel.

I would really like to use the RT patch on 6.1 or  6.2 when available
since the system we are using has an Intel Hybrid 12th gen CPU, the
support of which is being greatly improved lately.

I am attaching an example to reproduce the issue:

--000000000000255dc005eec521a7
Content-Type: text/x-c++src; charset="US-ASCII"; name="sleep.cpp"
Content-Disposition: attachment; filename="sleep.cpp"
Content-Transfer-Encoding: base64
Content-ID: <f_lb56f4qy0>
X-Attachment-Id: f_lb56f4qy0

I2luY2x1ZGUgInRocmVhZCIKI2luY2x1ZGUgImlvc3RyZWFtIgoKaW50IG1haW4oaW50ICwgY2hh
ciAqKikKewogIHdoaWxlICh0cnVlKQogIHsKICAgIGF1dG8gYmVnaW4gPSBzdGQ6OmNocm9ubzo6
c3lzdGVtX2Nsb2NrOjpub3coKTsKICAgIHN0ZDo6dGhpc190aHJlYWQ6OnNsZWVwX2ZvcihzdGQ6
OmNocm9ubzo6bWlsbGlzZWNvbmRzKDEwKSk7CiAgICBhdXRvIGVuZCA9IHN0ZDo6Y2hyb25vOjpz
eXN0ZW1fY2xvY2s6Om5vdygpOwogICAgaWYgKGVuZCAtIGJlZ2luID4gc3RkOjpjaHJvbm86Om1p
bGxpc2Vjb25kcygyMCkpCiAgICB7CiAgICAgIHN0ZDo6Y2VyciA8PCBzdGQ6OmNocm9ubzo6ZHVy
YXRpb25fY2FzdDxzdGQ6OmNocm9ubzo6bWlsbGlzZWNvbmRzPihlbmQgLSBiZWdpbikuY291bnQo
KQogICAgICAgICAgICAgICAgPDwgc3RkOjplbmRsOwogICAgfQogIH0KICByZXR1cm4gMDsKfQo=
--000000000000255dc005eec521a7--
