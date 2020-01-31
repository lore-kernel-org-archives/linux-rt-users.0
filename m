Return-Path: <SRS0=6AJS=3U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA9C33CB7
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 22:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B79215A4
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 22:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580510863;
	bh=0Pf6i2khIV85HbGrfACIhnMSzQ1NQGd9xPeAxr6J8BU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=KFUJCSWZwmn0rBfwXMKrEhhCc0mbuzoJ6yZFpn16JCdv8e9FOgzjSIhrvLNLjI883
	 v5GEXNPUSs535BRsFOnvpTer8S6cgYbOFUVKEPcfORW87qM7k+pkcca7iYHRRQdHPl
	 qYg2hzqMvICfZ9ZTPyIt7RahSGWqhXyA5ZCCErK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgAaWrk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgAaWrk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Jan 2020 17:47:40 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 831F6214D8;
        Fri, 31 Jan 2020 22:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580510860;
        bh=0Pf6i2khIV85HbGrfACIhnMSzQ1NQGd9xPeAxr6J8BU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sF8DXSnBZG3V51wTV6v0DLfjKnnv5+esszA+ZgSgrfNM6CnYAKXkNGnpWCLGArpuh
         5NVsygP6X6NCw+qKQohSpqiZymytVz2C5tpU85egQsccws+OkI4ZNytXqXrVedheOi
         yqqDBsbdZQLQN9J4vCpAhuGv+Tufioymd9XiicRc=
Message-ID: <1580510858.5607.0.camel@kernel.org>
Subject: Re: [PATCH 1/4] tracing: Consolidate some synth_event_trace code
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Fri, 31 Jan 2020 16:47:38 -0600
In-Reply-To: <20200131174344.5606d154@gandalf.local.home>
References: <cover.1580506712.git.zanussi@kernel.org>
         <d1c8d8ad124a653b7543afe801d38c199ca5c20e.1580506712.git.zanussi@kernel.org>
         <20200131174344.5606d154@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Fri, 2020-01-31 at 17:43 -0500, Steven Rostedt wrote:
> On Fri, 31 Jan 2020 15:55:31 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -2053,24 +2053,72 @@ int synth_event_trace_start(struct
> > trace_event_file *file,
> >  }
> >  EXPORT_SYMBOL_GPL(synth_event_trace_start);
> >  
> > -static int save_synth_val(struct synth_field *field, u64 val,
> > +int __synth_event_add_val(const char *field_name, u64 val,
> 
> Hmm, shouldn't __synth_event_add_val() still be static?
> 

It's a new function, but yeah, it should be static.

Tom

> -- Steve
> 
> >  			  struct synth_event_trace_state
> > *trace_state)
> >  {
> > -	struct synth_trace_event *entry = trace_state->entry;
> > +	struct synth_field *field = NULL;
> > +	struct synth_trace_event *entry;
> > +	struct synth_event *event;
> > +	int i, ret = 0;
> > +
