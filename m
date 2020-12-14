Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB86C4361B
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 06:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFD7229F0
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 06:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391916AbgLNGJy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 01:09:54 -0500
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:52948 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgLNGJy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Dec 2020 01:09:54 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0BE67wbX017540; Mon, 14 Dec 2020 15:07:58 +0900
X-Iguazu-Qid: 34tKVBJTs7nslYEG8C
X-Iguazu-QSIG: v=2; s=0; t=1607926077; q=34tKVBJTs7nslYEG8C; m=LRAxgXNrX/mzO1a6jFP2Mf6RSEFZqpRUWrl8/IEP8TU=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id 0BE67vuv032165;
        Mon, 14 Dec 2020 15:07:57 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0BE67vbv017136;
        Mon, 14 Dec 2020 15:07:57 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0BE67uXi012587;
        Mon, 14 Dec 2020 15:07:56 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     <linux-rt-users@vger.kernel.org>
Subject: Re: RT kernel testing with stress-ng and scheduling while in atomic bugs.
References: <b9317e8c-d5d9-e440-6c32-f9c26ad4ef10@canonical.com>
Date:   Mon, 14 Dec 2020 15:07:54 +0900
In-Reply-To: <b9317e8c-d5d9-e440-6c32-f9c26ad4ef10@canonical.com> (Colin Ian
        King's message of "Mon, 7 Dec 2020 12:43:47 +0000")
X-TSB-HOP: ON
Message-ID: <878sa03op1.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Colin,

Colin Ian King <colin.king@canonical.com> writes:

> Hi,
>
> I've recently been exercising the 5.10-rc6 kernel with the latest RT
> patches from linux-rt-devel (v5.10-rc6-rt13) using stress-ng V0.12.00
> [1][2] to see rugged the RT kernel is and I'm getting quite a few
> "scheduling while atomic:" bugs in various stress-tests.
>
> While I realize this is a rc6 kernel, I was surprised to be able to trip
> these issues so easily [3]
>
> Questions:
>
> 1. Are these issues expected?
> 2. Is there an official way to report my bug findings?
> 3. I am keen to debug and fix these issues, have RT folk got some advice
> on how to start debugging these kind of issues?
>
> On an 8 CPU SMP test box stress-ng is hitting these issues on the
> following stress tests:
>
> daemon enosys exec fork fstat madvise prctl pthread session sigpipe vfork
>
> ..it seems fork/clone + scheduling is the common feature in the stress
> tests that is triggering this issue.
>
> How to reproduce:
>
> git clone https://github.com/ColinIanKing/stress-ng.git
> cd stress-ng
> make clean
> make fast-test-all

I tried to reproduce the failures bug am not getting any errors
following the above steps.

    ~/src/stress-ng$ make fast-test-all
    ...
    stress-ng: 14:20:53.88 debug: [261118] metrics-check: all stressor
    metrics validated and sane
    zombie PASSED
    240 PASSED
    0 FAILED
    7 SKIPPED, bind-mount binderfs cpu-online mlockmany oom-pipe sysinval watchdog

Not sure if the problems you saw were fixed in the interim but I am
using 5.10.0-rc6-rt14 on a quad core Apollolake system.

Are there any configs that need enabling? I used defconfig + Intel LPSS
 for platform support + PREEMPT_RT.

Thanks,
Punit

[...]
