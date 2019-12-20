Return-Path: <SRS0=WSWX=2K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A30C43603
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6F82467F
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576859065;
	bh=m7XS3klLLKGRSgLn4ZlzP0EmInCP5ckCpZsLEOTdG40=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=uVg1Q1VR+6T/HjhUVCTFWLb32cZFEfzNnmocOf6zzItECC/1Pap3BLk9sjYbUxvAZ
	 YGTcx3jZUp27fHajEJZXfylvTCbRJq3xbluPm6o9ngVTb/z8/MLmyEpCf2xS0k9RBG
	 U8A5y5ZHBwdO9n4jhJkeMt9F1tjhUUHT2itxHq/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLTQYV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfLTQYV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Dec 2019 11:24:21 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F67222C2;
        Fri, 20 Dec 2019 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576859060;
        bh=m7XS3klLLKGRSgLn4ZlzP0EmInCP5ckCpZsLEOTdG40=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WHt2dd1gXp6tfRQfQgjcghALeI5tiRQPvzOhq0U3B8MQGynba6R8pIe5FVD+PuG9k
         pHXW3Y+9bmP23ozYx9qv5MTj9XIaoib5aTpPMIXmjWM0lnTeXgDs79ixD4ANgVnc7c
         McC68bYS3s8ZFxoqrk0y1Hue1HjmwO3na16ZiOv0=
Message-ID: <1576859058.4838.12.camel@kernel.org>
Subject: Re: [PATCH 0/7] tracing: Add support for in-kernel synthetic event
 API
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Fri, 20 Dec 2019 10:24:18 -0600
In-Reply-To: <20191220174142.34b4db9ba8f66e9385826e6b@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
         <20191219234511.bb499b3d1590059506db6982@kernel.org>
         <1576772667.2236.17.camel@kernel.org>
         <20191220174142.34b4db9ba8f66e9385826e6b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Masami,

On Fri, 2019-12-20 at 17:41 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Thu, 19 Dec 2019 10:24:27 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Masami,
> > 
> > On Thu, 2019-12-19 at 23:45 +0900, Masami Hiramatsu wrote:
> > > Hello Tom,
> > > 
> > > On Wed, 18 Dec 2019 09:27:36 -0600
> > > Tom Zanussi <zanussi@kernel.org> wrote:
> > > 
> > > > Hi,
> > > > 
> > > > I've recently had several requests and suggestions from users
> > > > to
> > > > add
> > > > support for the creation and generation of synthetic events
> > > > from
> > > > kernel code such as modules, and not just from the available
> > > > command
> > > > line commands.
> > > 
> > > This reminds me my recent series of patches.
> > > 
> > > Could you use synth_event_run_command() for this purpose as I did
> > > in boot-time tracing series?
> > > 
> > > https://lkml.kernel.org/r/157528179955.22451.16317363776831311868
> > > .stg
> > > it@devnote2
> > > 
> > > Above example uses a command string as same as command string,
> > > but I
> > > think
> > > we can introduce some macros to construct the command string for
> > > easier
> > > definition.
> > > 
> > > Or maybe it is possible to pass the const char *args[] array to
> > > that
> > > API,
> > > instead of single char *cmd. (for dynamic event definiton)
> > > 
> > > Maybe we should consider more generic APIs for modules to
> > > create/delete
> > > dynamic-event including synthetic and probes, and those might
> > > reuse
> > > existing command parsers.
> > > 
> > 
> > I'll have to look at your patches more closely, but I think it
> > should
> > be possible to generate the command string
> > synth_event_run_command()
> > needs, or the equivalent const char *args[] array you mentioned,
> > from
> > the higher-level event definition in my patches.
> 
> Agreed.
> 
> > 
> > So the two ways of defining an event in my patches is 1) from a
> > static
> > array known at build-time defined like this:
> > 
> >   static struct synth_field_desc synthtest_fields[] = {
> >        { .type = "pid_t",              .name = "next_pid_field" },
> >        { .type = "char[16]",           .name = "next_comm_field" },
> >        { .type = "u64",                .name = "ts_ns" },
> >        { .type = "u64",                .name = "ts_ms" },
> >        { .type = "unsigned int",       .name = "cpu" },
> >        { .type = "char[64]",           .name = "my_string_field" },
> >        { .type = "int",                .name = "my_int_field" },
> >   };
> > 
> > which is then passed to create_synth_event(&synthtest_fields)
> > 
> > or 2) at run-time by adding fields individually as they become
> > known:
> > 
> >   add_synth_field("type", "name")
> > 
> > which requires some sort of start/end("event name").
> 
> I think the 1) API seems a bit redundant IF we can expose the
> single comamnd string interface.
> 

It may be redundant, but I think it might be a preferred interface for
some users.  In any case, supporting 1) would just a simple matter of
providing a wrapper interface around your string interface.

> > I think that should all be possible using your patches, and maybe
> > generalizable to not just synth events by removing _synth_ from
> > everything?
> 
> If the implementation is enough generic, I think it is better to keep
> "synth" for better usability.
> 
> For example, if the API is just generating a command string,
> it would be easy to be reused by probe-events too.
> 
> ----
> struct dynevent_command {
>   char *cmd_buf;
>   enum dynevent_type type; /* Set by gen_*_cmd and checked on each
> API */
> };
> 
> int gen_synth_cmd(struct dynevent_command *, const char *name, ...);
> int add_synth_field(struct dynevent_command *, const char *type,
> const char *var);
> int gen_kprobe_cmd(struct dynevent_command *, const char *name, const
> char *loc, ....);
> int gen_kretprobe_cmd(struct dynevent_command *, const char *name,
> const char *loc, ....);
> int add_probe_fields(struct dynevent_command *, const char *field,
> ...);
> int create_dynevent(struct dynevent_command *);
> 
> struct dynevent_command cmd;
> 
> gen_synth_cmd(&cmd, "synthtest", "pid_t", "next_pid_field");
> add_synth_field(&cmd, "char[16]", "next_comm_field");
> ...
> create_dynevent(&cmd);
> 
> gen_kprobe_cmd(&cmd, "myprobe", "vfs_read+5", "%ax");
> add_probe_fields(&cmd, "%bx", "%dx");
> create_dynevent(&cmd);
> 
> gen_kretprobe_cmd(&cmd, "myretprobe", "vfs_write", "$retval");
> create_dynevent(&cmd);
> ----
> 
> Actually, these are just wrappers of type verifier & strcat() :P
> And it can provide similar user-experience and generic interface
> with simplar implementation.
> 

Good suggestions - I'll start implementing something like this and
rebase my patches on top of this.

> >  Let me know what you think.  If that's correct, I can go
> > and rewrite the event creation part on top of your patches.
> 
> No need to move onto my series. Mine focuses on tracing
> boot process, but your's are providing APIs for modules.
> 

OK, yeah I guess synth_event_run_command() et al are very simple.

Thanks,

Tom
