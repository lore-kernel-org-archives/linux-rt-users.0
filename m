Return-Path: <SRS0=oqvG=4I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F24C11D1B
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 19:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF63206F4
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 19:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgBTTyh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgBTTyg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Feb 2020 14:54:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5619206E2;
        Thu, 20 Feb 2020 19:54:35 +0000 (UTC)
Date:   Thu, 20 Feb 2020 14:54:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] tracing: Skip software disabled event at
 __synth_event_trace_end()
Message-ID: <20200220145433.38ea92c9@gandalf.local.home>
In-Reply-To: <1582228308.12738.1.camel@kernel.org>
References: <158148685911.20407.3538292497442671878.stgit@devnote2>
        <20200217183340.121fed47e680584c4ca6dd93@kernel.org>
        <20200220143412.65432e7c@gandalf.local.home>
        <1582228308.12738.1.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 20 Feb 2020 13:51:48 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> On Thu, 2020-02-20 at 14:34 -0500, Steven Rostedt wrote:
> > On Mon, 17 Feb 2020 18:33:40 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > >  static inline void
> > > >  __synth_event_trace_end(struct synth_event_trace_state
> > > > *trace_state)
> > > >  {
> > > > +	if (trace_state->disabled)
> > > > +		return;
> > > > +    
> > > 
> > > Aah, I assumed that trace_state should be initialized with 0, but
> > > in really, it could be just allocated on the stack.
> > > We has to set trace_state->disabled = false in
> > > __synth_event_trace_start().  
> > 
> > Is this patch good enough to take, or is there another one coming?
> >   
> 
> I think this patch is good to take.  The fix for setting trace_state-
> >disabled to false would be covered by this later patch:  
> 
>   [PATCH 2/2] tracing: Clear trace_state when starting trace
> 
> https://lore.kernel.org/lkml/158193315899.8868.1781259176894639952.stgit@devnote2/
> 

Thanks Tom for the info!

-- Steve
