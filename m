Return-Path: <SRS0=QF8V=3S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6D2C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 18:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4FB20716
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jan 2020 18:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgA2SAW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgA2SAW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 13:00:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8DC206D4;
        Wed, 29 Jan 2020 18:00:19 +0000 (UTC)
Date:   Wed, 29 Jan 2020 13:00:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH v3 04/12] tracing: Add dynamic event command creation
 interface
Message-ID: <20200129130018.230cef12@gandalf.local.home>
In-Reply-To: <4a38478f56b9e831803500f82af896bda92a5370.1579904761.git.zanussi@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
        <4a38478f56b9e831803500f82af896bda92a5370.1579904761.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 24 Jan 2020 16:56:15 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +/**
> + * dynevent_arg_add - Add an arg to a dynevent_cmd
> + * @cmd: A pointer to the dynevent_cmd struct representing the new event cmd
> + * @arg: The argument to append to the current cmd
> + *
> + * Append an argument to a dynevent_cmd.  The argument string will be
> + * appended to the current cmd string, followed by a separator, if
> + * applicable.  Before the argument is added, the check_arg()
> + * function, if defined, is called.
> + *
> + * The cmd string, separator, and check_arg() function should be set
> + * using the dynevent_arg_init() before any arguments are added using
> + * this function.
> + *
> + * Return: 0 if successful, error otherwise.
> + */
> +int dynevent_arg_add(struct dynevent_cmd *cmd,
> +		     struct dynevent_arg *arg)
> +{
> +	int ret = 0;
> +	int delta;
> +	char *q;
> +
> +	if (arg->check_arg) {
> +		ret = arg->check_arg(arg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	q = cmd->buf + (cmd->maxlen - cmd->remaining);
> +
> +	delta = snprintf(q, cmd->remaining, " %s%c", arg->str, arg->separator);
> +	if (delta >= cmd->remaining) {
> +		pr_err("String is too long: %s\n", arg->str);
> +		return -E2BIG;
> +	}
> +	cmd->remaining -= delta;

This looks like you can take advantage of the seq_buf code
(see /lib/seq_buf.c), as that handles a lot of this for you.

As I'm trying to get this into the merge window, I won't delay this for
that (unless I find something else to delay this for), but this should
definitely incorporate seq_buf and not handle its own buffering.

-- Steve



> +
> +	return ret;
> +}
