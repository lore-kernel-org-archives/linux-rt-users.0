Return-Path: <SRS0=QguH=3K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C24C2D0CE
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jan 2020 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9512465A
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Jan 2020 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579634426;
	bh=lpKOGmf37IZ9e6kBsCphLahpjYOCoibPrMeilGiefw4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=nl761sokcUqSyXpUO+JDs2MSXuC2tt+I54XgJx98St1rDVQcBMY6DhB48F3q85sxi
	 7XKCi7E3M8ppwFMY3nQAbkMQ8Y37IkJbo4Ha+NN2NQSZwNhZluuoSphw/myOka6dK3
	 Nfkz2NGgrJiMiL+hUKhd4LBulpkWDVQbaH7LyFLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAUTUX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgAUTUX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Jan 2020 14:20:23 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B2D621835;
        Tue, 21 Jan 2020 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579634422;
        bh=lpKOGmf37IZ9e6kBsCphLahpjYOCoibPrMeilGiefw4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=1G7sQylnpwG0YbJCu3/TwJmQFNfc3oRSpI9aryUIo/6RbrzA09IZTbGEe7vwYrCnf
         ONI3AVP8jd+yTjvMsfXu+rOWeE/oZoiLaf7ZRMmPbhHc/0JGgwXJxcjvB+zw1Vz9x/
         HInZKvfNAeytRZqHHUZXtbQXicTJ3yrhplvmkgbg=
Message-ID: <1579634420.19595.1.camel@kernel.org>
Subject: Re: [PATCH v2 06/12] tracing: Add synthetic event command
 generation functions
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Tue, 21 Jan 2020 13:20:20 -0600
In-Reply-To: <20200121115754.01efcdfd@gandalf.local.home>
References: <cover.1578688120.git.zanussi@kernel.org>
         <c731007e4b528f8bcd40d2864979597bd5d91183.1578688120.git.zanussi@kernel.org>
         <20200121115754.01efcdfd@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Tue, 2020-01-21 at 11:57 -0500, Steven Rostedt wrote:
> On Fri, 10 Jan 2020 14:35:12 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Add functions used to generate synthetic event commands, built on
> > top
> > of the dynevent_cmd interface.
> > 
> > gen_synth_cmd() is used to create a synthetic event command using a
> > variable arg list and gen_synth_cmd_array() does the same thing but
> > using an array of field descriptors.  add_synth_field() and
> > add_synth_fields() can be used to add single fields one by one or
> > as a
> > group.  Once all desired fields are added, create_dynevent() is
> > used
> > to actually execute the command and create the event.
> > 
> > create_synth_event() does everything, including creating the event,
> > in
> > a single call.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  include/linux/trace_events.h     |  30 ++++
> >  kernel/trace/trace_events_hist.c | 325
> > ++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 352 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/trace_events.h
> > b/include/linux/trace_events.h
> > index bf4cc2e56125..4228407d4736 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -409,6 +409,36 @@ extern int create_dynevent(struct dynevent_cmd
> > *cmd);
> >  
> >  extern int delete_synth_event(const char *name);
> >  
> > +extern void synth_dynevent_cmd_init(struct dynevent_cmd *cmd,
> > +				    char *buf, int maxlen);
> > +
> > +extern int __gen_synth_cmd(struct dynevent_cmd *cmd, const char
> > *name,
> > +			   struct module *mod, ...);
> > +
> > +#define gen_synth_cmd(cmd, name, mod, ...)	\
> > +	__gen_synth_cmd(cmd, name, mod, ## __VA_ARGS__, NULL)
> > +
> > +struct synth_field_desc {
> > +	const char *type;
> > +	const char *name;
> > +};
> > +
> > +extern int gen_synth_cmd_array(struct dynevent_cmd *cmd, const
> > char *name,
> > +			       struct module *mod,
> > +			       struct synth_field_desc *fields,
> > +			       unsigned int n_fields);
> > +extern int create_synth_event(const char *name,
> > +			      struct synth_field_desc *fields,
> > +			      unsigned int n_fields, struct module
> > *mod);
> > +
> > +
> > +extern int add_synth_field(struct dynevent_cmd *cmd,
> > +			   const char *type,
> > +			   const char *name);
> > +extern int add_synth_fields(struct dynevent_cmd *cmd,
> > +			    struct synth_field_desc *fields,
> > +			    unsigned int n_fields);
> 
> As these are in a global header and globally visible, let's rename
> them
> to be more name space aware.
> 
> Have them all start with "synth_event_".
> 
> synth_event_gen_cmd_array()
> synth_event_create()
> synth_event_add_field()
> synth_event_add_fields()
> 
> Makes it easier to grep for synth_event functions too.
> 

OK, will do.

Thanks,

Tom

> -- Steve
> 
> 
> > +
> >  /*
> >   * Event file flags:
> >   *  ENABLED	  - The event is enabled
