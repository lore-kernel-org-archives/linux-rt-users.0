Return-Path: <SRS0=TWee=3D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2F9C33CB1
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48D2222C4
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579015200;
	bh=tW0W0o9HBD84cD7ThOImD5YWeUnrGIajQQvx78FQ7Ro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=LV2EdMKq4DKKRSGkcCtPryOBq2b8ulWbt6w4MDHLUauW9iPY/b5nD+Etih2wEyaHt
	 /0Fl0Imv/05HNpvgdOberIhnF1RQBKpm/njk9XsofY4F2UhK4iJpqzxdPFZhs5jdPo
	 881gersaOAZR+01bituXsaVa8nmFlvlTjIX1fiy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgANPT4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgANPT4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jan 2020 10:19:56 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E887B24681;
        Tue, 14 Jan 2020 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579015195;
        bh=tW0W0o9HBD84cD7ThOImD5YWeUnrGIajQQvx78FQ7Ro=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ejGNkjej6UTgipnp5pz3NiRGjiYPhagQMQg4Bpurg5rLxarCfdnJzDH/1DFDxVz6e
         GUzH57FuTBgrkXemI8VYD1boaA/MbQfG3EiDSkS5oZi0gOaM5mR4jp4anoQTKA5p8M
         vg8y9Oo1YAfRPYuvK3ptaBypVDzdKAiVfor2IzQQ=
Message-ID: <1579015193.31031.12.camel@kernel.org>
Subject: Re: [PATCH v2 04/12] tracing: Add dynamic event command creation
 interface
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Tue, 14 Jan 2020 09:19:53 -0600
In-Reply-To: <20200114211420.71aae80cc4bdc7466960697d@kernel.org>
References: <cover.1578688120.git.zanussi@kernel.org>
         <b10d5656847c54c51b1496319e0da2764e660458.1578688120.git.zanussi@kernel.org>
         <20200114211420.71aae80cc4bdc7466960697d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Masami,

On Tue, 2020-01-14 at 21:14 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> Would you have any reason to export these raw interface to modules?
> (add_dynevent_arg() and add_dynevent_arg_pair())
> 
> I'm OK to export wrapped interfaces, but I can't find any good reason
> to export these raw interfaces. Especially since the argument format
> has been defined by each event type (synthetic, kprobe and uprobe),
> so modules may not be able to add new one...
> 

I didn't have a strong reason to export them, other than I thought they
might come in handy for some user at some point.  But you make some
good points, and I'm fine with assuming that only the wrapped
interfaces are what we care about.  I'll unexport them in the next
revision.

Thanks,

Tom

