Return-Path: <SRS0=DFOT=3T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B05C35240
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jan 2020 02:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A154320716
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jan 2020 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580352036;
	bh=1kRFdhkVs1pnRQaGP9CAxOS7QE/HNXSDdU8d+YI+C4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nWBruvAPDI0LqEZO+wYopzebObQ2/ghpRaUuDrHTIr0p1441bu1ORkZuq4TQ27Tef
	 I/UehyuLDWCzrbVbjWyXqPQG2YuBIREEBkUIQgo3nIfzemt76PI7AfUIWwJxh1XGqN
	 9l4HNqjCU1Ja1r578krU/CEi4izWxCKU39XrSMyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgA3Cke (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgA3Ckd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jan 2020 21:40:33 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E432F206D5;
        Thu, 30 Jan 2020 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580352032;
        bh=1kRFdhkVs1pnRQaGP9CAxOS7QE/HNXSDdU8d+YI+C4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dxez+VKFAw1RUBWt+cFqzGD4z/WESnQtkxOWX1ObZgxVJF101/4DhBCFsuTPNnd8m
         DMDxA07HUAHYe7rCutAqYeImTR02UDq7ulfbLoiY6GWtAvL7V235Aa/7SPtwq7MPaq
         KD/z2KznrI0sHphjMLPYlVLAdCWALvAuKpb+SWJQ=
Date:   Thu, 30 Jan 2020 11:40:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 04/12] tracing: Add dynamic event command creation
 interface
Message-Id: <20200130114028.0c20b193cc3825363369794a@kernel.org>
In-Reply-To: <1f65fa44390b6f238f6036777c3784ced1dcc6a0.1580323897.git.zanussi@kernel.org>
References: <cover.1580323897.git.zanussi@kernel.org>
        <1f65fa44390b6f238f6036777c3784ced1dcc6a0.1580323897.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom

On Wed, 29 Jan 2020 12:59:24 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Add an interface used to build up dynamic event creation commands,
> such as synthetic and kprobe events.  Interfaces specific to those
> particular types of events and others can be built on top of this
> interface.
> 
> Command creation is started by first using the dynevent_cmd_init()
> function to initialize the dynevent_cmd object.  Following that, args
> are appended and optionally checked by the dynevent_arg_add() and
> dynevent_arg_pair_add() functions, which use objects representing
> arguments and pairs of arguments, initialized respectively by
> dynevent_arg_init() and dynevent_arg_pair_init().  Finally, once all
> args have been successfully added, the command is finalized and
> actually created using dynevent_create().
> 
> The code here for actually printing into the dyn_event->cmd buffer
> using snprintf() etc was adapted from v4 of Masami's 'tracing/boot:
> Add synthetic event support' patch.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  include/linux/trace_events.h  |  23 ++++
>  kernel/trace/trace_dynevent.c | 240 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_dynevent.h |  33 ++++++
>  3 files changed, 296 insertions(+)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 25fe743bcbaf..651b03d5e272 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -354,6 +354,29 @@ extern struct trace_event_file *trace_get_event_file(const char *instance,
>  						     const char *event);
>  extern void trace_put_event_file(struct trace_event_file *file);
>  
> +#define MAX_DYNEVENT_CMD_LEN	(2048)
> +
> +enum dynevent_type {
> +	DYNEVENT_TYPE_NONE,
> +};
> +
> +struct dynevent_cmd;
> +
> +typedef int (*dynevent_create_fn_t)(struct dynevent_cmd *cmd);
> +
> +struct dynevent_cmd {
> +	char			*buf;
> +	const char		*event_name;
> +	int			maxlen;
> +	int			remaining;
> +	unsigned int		n_fields;
> +	enum dynevent_type	type;
> +	dynevent_create_fn_t	run_command;
> +	void			*private_data;
> +};
> +
> +extern int dynevent_create(struct dynevent_cmd *cmd);
> +
>  extern int synth_event_delete(const char *name);
>  
>  /*
> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index 89779eb84a07..6ffdbc4fda53 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -223,3 +223,243 @@ static __init int init_dynamic_event(void)
>  	return 0;
>  }
>  fs_initcall(init_dynamic_event);
> +
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

Hmm, this seems a bit odd. The check_arg() arg object member check
the validity of the object itself. What about moving those checker
into dynevent_cmd instead of dynevent_arg?
(Or, just pass the appropriate checker as the 3rd parameter of
 this function)

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
> +
> +	return ret;
> +}
> +
> +/**
> + * dynevent_arg_pair_add - Add an arg pair to a dynevent_cmd
> + * @cmd: A pointer to the dynevent_cmd struct representing the new event cmd
> + * @arg_pair: The argument pair to append to the current cmd
> + *
> + * Append an argument pair to a dynevent_cmd.  An argument pair
> + * consists of a left-hand-side argument and a right-hand-side
> + * argument separated by an operator, which can be whitespace, all
> + * followed by a separator, if applicable.  This can be used to add
> + * arguments of the form 'type variable_name;' or 'x+y'.
> + *
> + * The lhs argument string will be appended to the current cmd string,
> + * followed by an operator, if applicable, followd by the rhs string,
> + * followed finally by a separator, if applicable.  Before anything is
> + * added, the check_arg() function, if defined, is called.
> + *
> + * The cmd strings, operator, separator, and check_arg() function
> + * should be set using the dynevent_arg_pair_init() before any arguments
> + * are added using this function.
> + *
> + * Return: 0 if successful, error otherwise.
> + */
> +int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
> +			  struct dynevent_arg_pair *arg_pair)
> +{
> +	int ret = 0;
> +	int delta;
> +	char *q;
> +
> +	if (arg_pair->check_arg) {
> +		ret = arg_pair->check_arg(arg_pair);

Ditto.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	q = cmd->buf + (cmd->maxlen - cmd->remaining);
> +
> +	delta = snprintf(q, cmd->remaining, " %s%c", arg_pair->lhs,
> +			 arg_pair->operator);
> +	if (delta >= cmd->remaining) {
> +		pr_err("field string is too long: %s\n", arg_pair->lhs);
> +		return -E2BIG;
> +	}
> +	cmd->remaining -= delta; q += delta;
> +
> +	delta = snprintf(q, cmd->remaining, "%s%c", arg_pair->rhs,
> +			 arg_pair->separator);
> +	if (delta >= cmd->remaining) {
> +		pr_err("field string is too long: %s\n", arg_pair->rhs);
> +		return -E2BIG;
> +	}
> +	cmd->remaining -= delta; q += delta;

Here, q += delta is redundant, because q is not used anymore.

> +
> +	return ret;
> +}
> +

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
