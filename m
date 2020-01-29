Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EBDC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C0820716
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 19:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324575;
	bh=QQLziFiL8YYCmRpFavz8eyI/YvvOY3R1GJH7XOORQCE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=az9QlgCvn8VviS7PfObPtdWp71Z+/jiREgkh/iDHBdG7B67bgjPpGI2eRPTsiatdY
	 WT+UHUVP+99g4+y26R71hsKHfYOZd4m09JNctXbUmPs3j5h+FI4S3SAMl2yvVtnbmO
	 ur4TC1DWfrulx0ApCxTdJZJYxQBGvcBoWtVlZ8LY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgA2TCz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgA2TCy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 14:02:54 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9363206D4;
        Wed, 29 Jan 2020 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324574;
        bh=QQLziFiL8YYCmRpFavz8eyI/YvvOY3R1GJH7XOORQCE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MMDhW4eDkXXPkbNXPZ1hh572XtFxMrTeanOOPcD/1dtw0swimQklT3dapRGm7MggR
         Qmri/RBJ71/DuiZ/U3d1qv4Hn+gmm7RoRgxOXazWOyNaQ57+f3wIVIgfaeRRczXlC5
         6ZqGOSrnHNMqD3o4c2UioizzaljpuqSvfQXasjjc=
Message-ID: <1580324572.2757.2.camel@kernel.org>
Subject: Re: [PATCH v3 04/12] tracing: Add dynamic event command creation
 interface
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Date:   Wed, 29 Jan 2020 13:02:52 -0600
In-Reply-To: <20200129130018.230cef12@gandalf.local.home>
References: <cover.1579904761.git.zanussi@kernel.org>
         <4a38478f56b9e831803500f82af896bda92a5370.1579904761.git.zanussi@kernel.org>
         <20200129130018.230cef12@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Wed, 2020-01-29 at 13:00 -0500, Steven Rostedt wrote:
> On Fri, 24 Jan 2020 16:56:15 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > +/**
> > + * dynevent_arg_add - Add an arg to a dynevent_cmd
> > + * @cmd: A pointer to the dynevent_cmd struct representing the new
> > event cmd
> > + * @arg: The argument to append to the current cmd
> > + *
> > + * Append an argument to a dynevent_cmd.  The argument string will
> > be
> > + * appended to the current cmd string, followed by a separator, if
> > + * applicable.  Before the argument is added, the check_arg()
> > + * function, if defined, is called.
> > + *
> > + * The cmd string, separator, and check_arg() function should be
> > set
> > + * using the dynevent_arg_init() before any arguments are added
> > using
> > + * this function.
> > + *
> > + * Return: 0 if successful, error otherwise.
> > + */
> > +int dynevent_arg_add(struct dynevent_cmd *cmd,
> > +		     struct dynevent_arg *arg)
> > +{
> > +	int ret = 0;
> > +	int delta;
> > +	char *q;
> > +
> > +	if (arg->check_arg) {
> > +		ret = arg->check_arg(arg);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	q = cmd->buf + (cmd->maxlen - cmd->remaining);
> > +
> > +	delta = snprintf(q, cmd->remaining, " %s%c", arg->str,
> > arg->separator);
> > +	if (delta >= cmd->remaining) {
> > +		pr_err("String is too long: %s\n", arg->str);
> > +		return -E2BIG;
> > +	}
> > +	cmd->remaining -= delta;
> 
> This looks like you can take advantage of the seq_buf code
> (see /lib/seq_buf.c), as that handles a lot of this for you.
> 
> As I'm trying to get this into the merge window, I won't delay this
> for
> that (unless I find something else to delay this for), but this
> should
> definitely incorporate seq_buf and not handle its own buffering.
> 

OK, I can send a follow-on patch that does this.

Note that I just sent a v4 series which moves most of the code in this
patch to trace_dynevent.{c,h} as requested by Masami.  No other changes
from v3 were made other than adding acks.

Thanks,

Tom  


> -- Steve
> 
> 
> 
> > +
> > +	return ret;
> > +}
