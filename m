Return-Path: <SRS0=WSWX=2K=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6318DC2D0C0
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 08:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A6E20716
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Dec 2019 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576831312;
	bh=L533QNwMh74aZS7SvQ2sIdrQmds3Wye/rWgJoy5IiyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Pc9uHaIMsZXDE6/Qrhuh46jh/eIDxnU0b91ZYgZA+RJQ5G2gy3byNdpxnwra/K/3V
	 Nhbm37FwSzFo8QbrYi9+PagfxUWlNJ0hMYR1cGK+WODrapzU28f/P3wokE/zLMOCka
	 uNylEJF2SooHfCcLK5cl9TyhgvANX/Q5cLRAQmwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLTIls (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfLTIls (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Dec 2019 03:41:48 -0500
Received: from devnote2 (unknown [220.96.9.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91240206EC;
        Fri, 20 Dec 2019 08:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576831307;
        bh=L533QNwMh74aZS7SvQ2sIdrQmds3Wye/rWgJoy5IiyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YPxkxF5jR7HY0LeJOQvPRE2FJN/AksClfApEsiiVuPOakAyNiJ8QOjBB5Z569/oQD
         nASRWcQt588Xvuz611BZ26ilwRVpcfHiuH9c25LiXCKBLCa1d7SYBCCAedWOnTyl5B
         0fWjcRC31411XLRVa8tVCbBhZc2u0iiOpbbq7spo=
Date:   Fri, 20 Dec 2019 17:41:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/7] tracing: Add support for in-kernel synthetic event
 API
Message-Id: <20191220174142.34b4db9ba8f66e9385826e6b@kernel.org>
In-Reply-To: <1576772667.2236.17.camel@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
        <20191219234511.bb499b3d1590059506db6982@kernel.org>
        <1576772667.2236.17.camel@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On Thu, 19 Dec 2019 10:24:27 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Thu, 2019-12-19 at 23:45 +0900, Masami Hiramatsu wrote:
> > Hello Tom,
> > 
> > On Wed, 18 Dec 2019 09:27:36 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > Hi,
> > > 
> > > I've recently had several requests and suggestions from users to
> > > add
> > > support for the creation and generation of synthetic events from
> > > kernel code such as modules, and not just from the available
> > > command
> > > line commands.
> > 
> > This reminds me my recent series of patches.
> > 
> > Could you use synth_event_run_command() for this purpose as I did
> > in boot-time tracing series?
> > 
> > https://lkml.kernel.org/r/157528179955.22451.16317363776831311868.stg
> > it@devnote2
> > 
> > Above example uses a command string as same as command string, but I
> > think
> > we can introduce some macros to construct the command string for
> > easier
> > definition.
> > 
> > Or maybe it is possible to pass the const char *args[] array to that
> > API,
> > instead of single char *cmd. (for dynamic event definiton)
> > 
> > Maybe we should consider more generic APIs for modules to
> > create/delete
> > dynamic-event including synthetic and probes, and those might reuse
> > existing command parsers.
> > 
> 
> I'll have to look at your patches more closely, but I think it should
> be possible to generate the command string synth_event_run_command()
> needs, or the equivalent const char *args[] array you mentioned, from
> the higher-level event definition in my patches.

Agreed.

> 
> So the two ways of defining an event in my patches is 1) from a static
> array known at build-time defined like this:
> 
>   static struct synth_field_desc synthtest_fields[] = {
>        { .type = "pid_t",              .name = "next_pid_field" },
>        { .type = "char[16]",           .name = "next_comm_field" },
>        { .type = "u64",                .name = "ts_ns" },
>        { .type = "u64",                .name = "ts_ms" },
>        { .type = "unsigned int",       .name = "cpu" },
>        { .type = "char[64]",           .name = "my_string_field" },
>        { .type = "int",                .name = "my_int_field" },
>   };
> 
> which is then passed to create_synth_event(&synthtest_fields)
> 
> or 2) at run-time by adding fields individually as they become known:
> 
>   add_synth_field("type", "name")
> 
> which requires some sort of start/end("event name").

I think the 1) API seems a bit redundant IF we can expose the
single comamnd string interface.

> I think that should all be possible using your patches, and maybe
> generalizable to not just synth events by removing _synth_ from
> everything?

If the implementation is enough generic, I think it is better to keep
"synth" for better usability.

For example, if the API is just generating a command string,
it would be easy to be reused by probe-events too.

----
struct dynevent_command {
  char *cmd_buf;
  enum dynevent_type type; /* Set by gen_*_cmd and checked on each API */
};

int gen_synth_cmd(struct dynevent_command *, const char *name, ...);
int add_synth_field(struct dynevent_command *, const char *type, const char *var);
int gen_kprobe_cmd(struct dynevent_command *, const char *name, const char *loc, ....);
int gen_kretprobe_cmd(struct dynevent_command *, const char *name, const char *loc, ....);
int add_probe_fields(struct dynevent_command *, const char *field, ...);
int create_dynevent(struct dynevent_command *);

struct dynevent_command cmd;

gen_synth_cmd(&cmd, "synthtest", "pid_t", "next_pid_field");
add_synth_field(&cmd, "char[16]", "next_comm_field");
...
create_dynevent(&cmd);

gen_kprobe_cmd(&cmd, "myprobe", "vfs_read+5", "%ax");
add_probe_fields(&cmd, "%bx", "%dx");
create_dynevent(&cmd);

gen_kretprobe_cmd(&cmd, "myretprobe", "vfs_write", "$retval");
create_dynevent(&cmd);
----

Actually, these are just wrappers of type verifier & strcat() :P
And it can provide similar user-experience and generic interface
with simplar implementation.

>  Let me know what you think.  If that's correct, I can go
> and rewrite the event creation part on top of your patches.

No need to move onto my series. Mine focuses on tracing
boot process, but your's are providing APIs for modules.

> > > This patchset adds support for that.  The first three patches add
> > > some
> > > minor preliminary setup, followed by the two main patches that add
> > > the
> > > ability to create and generate synthetic events from the
> > > kernel.  The
> > > next patch adds a test module that demonstrates actual use of the
> > > API
> > > and verifies that it works as intended, followed by Documentation.
> > 
> > Could you also check the locks are correctly acquired? It seems that
> > your APIs doesn't lock it.
> > 
> 
> I did notice that I said that trace_types_lock and event_mutex should
> be held for trace_array_find() but it should only be trace_types_lock,
> and then I missed doing that in get_event_file() in one place.  And I
> also don't really need the nolock versions, so will simplify and remove
> them.  I think elsewhere event_mutex is taken where needed.  But if
> talking about something else, please let me know.

Yes, that is what I found.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
