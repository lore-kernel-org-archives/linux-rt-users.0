Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9B2C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 22:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821DE20716
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 22:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580338731;
	bh=T3ZG+BiFMo6X7F4+jiwlj/otBc6uDqUqE9kwYeVeogQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=eNLJ9C9HY2HgzB4QjYiannH0Vg2jeGuGn8Ce5g+5/NVLI6PajsLFsOXydpBlFXsQu
	 tVC3KV+mhk984V0I4tXk4oPAVn8sx+bZGLfYX5XtNLJdllVsDQvPt442me//nC48Zy
	 ZLQQgWY9uDaVKG+fwGSOX8k7JqwiCGRzj/6pkTnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgA2W6q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgA2W6q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 17:58:46 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E8420702;
        Wed, 29 Jan 2020 22:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580338726;
        bh=T3ZG+BiFMo6X7F4+jiwlj/otBc6uDqUqE9kwYeVeogQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JbArocdkkzakNRvU7e9D+tEBjc1CD+P6/+BPG8qHySpNKI6tqV3tLDjuxkYxcAKpV
         9GfSAGchQ2jliDY/8OBghdSj+wLfiJGXhtjRQcJfFJOCgwJZoaOrk9jdgXwAszQzKR
         S5I+2AoOz/gg8bieM1xKPjqzov8beD7zj26G+0wY=
Message-ID: <1580338724.6220.17.camel@kernel.org>
Subject: Re: [PATCH v4 07/12] tracing: Add synth_event_trace() and related
 functions
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Wed, 29 Jan 2020 16:58:44 -0600
In-Reply-To: <20200129160915.4ebe0f08@gandalf.local.home>
References: <cover.1580323897.git.zanussi@kernel.org>
         <7a84de5f1854acf4144b57efe835ca645afa764f.1580323897.git.zanussi@kernel.org>
         <20200129160915.4ebe0f08@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Wed, 2020-01-29 at 16:09 -0500, Steven Rostedt wrote:
> On Wed, 29 Jan 2020 12:59:27 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > +static struct synth_field *find_synth_field(struct synth_event
> > *event,
> > +					    const char
> > *field_name)
> > +{
> > +	struct synth_field *field = NULL;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < event->n_fields; i++) {
> > +		field = event->fields[i];
> > +		if (strcmp(field->name, field_name) == 0)
> > +			return field;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> Why duplicate all theses functions and not use them in the
> synth_event_trace() directly?
> 

Yes, find_synth_field() is used only once and is short, so I can just
add that into synth_event_add_val() directly.  And looking at
synth_event_add_val() and synth_event_add_next_val(), they're almost
identical and so can be made into a single function with a param for
the different parts (but still need to be exported separately so they
can be used with the piecewise API).

It would also be possible to have synth_event_trace() and
synth_event_trace_array() use synth_event_add_next_val() instead of
writing the fields directly but that would be more overhead for those
functions, which is why I avoided doing that.

Let me know if it's something else you're referring to, or if you want
me to do a v5 or a follow-on patch to do the first part above.

Thanks,

Tom

> -- Steve
