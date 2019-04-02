Return-Path: <SRS0=WXxn=SE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A484BC4360F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 20:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A93E2084B
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 20:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfDBU5Y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfDBU5Y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Apr 2019 16:57:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6350A20674;
        Tue,  2 Apr 2019 20:57:22 +0000 (UTC)
Date:   Tue, 2 Apr 2019 16:57:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [RFC][PATCH 0/3] tracing: Make error_log per instance
Message-ID: <20190402165720.4788e7f8@gandalf.local.home>
In-Reply-To: <1554237736.11284.4.camel@kernel.org>
References: <20190402182951.130809543@goodmis.org>
        <1554237736.11284.4.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 02 Apr 2019 15:42:16 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> On Tue, 2019-04-02 at 14:29 -0400, Steven Rostedt wrote:
> > Hi Tom,
> > 
> > I noticed that you created an error_log file in every instance, but
> > they all show the same errors. These three patches make it so that
> > the errors appear in the instance directory that they happened in.
> > If you write a bad error to
> > 
> >    /sys/kernel/tracing/instance/foo/events/sched/sched_switch/hist
> > 
> > It appears only in
> > 
> >   /sys/kernel/tracing/instances/foo/error_log
> > 
> > Which I think is the proper approach, especially instances should not
> > affect the top directory or other instances.
> > 
> > For those errors that do not have an associated instance (creating a
> > kprobe/uprobe event or perf), a NULL passed to tracing_log_err() will
> > result in the error message in the top level error message.
> > 
> > Do you (or Masami) have any issues with this patch set?
> > 
> > If not, please add a "reviewed-by" or "acked-by" and I'll add it
> > to your patch series and push them to for-next (after more testing).
> >   
> 
> Looks good, thanks for doing this.  You can add my:
> 
> Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks, will do.

> 
> FYI, I noticed one bit of trailing whitespace in 2/3 - you might want
> to run it through checkpatch again before you merge ;-)

Hmm, strange that git didn't complain about that. It usually does on a
commit. Or perhaps (more likely) it did, and I didn't notice ;-)

-- Steve
