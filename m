Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D20AC35656
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 16:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0139B24650
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 16:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdVM3ksX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBUQKo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:10:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51619 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727137AbgBUQKo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 11:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582301443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSvAKKJbE6XFoVvhHxXi7quCvcPM1viOTOGDy9CPgoE=;
        b=UdVM3ksXi9pdvEpJXeCkMgOivQm+4/mpS4Wpn+ptB7eyB7asxJ5XEaSUygQJnCPR+plqCN
        fSmNWg1UHch5Q3PpvVBGJjiHNgDGfSopv3Z4nX8QH/iFNc2prG/virMmvRMkjuBE+0BmFZ
        /cU/OTEAeyTUXwzfwoaLlwPojovmVCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-IOp_ep4XPkK_FiNXmZemhg-1; Fri, 21 Feb 2020 11:10:38 -0500
X-MC-Unique: IOp_ep4XPkK_FiNXmZemhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6817D8010CA;
        Fri, 21 Feb 2020 16:10:37 +0000 (UTC)
Received: from krava (ovpn-204-73.brq.redhat.com [10.40.204.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 512F719E9C;
        Fri, 21 Feb 2020 16:10:33 +0000 (UTC)
Date:   Fri, 21 Feb 2020 17:10:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] tracing: Fix trace entry and trace common fields for
 preempt_lazy_count
Message-ID: <20200221161030.GC657629@krava>
References: <20200221153541.681468-1-jolsa@kernel.org>
 <20200221104922.5ea8bb5f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221104922.5ea8bb5f@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Feb 21, 2020 at 10:49:22AM -0500, Steven Rostedt wrote:
> On Fri, 21 Feb 2020 16:35:41 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > When commit 65fd07df3588 added preempt_lazy_count into 'struct trace_entry'
> > it did not add 4 bytes padding. Also we need to update the common fields
> > for tracepoint, otherwise some tools (bpftrace) stop working due to missing
> > common fields.
> > 
> > Fixes: 65fd07df3588 ("x86: Support for lazy preemption")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/trace_events.h | 2 ++
> >  kernel/trace/trace_events.c  | 3 +++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index f3b1ef07e4a5..51a3f5188923 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -65,6 +65,8 @@ struct trace_entry {
> >  	unsigned short		migrate_disable;
> >  	unsigned short		padding;
> >  	unsigned char		preempt_lazy_count;
> > +	unsigned char		padding1;
> > +	unsigned short		padding2;
> 
> 
> Wait! I don't have these changes in my tree, nor do I see them in
> Linus's. This really bloats the trace events! This header is very
> sensitive to size and just willy nilly adding to it is unacceptable.
> It's like adding to the page_struct. This gets added to *every* event,
> and a single byte added, causes 1M extra for a million events (very
> common in tracing). It causes 1G extra for a billion events.

I'm on top of:
  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
  v5.4.19-rt11-rebase

> 
> Let's find a better way to handle this.

I can fix the bpftrace tool I guess, through it's not
so convenient the way it's used in it

jirka

> 
> -- Steve
> 
> 
> >  };
> >  
> >  #define TRACE_EVENT_TYPE_MAX						\
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index accaae59a762..1fe37b7aeaff 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -183,6 +183,9 @@ static int trace_define_common_fields(void)
> >  	__common_field(int, pid);
> >  	__common_field(unsigned short, migrate_disable);
> >  	__common_field(unsigned short, padding);
> > +	__common_field(unsigned char,  preempt_lazy_count);
> > +	__common_field(unsigned char,  padding1);
> > +	__common_field(unsigned short, padding2);
> >  
> >  	return ret;
> >  }
> 