> Thank you,
> 
> On Fri, 10 Jan 2020 14:35:10 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Add an interface used to build up dynamic event creation commands,
> > such as synthetic and kprobe events.  Interfaces specific to those
> > particular types of events and others can be built on top of this
> > interface.
> > 
> > Command creation is started by first using the dynevent_cmd_init()
> > function to initialize the dynevent_cmd object.  Following that,
> > args
> > are appended and optionally checked by the add_dynevent_arg() and
> > add_dynevent_arg_pair() functions, which use objects representing
> > arguments and pairs of arguments, initialized respectively by
> > dynevent_arg_init() and dynevent_arg_pair_init().  Finally, once
> > all
> > args have been successfully added, the command is finalized and
> > actually created using create_dynevent().
> > 
> > The code here for actually printing into the dyn_event->cmd buffer
> > using snprintf() etc was adapted from v4 of Masami's 'tracing/boot:
> > Add synthetic event support' patch.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  include/linux/trace_events.h |  54 +++++++++++
> >  kernel/trace/trace_events.c  | 217
> > +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 271 insertions(+)
> > 
> > diff --git a/include/linux/trace_events.h
> > b/include/linux/trace_events.h
> > index c8038d1a1a48..bf4cc2e56125 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -353,6 +353,60 @@ extern struct trace_event_file
> > *get_event_file(const char *instance,
> >  					       const char *event);
> >  extern void put_event_file(struct trace_event_file *file);
> >  
> > +struct dynevent_cmd;
> > +
> > +typedef int (*dynevent_check_arg_fn_t)(void *data);
> > +typedef int (*dynevent_create_fn_t)(struct dynevent_cmd *cmd);
> > +
> > +struct dynevent_arg {
> > +	const char		*str;
> > +	char			separator; /* e.g. ';', ',',
> > or nothing */
> > +	dynevent_check_arg_fn_t	check_arg;
> > +};
> > +
> > +extern void dynevent_arg_init(struct dynevent_arg *arg,
> > +			      dynevent_check_arg_fn_t check_arg,
> > +			      char separator);
> > +extern int add_dynevent_arg(struct dynevent_cmd *cmd,
> > +			    struct dynevent_arg *arg);
> > +
> > +struct dynevent_arg_pair {
> > +	const char		*lhs;
> > +	const char		*rhs;
> > +	char			operator; /* e.g. '=' or
> > nothing */
> > +	char			separator; /* e.g. ';', ',',
> > or nothing */
> > +	dynevent_check_arg_fn_t	check_arg;
> > +};
> > +
> > +extern void dynevent_arg_pair_init(struct dynevent_arg_pair
> > *arg_pair,
> > +				   dynevent_check_arg_fn_t
> > check_arg,
> > +				   char operator, char separator);
> > +extern int add_dynevent_arg_pair(struct dynevent_cmd *cmd,
> > +				 struct dynevent_arg_pair
> > *arg_pair);
> > +
> > +#define MAX_DYNEVENT_CMD_LEN	(2048)
> > +
> > +enum dynevent_type {
> > +	DYNEVENT_TYPE_SYNTH,
> > +	DYNEVENT_TYPE_KPROBE,
> > +};
> > +
> > +struct dynevent_cmd {
> > +	char			*buf;
> > +	const char		*event_name;
> > +	int			maxlen;
> > +	int			remaining;
> > +	unsigned int		n_fields;
> > +	enum dynevent_type	type;
> > +	dynevent_create_fn_t	run_command;
> > +	void			*private_data;
> > +};
> > +
> > +extern void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf,
> > int maxlen,
> > +			      enum dynevent_type type,
> > +			      dynevent_create_fn_t run_command);
> > +extern int create_dynevent(struct dynevent_cmd *cmd);
> > +
> >  extern int delete_synth_event(const char *name);
> >  
> >  /*
> > diff --git a/kernel/trace/trace_events.c
> > b/kernel/trace/trace_events.c
> > index 184e10d3772d..751a2c887953 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -3301,6 +3301,223 @@ void __init trace_event_init(void)
> >  	event_trace_enable();
> >  }
> >  
> > +/**
> > + * add_dynevent_arg - Add an arg to a dynevent_cmd
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
> > +int add_dynevent_arg(struct dynevent_cmd *cmd,
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
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(add_dynevent_arg);
> > +
> > +/**
> > + * add_dynevent_arg_pair - Add an arg pair to a dynevent_cmd
> > + * @cmd: A pointer to the dynevent_cmd struct representing the new
> > event cmd
> > + * @arg_pair: The argument pair to append to the current cmd
> > + *
> > + * Append an argument pair to a dynevent_cmd.  An argument pair
> > + * consists of a left-hand-side argument and a right-hand-side
> > + * argument separated by an operator, which can be whitespace, all
> > + * followed by a separator, if applicable.  This can be used to
> > add
> > + * arguments of the form 'type variable_name;' or 'x+y'.
> > + *
> > + * The lhs argument string will be appended to the current cmd
> > string,
> > + * followed by an operator, if applicable, followd by the rhs
> > string,
> > + * followed finally by a separator, if applicable.  Before
> > anything is
> > + * added, the check_arg() function, if defined, is called.
> > + *
> > + * The cmd strings, operator, separator, and check_arg() function
> > + * should be set using the dynevent_arg_init() before any
> > arguments
> > + * are added using this function.
> > + *
> > + * Return: 0 if successful, error otherwise.
> > + */
> > +int add_dynevent_arg_pair(struct dynevent_cmd *cmd,
> > +			  struct dynevent_arg_pair *arg_pair)
> > +{
> > +	int ret = 0;
> > +	int delta;
> > +	char *q;
> > +
> > +	if (arg_pair->check_arg) {
> > +		ret = arg_pair->check_arg(arg_pair);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	q = cmd->buf + (cmd->maxlen - cmd->remaining);
> > +
> > +	delta = snprintf(q, cmd->remaining, " %s%c", arg_pair-
> > >lhs,
> > +			 arg_pair->operator);
> > +	if (delta >= cmd->remaining) {
> > +		pr_err("field string is too long: %s\n", arg_pair-
> > >lhs);
> > +		return -E2BIG;
> > +	}
> > +	cmd->remaining -= delta; q += delta;
> > +
> > +	delta = snprintf(q, cmd->remaining, "%s%c", arg_pair->rhs,
> > +			 arg_pair->separator);
> > +	if (delta >= cmd->remaining) {
> > +		pr_err("field string is too long: %s\n", arg_pair-
> > >rhs);
> > +		return -E2BIG;
> > +	}
> > +	cmd->remaining -= delta; q += delta;
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(add_dynevent_arg_pair);
> > +
> > +/**
> > + * dynevent_cmd_init - Initialize a dynevent_cmd object
> > + * @cmd: A pointer to the dynevent_cmd struct representing the cmd
> > + * @buf: A pointer to the buffer to generate the command into
> > + * @maxlen: The length of the buffer the command will be generated
> > into
> > + * @type: The type of the cmd, checked against further operations
> > + * @run_command: The type-specific function that will actually run
> > the command
> > + *
> > + * Initialize a dynevent_cmd.  A dynevent_cmd is used to build up
> > and
> > + * run dynamic event creation commands, such as commands for
> > creating
> > + * synthetic and kprobe events.  Before calling any of the
> > functions
> > + * used to build the command, a dynevent_cmd object should be
> > + * instantiated and initialized using this function.
> > + *
> > + * The initialization sets things up by saving a pointer to the
> > + * user-supplied buffer and its length via the @buf and @maxlen
> > + * params, and by saving the cmd-specific @type and @run_command
> > + * params which are used to check subsequent dynevent_cmd
> > operations
> > + * and actually run the command when complete.
> > + */
> > +void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int
> > maxlen,
> > +		       enum dynevent_type type,
> > +		       dynevent_create_fn_t run_command)
> > +{
> > +	memset(cmd, '\0', sizeof(*cmd));
> > +
> > +	cmd->buf = buf;
> > +	cmd->maxlen = maxlen;
> > +	cmd->remaining = cmd->maxlen;
> > +	cmd->type = type;
> > +	cmd->run_command = run_command;
> > +}
> > +EXPORT_SYMBOL_GPL(dynevent_cmd_init);
> > +
> > +/**
> > + * dynevent_arg_init - Initialize a dynevent_arg object
> > + * @arg: A pointer to the dynevent_arg struct representing the arg
> > + * @check_arg: An (optional) pointer to a function checking arg
> > sanity
> > + * @separator: An (optional) separator, appended after adding the
> > arg
> > + *
> > + * Initialize a dynevent_arg object.  A dynevent_arg represents an
> > + * object used to append single arguments to the current command
> > + * string.  The @check_arg function, if present, will be used to
> > check
> > + * the sanity of the current arg string (which is directly set by
> > the
> > + * caller).  After the arg string is successfully appended to the
> > + * command string, the optional @separator is appended.  If no
> > + * separator was specified when initializing the arg, a space will
> > be
> > + * appended.
> > + */
> > +void dynevent_arg_init(struct dynevent_arg *arg,
> > +		       dynevent_check_arg_fn_t check_arg,
> > +		       char separator)
> > +{
> > +	memset(arg, '\0', sizeof(*arg));
> > +
> > +	if (!separator)
> > +		separator = ' ';
> > +	arg->separator = separator;
> > +
> > +	arg->check_arg = check_arg;
> > +}
> > +EXPORT_SYMBOL_GPL(dynevent_arg_init);
> > +
> > +/**
> > + * dynevent_arg_pair_init - Initialize a dynevent_arg_pair object
> > + * @arg_pair: A pointer to the dynevent_arg_pair struct
> > representing the arg
> > + * @check_arg: An (optional) pointer to a function checking arg
> > sanity
> > + * @operator: An (optional) operator, appended after adding the
> > first arg
> > + * @separator: An (optional) separator, appended after adding the
> > second arg
> > + *
> > + * Initialize a dynevent_arg_pair object.  A dynevent_arg_pair
> > + * represents an object used to append argument pairs such as
> > 'type
> > + * variable_name;' or 'x+y' to the current command string.  An
> > + * argument pair consists of a left-hand-side argument and a
> > + * right-hand-side argument separated by an operator, which can be
> > + * whitespace, all followed by a separator, if applicable. The
> > + * @check_arg function, if present, will be used to check the
> > sanity
> > + * of the current arg strings (which is directly set by the
> > caller).
> > + * After the first arg string is successfully appended to the
> > command
> > + * string, the optional @operator is appended, followed by the
> > second
> > + * arg and and optional @separator.  If no separator was specified
> > + * when initializing the arg, a space will be appended.
> > + */
> > +void dynevent_arg_pair_init(struct dynevent_arg_pair *arg_pair,
> > +			    dynevent_check_arg_fn_t check_arg,
> > +			    char operator, char separator)
> > +{
> > +	memset(arg_pair, '\0', sizeof(*arg_pair));
> > +
> > +	if (!operator)
> > +		operator = ' ';
> > +	arg_pair->operator = operator;
> > +
> > +	if (!separator)
> > +		separator = ' ';
> > +	arg_pair->separator = separator;
> > +
> > +	arg_pair->check_arg = check_arg;
> > +}
> > +EXPORT_SYMBOL_GPL(dynevent_arg_pair_init);
> > +
> > +/**
> > + * create_dynevent - Create the dynamic event contained in
> > dynevent_cmd
> > + * @cmd: The dynevent_cmd object containing the dynamic event
> > creation command
> > + *
> > + * Once a dynevent_cmd object has been successfully built up via
> > the
> > + * dynevent_cmd_init(), add_dynevent_arg() and
> > add_dynevent_arg_pair()
> > + * functions, this function runs the final command to actually
> > create
> > + * the event.
> > + *
> > + * Return: 0 if the event was successfully created, error
> > otherwise.
> > + */
> > +int create_dynevent(struct dynevent_cmd *cmd)
> > +{
> > +	return cmd->run_command(cmd);
> > +}
> > +EXPORT_SYMBOL_GPL(create_dynevent);
> > +
> >  #ifdef CONFIG_EVENT_TRACE_STARTUP_TEST
> >  
> >  static DEFINE_SPINLOCK(test_spinlock);
> > -- 
> > 2.14.1
> > 
> 
> 
