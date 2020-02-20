Return-Path: <SRS0=oqvG=4I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07DDC11D1B
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6AC206F4
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582228319;
	bh=inbcbcpwi5tQ6Mt2SNqbNgb0gw+R9VogWJuC9bHVY+I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=0momrQ4QrM1CHlKeK81drkyNzpj4cIsTJKr2sUoUOlzkJQrgMV4XcQuwPwqr/fkPy
	 1xdv2C8m+pbpxFQKN+3SW65NT5c71ABdYALBfurO101W5tA3sHQJPofZMYuZ6iLJDf
	 f2c1MnNjWi6fFfvfOR6WNpcFeIdA0Xd/4KAwkv6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgBTTvu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgBTTvu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Feb 2020 14:51:50 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C490206E2;
        Thu, 20 Feb 2020 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582228309;
        bh=inbcbcpwi5tQ6Mt2SNqbNgb0gw+R9VogWJuC9bHVY+I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Kctczxrrh91HLKuFd73ECPF0UaWVGxACvyapJC0utBRhBKmwF00G3MRGwh8cG3NyR
         OraqzAzXWRLA5KRXpovUYbuvHhCCCZ/OhurXeNCcfTAeHzTeyE33Ejzw4hRl622KL3
         7oV0yBI93zaJuVSPfy78Zd0zymxd9t0WKAOx8ETc=
Message-ID: <1582228308.12738.1.camel@kernel.org>
Subject: Re: [PATCH] tracing: Skip software disabled event at
 __synth_event_trace_end()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Thu, 20 Feb 2020 13:51:48 -0600
In-Reply-To: <20200220143412.65432e7c@gandalf.local.home>
References: <158148685911.20407.3538292497442671878.stgit@devnote2>
         <20200217183340.121fed47e680584c4ca6dd93@kernel.org>
         <20200220143412.65432e7c@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Thu, 2020-02-20 at 14:34 -0500, Steven Rostedt wrote:
> On Mon, 17 Feb 2020 18:33:40 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > >  static inline void
> > >  __synth_event_trace_end(struct synth_event_trace_state
> > > *trace_state)
> > >  {
> > > +	if (trace_state->disabled)
> > > +		return;
> > > +  
> > 
> > Aah, I assumed that trace_state should be initialized with 0, but
> > in really, it could be just allocated on the stack.
> > We has to set trace_state->disabled = false in
> > __synth_event_trace_start().
> 
> Is this patch good enough to take, or is there another one coming?
> 

I think this patch is good to take.  The fix for setting trace_state-
>disabled to false would be covered by this later patch:

  [PATCH 2/2] tracing: Clear trace_state when starting trace

https://lore.kernel.org/lkml/158193315899.8868.1781259176894639952.stgit@devnote2/

Tom

> -- Steve
