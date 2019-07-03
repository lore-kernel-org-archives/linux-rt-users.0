Return-Path: <SRS0=+P7g=VA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77FBC0650E
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D92218A0
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 13:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGCNOA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:14:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52436 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCNN5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Jul 2019 09:13:57 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hif5A-0005lX-4Q; Wed, 03 Jul 2019 15:13:56 +0200
Date:   Wed, 3 Jul 2019 15:13:56 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jean-Michel Hautbois <jhautbois@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Fwd: Question about PREEMPT_RT and wakeup_rt latency
Message-ID: <20190703131355.snxsju2eii5cof2h@linutronix.de>
References: <CAL8zT=hcP=z_iM+rcUcaTOXLMqVDVn=gbnybp-Q-cmAyKJCzUg@mail.gmail.com>
 <CAL8zT=hmt939+2hUN-bine0bk5vq=RMtzdWqsOoog16LRxv2cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAL8zT=hmt939+2hUN-bine0bk5vq=RMtzdWqsOoog16LRxv2cg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-25 15:40:56 [+0200], Jean-Michel Hautbois wrote:
> Hi,
Hi,

> I have a latency issue, and tried to use wakeup_rt latency to detect
> it but I am not sure to really understand the output of ftrace...
> >From what I understand, the interrupt "irq/28" is having a latency of
> ~2ms ?? It sound like a very big latency !

From the trace, looking only at cpu0 ->
- irq/28-c-256 is scheduled until 1581us which 1.5ms.
- irq/57-2-122 is scheduled until 2287us another 706us

and so on.

> And this customer has forced affinity and priorities on its threads,
> and I think it could explain such a behaviour ? For instance the task
> named "tLaserLo-762" is in fact forced with an affinity of 2 and a
> priority of SCHED_FIFO 30.
> 
> https://framabin.org/p/?e63c638b5cf2e4ec#GS6ahFDEI/m6vyY2lwafB96vbgA4Skft1d+Dvtry2QI=

it is not the nicest pastebin page to grab the bare text file from…

> I think it gives a very nice example of what preemption really is, but
> it can be confusing.
> Can it be traced with kernelshark or something else ?

you could try to trace with kernelshark and enable the scheduling
events. You should be able to see when a task is woken up and when it
finally got on the CPU. And then you can decide what to do.

> Thanks,
> JM

Sebastian
