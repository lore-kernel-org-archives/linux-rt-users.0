Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21E6C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 15:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775FC2171F
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552489449;
	bh=bjhNnvGoZyrO88NM0oR5TXqw0JniZtRUqrox/oqc2uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ThDP1k5N3NuLar+OovcHRYgKX77iy1L7/JNvs+bu5k7kUKGZe7boPOq5B3Vhm7140
	 QUEpzpKGvWbaeFDjSiwLdlnkN1r4bXkG+ZLoIzw9z1CY8gXBIGckNvv0BfIYTv0mJ8
	 rOM4ZwXlryOkTVtwGtFMHC20BDVzg3ALoZE/2mj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfCMPEI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfCMPEH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 11:04:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06942214AE;
        Wed, 13 Mar 2019 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552489446;
        bh=bjhNnvGoZyrO88NM0oR5TXqw0JniZtRUqrox/oqc2uM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1YVVve2xS5SB29cgZgOA+HmEGSvEZwYCe4Xoobk9l7V8PVv7XAm374Iyev2yIjL2W
         hw0FfneLBQNM/BypA+RrCuxeon/zdnNdB7vUMbQ/bUaDV2hmqDW63Q+yp+QFDs3Py4
         8LeW9n7tYbDLXwNhK2u9F68Fjz4GFDAWBCur3aXc=
Date:   Thu, 14 Mar 2019 00:04:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] tracing/probe: Check event/group naming rule at
 parsing
Message-Id: <20190314000402.3b14693f9030e891648124f1@kernel.org>
In-Reply-To: <20190313092355.6f434c9f@gandalf.local.home>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
        <155248009231.10815.12287201787254147977.stgit@devnote2>
        <20190313092355.6f434c9f@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 13 Mar 2019 09:23:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 13 Mar 2019 21:28:12 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Check event and group naming rule at parsing it instead
> > of allocating probes.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_kprobe.c |    7 +------
> >  kernel/trace/trace_probe.c  |    8 ++++++++
> >  kernel/trace/trace_uprobe.c |    5 +----
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index d47e12596f12..5222fd82e7e4 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -221,7 +221,7 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
> >  
> >  	tk->rp.maxactive = maxactive;
> >  
> > -	if (!event || !is_good_name(event)) {
> > +	if (!event || !group) {
> >  		ret = -EINVAL;
> >  		goto error;
> >  	}
> > @@ -231,11 +231,6 @@ static struct trace_kprobe *alloc_trace_kprobe(const char *group,
> >  	if (!tk->tp.call.name)
> >  		goto error;
> >  
> > -	if (!group || !is_good_name(group)) {
> > -		ret = -EINVAL;
> > -		goto error;
> > -	}
> > -
> >  	tk->tp.class.system = kstrdup(group, GFP_KERNEL);
> >  	if (!tk->tp.class.system)
> >  		goto error;
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index feae03056f0b..1f0cb4030c0b 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -172,6 +172,10 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> >  			return -E2BIG;
> >  		}
> >  		strlcpy(buf, event, slash - event + 1);
> > +		if (!is_good_name(buf)) {
> > +			pr_info("Group name must follow the rule of C identifier\n");
> 
> What do you mean by "C identifier"?

I meant "the naming rules of C language identifiers". It means
that the name has to start with alphabet or "_" and only contain
alphanumeric characters and "_". Does it clear?
I couldn't think of a good word. maybe "naming convention"
does not fit...

Would you have any idea?

Thank you,

> 
> -- Steve
> 
> > +			return -EINVAL;
> > +		}
> >  		*pgroup = buf;
> >  		*pevent = slash + 1;
> >  		event = *pevent;
> > @@ -184,6 +188,10 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> >  		pr_info("Event name is too long\n");
> >  		return -E2BIG;
> >  	}
> > +	if (!is_good_name(event)) {
> > +		pr_info("Event name must follow the rule of C identifier\n");
> > +		return -EINVAL;
> > +	}
> >  	return 0;
> >  }
> >


-- 
Masami Hiramatsu <mhiramat@kernel.org>
