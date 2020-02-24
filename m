Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773C8C11D2F
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 11:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8FF2084E
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 11:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUuGHZy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgBXLyP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:54:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42097 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726778AbgBXLyO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 06:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582545253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k1yNrKubK76pLZB/Z3cuqDBCWEfyVtNMilq8oB52aCc=;
        b=aUuGHZy/Tqwi1Jjw6Cin3wpTXPODkIUTthL0VHNDyuApury4JZYVJyEGjMGnrEKXm3eh1r
        mXeg+hUOs2o6silcW3fOoxAAwYsaw6AVpQwt7wZN7JyZEg/3P0Y7n09QqHu17c34Sd65rO
        qAB6JpHE+dyTb7JUGUZ7WV6BvA/0Hr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-LUx_wFtWM7KhiA8XDwm_Uw-1; Mon, 24 Feb 2020 06:54:12 -0500
X-MC-Unique: LUx_wFtWM7KhiA8XDwm_Uw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE23318C35A4;
        Mon, 24 Feb 2020 11:54:10 +0000 (UTC)
Received: from krava (ovpn-204-56.brq.redhat.com [10.40.204.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B47091840;
        Mon, 24 Feb 2020 11:54:06 +0000 (UTC)
Date:   Mon, 24 Feb 2020 12:54:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH RT] tracing: make preempt_lazy and migrate_disable
 counter smaller
Message-ID: <20200224115403.GD16664@krava>
References: <20200221153541.681468-1-jolsa@kernel.org>
 <20200221104922.5ea8bb5f@gandalf.local.home>
 <20200221161030.GC657629@krava>
 <20200221112152.031b4230@gandalf.local.home>
 <20200221163735.53wt2fqoajcuj2js@linutronix.de>
 <20200221174419.7r5zxfkvz4yrndi2@linutronix.de>
 <20200221204957.GE657629@krava>
 <20200224100104.sbupmfe2oehmsrrb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224100104.sbupmfe2oehmsrrb@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Feb 24, 2020 at 11:01:04AM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-02-21 21:49:57 [+0100], Jiri Olsa wrote:
> > On Fri, Feb 21, 2020 at 06:44:19PM +0100, Sebastian Andrzej Siewior wrote:
> > > The migrate_disable counter should not exceed 255 so it is enough to
> > > store it in an 8bit field.
> > > With this change we can move the `preempt_lazy_count' member into the
> > > gap so the whole struct shrinks by 4 bytes to 12 bytes in total.
> > > 
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > >  include/linux/trace_events.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > > index f3b1ef07e4a5f..c8b3f06cb5ed7 100644
> > > --- a/include/linux/trace_events.h
> > > +++ b/include/linux/trace_events.h
> > > @@ -62,9 +62,9 @@ struct trace_entry {
> > >  	unsigned char		flags;
> > >  	unsigned char		preempt_count;
> > >  	int			pid;
> > > -	unsigned short		migrate_disable;
> > > -	unsigned short		padding;
> > > +	unsigned char		migrate_disable;
> > >  	unsigned char		preempt_lazy_count;
> > > +	unsigned short		padding;
> > 
> > also we still need to put preempt_lazy_count as common field:
> > 
> > 	__common_field(unsigned char,  preempt_lazy_count);
> 
> so I need to update the struct as I did (and drop the padding field like
> Steven suggested) and then do the "same" change to
> "trace_define_common_fields" ?

yep, AFAICS that's it

thanks,
jirka

