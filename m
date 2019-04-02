Return-Path: <SRS0=WXxn=SE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469CBC4360F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 20:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116E82084B
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 20:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554237740;
	bh=Z3qgXvur47QgkKcSdrdz2jtBIfrikSxESpHDc40HT6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=cOKRb3IS+tn/00enY+Nl5p2vKRF8hwne0SpS1X5twEUffFC5Eq7OgLErU455WrbF0
	 jkg40cpwJUYJYkDTL+AQ24i43tsoLhJq+vPQ++kq268Xe1RpYJK3Ua91BeodEbZfOt
	 ev4hkTtTijQgr9LwysMwiX4Y6ar4oqIwtkelftrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfDBUmT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfDBUmT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Apr 2019 16:42:19 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD4A2082C;
        Tue,  2 Apr 2019 20:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554237738;
        bh=Z3qgXvur47QgkKcSdrdz2jtBIfrikSxESpHDc40HT6o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rQOTxXiXjCTX5RPHC1FK3Ts6FjzYbBTaGl0fQlUj/HAv0Uc6uy4blOZDl4fGRd1hy
         9uhWtUsBbhbHzKnyvLn36e5/+Jw4tcXNPKun/SgsuRoY0LE6fLKXdZ3N7JrKg+satX
         trzwVETN7p7AOhsqShHTeK2P/nepdfRQl910pCC8=
Message-ID: <1554237736.11284.4.camel@kernel.org>
Subject: Re: [RFC][PATCH 0/3] tracing: Make error_log per instance
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date:   Tue, 02 Apr 2019 15:42:16 -0500
In-Reply-To: <20190402182951.130809543@goodmis.org>
References: <20190402182951.130809543@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Tue, 2019-04-02 at 14:29 -0400, Steven Rostedt wrote:
> Hi Tom,
> 
> I noticed that you created an error_log file in every instance, but
> they all show the same errors. These three patches make it so that
> the errors appear in the instance directory that they happened in.
> If you write a bad error to
> 
>    /sys/kernel/tracing/instance/foo/events/sched/sched_switch/hist
> 
> It appears only in
> 
>   /sys/kernel/tracing/instances/foo/error_log
> 
> Which I think is the proper approach, especially instances should not
> affect the top directory or other instances.
> 
> For those errors that do not have an associated instance (creating a
> kprobe/uprobe event or perf), a NULL passed to tracing_log_err() will
> result in the error message in the top level error message.
> 
> Do you (or Masami) have any issues with this patch set?
> 
> If not, please add a "reviewed-by" or "acked-by" and I'll add it
> to your patch series and push them to for-next (after more testing).
> 

Looks good, thanks for doing this.  You can add my:

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>

FYI, I noticed one bit of trailing whitespace in 2/3 - you might want
to run it through checkpatch again before you merge ;-)

Thanks,

Tom


> If this isn't obvious, this patch series is on top of:
> 
>   http://lkml.kernel.org/r/cover.1554072478.git.tom.zanussi@linux.int
> el.com
> 
> Actually, I added it right after patch 5 of that series (before the
> selftests and documentation).
> 
> Thanks!
> 
> -- Steve
> 
> 
> 
> Steven Rostedt (VMware) (3):
>       tracing: Add trace_array parameter to create_event_filter()
>       tracing: Have histogram code pass around trace_array for error
> handling
>       tracing: Have the error logs show up in the proper instances
> 
> ----
>  kernel/trace/trace.c                |  55 +++++++++-----
>  kernel/trace/trace.h                |   8 +-
>  kernel/trace/trace_events_filter.c  |  25 ++++---
>  kernel/trace/trace_events_hist.c    | 145 ++++++++++++++++++++----
> ------------
>  kernel/trace/trace_events_trigger.c |   3 +-
>  kernel/trace/trace_probe.c          |   2 +-
>  6 files changed, 142 insertions(+), 96 deletions(-)
