Return-Path: <SRS0=V9Xa=WK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BC7C433FF
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 11:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85713208C2
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 11:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfHNL07 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:26:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37422 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfHNL06 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Aug 2019 07:26:58 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxrQe-0003QC-EG; Wed, 14 Aug 2019 13:26:56 +0200
Date:   Wed, 14 Aug 2019 13:26:56 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
Message-ID: <20190814112656.z3de2rgbqzpaquz5@linutronix.de>
References: <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com>
 <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
 <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
 <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
 <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
 <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-13 14:02:39 [-0400], Paul Thomas wrote:
> I still get large latencies, like this:
> root@xu5:/opt/rt-tests# ./cyclictest -h ./cyclictest -S -m -n -p 99 -i
> 200 -h 400 -D 900
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.10 0.10 0.03 1/134 1901
> 
> T: 0 ( 1886) P:99 I:200 C:2724618 Min:      5 Act:    6 Avg:    6 Max:      45
> T: 1 ( 1887) P:99 I:200 C:2724525 Min:      5 Act:    7 Avg:    6 Max:      29
> T: 2 ( 1888) P:99 I:200 C:2724246 Min:      5 Act:    6 Avg:    6 Max:    6338
> T: 3 ( 1889) P:99 I:200 C:2724339 Min:      5 Act:    8 Avg:    6 Max:     141
> 
> This is with the Lazy preempt commit in there.

I re-read the thread and figured out that you talk about 5.0 while I was
testing on 5.2. On my ARM64 box I end up with

|T: 0 ( 9577) P:99 I:250 C:19979015 Min:      3 Act:    4 Avg:    3 Max:      19                                                              
|T: 1 ( 9578) P:99 I:250 C:19978958 Min:      3 Act:    3 Avg:    3 Max:      24                                                              
|T: 2 ( 9579) P:99 I:250 C:19978901 Min:      3 Act:    4 Avg:    4 Max:      22                                                              
|T: 3 ( 9580) P:99 I:250 C:19978843 Min:      3 Act:    3 Avg:    3 Max:      19                                                              

with the patch I sent you. Without it, had spikes between 130us and
160us. Since you said it is not working, I looked more and came up with
this:

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 3bfad251203b5..ca1c6fe8dd347 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -73,6 +73,8 @@ static inline bool __preempt_count_dec_and_test(void)
 	if (!pc || !READ_ONCE(ti->preempt_count))
 		return true;
 #ifdef CONFIG_PREEMPT_LAZY
+	if ((pc & ~PREEMPT_NEED_RESCHED))
+		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);

but this shouldn't make any difference for you (but it is a bug fix).
Staring more into it, I don't see anything wrong.

v5.0 is not supported any more. Do you think, that you could re-test on
5.2-RT with those two patches I sent you?

> thanks,
> Paul

Sebastian
