Return-Path: <SRS0=VUdo=R2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB212C10F05
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 13:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B793721902
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Mar 2019 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553346524;
	bh=sdVJbvTrPgJAKDylhcx74Gj22BFME3I9/CsiJxvJT+k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=T0hkwfoWv8tCEdvgSchyfG+JAxZl7hEw/S654q13kqAOYieutRtFVCT2jO2Usc8GY
	 BJQf9AgdZBVqbs4WsnMA/rZLhH8ckoQMKAssxLBv2yf5eca8Ql6sfab5tu2pBv8K7C
	 NTLi9kpRNrUHzo/YOIeFmQeUMAQo1ogCOXmXPlyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfCWNIj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Mar 2019 09:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfCWNIj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Mar 2019 09:08:39 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EE9218A2;
        Sat, 23 Mar 2019 13:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553346518;
        bh=sdVJbvTrPgJAKDylhcx74Gj22BFME3I9/CsiJxvJT+k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iYpWrTNO2x8ygbWfuP9IKYo3X5vRXt1Uz8BRznY5qcvpWXeAEXSHZvh2wlCFl+VEW
         93JEepjyU+fcr/ioGFQmuyDzLEWOvoF/0XQOo8UTqTj1PfHS4OvW2sCOhnSb+YPJkd
         HoOn0gzNmIjpIcKLwHaY4u0WSkZIl1CBDYfZOStA=
Message-ID: <1553346516.2307.6.camel@kernel.org>
Subject: Re: [PATCH v4 07/11] tracing: Remove trigger-extended-error-support
 testcase
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Sat, 23 Mar 2019 08:08:36 -0500
In-Reply-To: <20190323191302.321ea1d6b9cb1c75c7e828c7@kernel.org>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
         <064693880a99a7ac3cb43ee375c265a938402257.1553268041.git.tom.zanussi@linux.intel.com>
         <20190323191302.321ea1d6b9cb1c75c7e828c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Masami,

On Sat, 2019-03-23 at 19:13 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> This should be tagged with "selftests/ftrace:". :)
> 

Yeah, will change that in the next update.

Thanks,

Tom

> Thank you,
> 
> On Fri, 22 Mar 2019 10:34:33 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Error handling has been moved to the common tracing/error_log, so
> > this
> > test is no longer valid.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  .../inter-event/trigger-extended-error-support.tc  | 28 ----------
> > ------------
> >  1 file changed, 28 deletions(-)
> >  delete mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > extended-error-support.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-extended-error-support.tc
> > b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-extended-error-support.tc
> > deleted file mode 100644
> > index 9912616a8672..000000000000
> > --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-extended-error-support.tc
> > +++ /dev/null
> > @@ -1,28 +0,0 @@
> > -#!/bin/sh
> > -# SPDX-License-Identifier: GPL-2.0
> > -# description: event trigger - test extended error support
> > -
> > -
> > -fail() { #msg
> > -    echo $1
> > -    exit_fail
> > -}
> > -
> > -if [ ! -f set_event ]; then
> > -    echo "event tracing is not supported"
> > -    exit_unsupported
> > -fi
> > -
> > -if [ ! -f synthetic_events ]; then
> > -    echo "synthetic event is not supported"
> > -    exit_unsupported
> > -fi
> > -
> > -echo "Test extended error support"
> > -echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' >
> > events/sched/sched_wakeup/trigger
> > -! echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"'
> > >> events/sched/sched_wakeup/trigger 2> /dev/null
> > -if ! grep -q "ERROR:" events/sched/sched_wakeup/hist; then
> > -    fail "Failed to generate extended error in histogram"
> > -fi
> > -
> > -exit 0
> > -- 
> > 2.14.1
> > 
> 
> 
