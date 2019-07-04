Return-Path: <SRS0=a459=VB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CB5C0650E
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jul 2019 08:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298DC218AD
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jul 2019 08:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGDIAg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:00:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58179 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGDIAg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Jul 2019 04:00:36 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hiwfS-0005fA-BH; Thu, 04 Jul 2019 10:00:34 +0200
Date:   Thu, 4 Jul 2019 10:00:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "xiaoqiang.zhao" <zhaoxiaoqiang007@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: schdule bug in 4.4.38-rt49
Message-ID: <20190704080034.i6lztjc4ocykrwpy@linutronix.de>
References: <55c68f08-4160-4bee-fdc5-9fc1ea86cf57@gmail.com>
 <20190703114256.3b52kbrududxq7vz@linutronix.de>
 <987eec05-14d0-29a5-723c-7bfbc0a5465b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <987eec05-14d0-29a5-723c-7bfbc0a5465b@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-04 13:50:08 [+0800], xiaoqiang.zhao wrote:
> 
> > > 2) -> __schedule_bug ( leads to kernel pagefault exception, OOPS!!)
> > > 
> > > Before schedule, we have call preempt_disable twice, this will definitely
> > > bump preempt_count to 2 and
> > 
> > something probably disabled preemption before that
> 
> I feel this is not make sense.  In my opinion, the preempt_count must be
> zero before we call 'schedule()',

that is correct. I was saying that the preempt count was > 0 before
wake_up() was invoked.

> otherwise, in_atomic_preempt_off will return true and trigger the
> __schedule_bug. If we have already
> 
> disable_preempt, we may in atomic context and we should not call schedule,
> right ?

correct.

Sebastian
