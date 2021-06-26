Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEF1C49EA6
	for <linux-rt-users@archiver.kernel.org>; Sat, 26 Jun 2021 06:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5F061465
	for <linux-rt-users@archiver.kernel.org>; Sat, 26 Jun 2021 06:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFZG6C (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 26 Jun 2021 02:58:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:58683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFZG6B (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 26 Jun 2021 02:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624690535;
        bh=jSpWKAZvfuSmdJcaGlMl2mDrf1PcSKHFOfCTFtzz/zQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=XLFGx5PCI+8iwEqeS4Qz3tpkaTRPsW2eH5uMJU8wUAz3/nMnWzXZPn9UPHAwnJ0zI
         4h3cxwt9nA4TlH6Q5V8AkuhRuvAp1Xh+BjvuigE0Bstca5N163HSiSoytqhdswOkLZ
         0ALTXFs5McH/KMWW0iAGGmEtQtUMMA1+AIMAAJuk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.49]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1lJqvZ1kze-00hfkt; Sat, 26
 Jun 2021 08:55:35 +0200
Message-ID: <549a4a5579068b9b1ca7741cb0f4aafbd04f4389.camel@gmx.de>
Subject: Re: [ANNOUNCE] rt-tests-2.0
From:   Mike Galbraith <efault@gmx.de>
To:     John Kacur <jkacur@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johnathan Schwender <schwenderjonathan@gmail.com>,
        Peter Xu <peterx@redhat.com>
Date:   Sat, 26 Jun 2021 08:55:34 +0200
In-Reply-To: <20210625160801.9283-1-jkacur@redhat.com>
References: <20210625160801.9283-1-jkacur@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FkFbtuYdaz+FDJba47sWBYnoxlqgSsBlmEuoHqmObWz+xvYRwh+
 Zw7PqEtC+ft0mugS21RGRksO1FXGIcOTd8D9J1E/dtI6s0Mlh3ajNz6YZlNMy1MJzmFLMfA
 Nze7Pg9WtpL56yse76R+NTGabCAZAb39FAxerxeBJZE0xMLtd1leU0PKtimqbmbWQFawbmo
 nykINkWbhQwWwmQuIObDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aYdCFY/i/Zs=:1PxWCLq78k6M78YPcef63e
 b7UYUGzuDiEiozkScndyhqANus+Q981tMDla8M/CzkerL+8l9/I3JD9sxgN/luGFlL5gws0xk
 Rfk+PTU3W1VSAQS/n07tRWx2yigSeaed0nxjpmyu40ipjFWF5a1jyyBUW2ttahDAItrpxEloo
 Nxa4L0V6326RKYm7eHAxocRwWqgJSu108Ug7NIs90toSpGSeX7VHOYbBsO3x6v8EqtmsqZegC
 prZKBnqLL8g4faZttVfaYbc+uTih05Y9WAHHqCX5YfF8JH/1qzcnmt4Yt5LfkHL6AL5u+Ms40
 MDkUIicm1vda5ZyOq2LwIyMTQSVvEGeXjT5/EFC97vpxRtREwP3O7wO9eTv+6klltXL43GqWL
 ucrqhGBq2qJPWS+zsbmAg2x243odM4TVSXneP1WfEusQXcIqKZlGj85XGy+st+dHmhGt3QSMf
 k+4cGzgP/VrQf5v+CIKI7ekBv9szlF6cMJUmIVgrz0wlFznr/fQftkugN2TVPKULBwwWW1+2R
 7jsa/pS2LyyIdkW5H/ShAczmFjrY2T6okfenDRyDkcGR2V5gwY7ho04WPfhicMoR/or+FGwTW
 vox+gk90UPLaHFnHU4K9AqJ8AhtkL+i+4o+VgnUNM5SdghvyCbrFBNjWZA8BeiyJDX2nLrQqH
 4g9eTnBk4y+4mAXqOAb25/jaMCKIMQXWAIZila3YM0zHJZOsdYzVGVrVJHj81zZFLdkOsUA9U
 bKvid8hqYIf3w5MuuJCYdwFPMxWvYpKSrPzQ3Qr34xWVFVSFDxXY+i3jxaO4f4N55q1exNsay
 +RZIQpLqNUecjF2WzaOrkE1Lp8KZfJvnUZNki4dfmmahQtrGz0zaiKAFEChcE9BJV9nQZYQqV
 sTOjuXb929Xbdmh7JSGXoY5MNcqaBxevtxdyhIoTEeWdXVZGR8sS/A5C9hFwnSCvwg6jTNaiU
 SHxpnYi14BZtLASVXmXJZwqSJ0Eeq5YhDIry0XGGge16wtxuXM30sC0CuqHBcrQSyFdb4w+zM
 je4DxiEw4xGPaXCDx218VEux7O1BGWNySbdEL2mOtx4HtauLwwbTFwbR5hmyDKXsBj2TFw8/r
 3+oFbuKOWYdi1JnY82ZT/M+bIADEC+SHIMv
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-06-25 at 12:08 -0400, John Kacur wrote:
> I'm pleased to announce rt-tests-2.0

Greetings,

cyclictest seems to have grown an mlock related regression.

homer:..git/rt-tests # ./cyclictest -Smp99
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 1.01 1.04 0.51 1/838 4411

T: 0 ( 4404) P:99 I:1000 C:   1536 Min:      1 Act:    1 Avg:    3 Max:   =
 3846
T: 1 ( 4405) P:99 I:1500 C:   1021 Min:      1 Act:    1 Avg:    6 Max:   =
 5912
T: 2 ( 4406) P:99 I:2000 C:    765 Min:      1 Act:    1 Avg:    8 Max:   =
 5368
T: 3 ( 4407) P:99 I:2500 C:    611 Min:      1 Act:    1 Avg:    9 Max:   =
 4862
T: 4 ( 4408) P:99 I:3000 C:    508 Min:      1 Act:    1 Avg:    9 Max:   =
 4394
T: 5 ( 4409) P:99 I:3500 C:    436 Min:      1 Act:    1 Avg:    5 Max:   =
 1699
T: 6 ( 4410) P:99 I:4000 C:    381 Min:      1 Act:    1 Avg:    1 Max:   =
    4
T: 7 ( 4411) P:99 I:4500 C:    338 Min:      1 Act:    1 Avg:    1 Max:   =
    4

Leave off -m switch...

homer:..git/rt-tests # ./cyclictest -Sp99
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 1.19 1.02 0.55 1/833 4447

T: 0 ( 4440) P:99 I:1000 C:   1533 Min:      1 Act:    1 Avg:    1 Max:   =
    4
T: 1 ( 4441) P:99 I:1500 C:   1022 Min:      1 Act:    1 Avg:    1 Max:   =
    4
T: 2 ( 4442) P:99 I:2000 C:    766 Min:      1 Act:    1 Avg:    1 Max:   =
    4
T: 3 ( 4443) P:99 I:2500 C:    613 Min:      1 Act:    1 Avg:    1 Max:   =
    4
T: 4 ( 4444) P:99 I:3000 C:    511 Min:      1 Act:    1 Avg:    1 Max:   =
    4
T: 5 ( 4445) P:99 I:3500 C:    438 Min:      1 Act:    1 Avg:    1 Max:   =
    3
T: 6 ( 4446) P:99 I:4000 C:    383 Min:      1 Act:    1 Avg:    1 Max:   =
    4
T: 7 ( 4447) P:99 I:4500 C:    340 Min:      1 Act:    1 Avg:    1 Max:   =
    4

...and v2.0 regression goes away.

	-Mike

