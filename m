Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44434C10F0E
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 00:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F089C20645
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 00:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554682145;
	bh=93YWfPt7ICFT3nKl55MDHYx1afF1R+7GO79TXwMfV3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mKPAlMdPnHdSs/0JzihlqDj5XBToTjWPPv1PlL/tYaOssCV3zRIZT+86VaJlQq2rZ
	 qJyK2RjyB+qE006kDKSREcLJw5tcLZiqyjMInfP1l0AZ6ZSW9RimjtsZ4IJ8uxzKmb
	 WdSkylwHN87Dd6r3ULf5EKepLDnFyPSLSeg40MJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfDHAJD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfDHAJD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 7 Apr 2019 20:09:03 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73BD020879;
        Mon,  8 Apr 2019 00:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554682142;
        bh=93YWfPt7ICFT3nKl55MDHYx1afF1R+7GO79TXwMfV3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WmGAjaajiMW8an+Qles5MrygIN6ie7p8/IhvdGTACceZbl1GTXdSWboSNEuMqDm1S
         gLh3BDmXOL1MjqhmmQRDNMxOgjYUqYWSXiSbPkPvGZujQbzn9uvuC6dDg005VphNKU
         QhXJ3Au0Cj7PPWzCPBvYLiCxreakl0MGWGZZH0f4=
Date:   Mon, 8 Apr 2019 09:08:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [RFC][PATCH 0/3] tracing: Make error_log per instance
Message-Id: <20190408090857.47efc559ae4a09378993cb17@kernel.org>
In-Reply-To: <20190402182951.130809543@goodmis.org>
References: <20190402182951.130809543@goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

Sorry for replying late.

On Tue, 02 Apr 2019 14:29:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

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

Agreed, leaking the probe-event error on instance will not be good.

> 
> For those errors that do not have an associated instance (creating a
> kprobe/uprobe event or perf), a NULL passed to tracing_log_err() will
> result in the error message in the top level error message.
> 
> Do you (or Masami) have any issues with this patch set?
> 
> If not, please add a "reviewed-by" or "acked-by" and I'll add it
> to your patch series and push them to for-next (after more testing).

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> If this isn't obvious, this patch series is on top of:
> 
>   http://lkml.kernel.org/r/cover.1554072478.git.tom.zanussi@linux.intel.com
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
>       tracing: Have histogram code pass around trace_array for error handling
>       tracing: Have the error logs show up in the proper instances
> 
> ----
>  kernel/trace/trace.c                |  55 +++++++++-----
>  kernel/trace/trace.h                |   8 +-
>  kernel/trace/trace_events_filter.c  |  25 ++++---
>  kernel/trace/trace_events_hist.c    | 145 ++++++++++++++++++++----------------
>  kernel/trace/trace_events_trigger.c |   3 +-
>  kernel/trace/trace_probe.c          |   2 +-
>  6 files changed, 142 insertions(+), 96 deletions(-)


-- 
Masami Hiramatsu <mhiramat@kernel.org>
