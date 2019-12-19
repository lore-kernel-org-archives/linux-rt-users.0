Return-Path: <SRS0=MKa8=2J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37EFC43603
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 16:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BD224650
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Dec 2019 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576772673;
	bh=zprs3MsAhkDCm5qTo4PhpgYdUo3cuMPRfp7uXJupRLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=U3jJzO5AbZPvp7dbFmiVMD50eHEL5DcRzvWoM6iaBc0woaV2OrKak0Aj648s+bhW3
	 J1dQwfUvvLpkZ5Z2CrP17IOTFcSxreBkzJaAJMeBLUc+a105wPB3a3pYrsCPcR0NKg
	 ZG3pHiFhWnQlwlMHz/IqU0ugo2H77msyCy2AfUuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLSQYa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfLSQY3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Dec 2019 11:24:29 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E39C24672;
        Thu, 19 Dec 2019 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576772668;
        bh=zprs3MsAhkDCm5qTo4PhpgYdUo3cuMPRfp7uXJupRLM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=atTfri11fYJdO91jCcT6CUbiMO8EKdsSgtwqqEEkXhCc1uN0O3rTFLvlMfxUw6pQv
         sxAPwfScfi39cHweBXY8XvLVcfthorSp68/hPYoial11ukIQ89UQsSNtL0k0rP0Ya3
         NBECl2oSN9dxlliqyg9nidLM5OJZneSp5vE8tlh0=
Message-ID: <1576772667.2236.17.camel@kernel.org>
Subject: Re: [PATCH 0/7] tracing: Add support for in-kernel synthetic event
 API
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Thu, 19 Dec 2019 10:24:27 -0600
In-Reply-To: <20191219234511.bb499b3d1590059506db6982@kernel.org>
References: <cover.1576679206.git.zanussi@kernel.org>
         <20191219234511.bb499b3d1590059506db6982@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Masami,

On Thu, 2019-12-19 at 23:45 +0900, Masami Hiramatsu wrote:
> Hello Tom,
> 
> On Wed, 18 Dec 2019 09:27:36 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi,
> > 
> > I've recently had several requests and suggestions from users to
> > add
> > support for the creation and generation of synthetic events from
> > kernel code such as modules, and not just from the available
> > command
> > line commands.
> 
> This reminds me my recent series of patches.
> 
> Could you use synth_event_run_command() for this purpose as I did
> in boot-time tracing series?
> 
> https://lkml.kernel.org/r/157528179955.22451.16317363776831311868.stg
> it@devnote2
> 
> Above example uses a command string as same as command string, but I
> think
> we can introduce some macros to construct the command string for
> easier
> definition.
> 
> Or maybe it is possible to pass the const char *args[] array to that
> API,
> instead of single char *cmd. (for dynamic event definiton)
> 
> Maybe we should consider more generic APIs for modules to
> create/delete
> dynamic-event including synthetic and probes, and those might reuse
> existing command parsers.
> 

I'll have to look at your patches more closely, but I think it should
be possible to generate the command string synth_event_run_command()
needs, or the equivalent const char *args[] array you mentioned, from
the higher-level event definition in my patches.

So the two ways of defining an event in my patches is 1) from a static
array known at build-time defined like this:

  static struct synth_field_desc synthtest_fields[] = {
       { .type = "pid_t",              .name = "next_pid_field" },
       { .type = "char[16]",           .name = "next_comm_field" },
       { .type = "u64",                .name = "ts_ns" },
       { .type = "u64",                .name = "ts_ms" },
       { .type = "unsigned int",       .name = "cpu" },
       { .type = "char[64]",           .name = "my_string_field" },
       { .type = "int",                .name = "my_int_field" },
  };

which is then passed to create_synth_event(&synthtest_fields)

or 2) at run-time by adding fields individually as they become known:

  add_synth_field("type", "name")

which requires some sort of start/end("event name").

I think that should all be possible using your patches, and maybe
generalizable to not just synth events by removing _synth_ from
everything?  Let me know what you think.  If that's correct, I can go
and rewrite the event creation part on top of your patches.

> > This patchset adds support for that.  The first three patches add
> > some
> > minor preliminary setup, followed by the two main patches that add
> > the
> > ability to create and generate synthetic events from the
> > kernel.  The
> > next patch adds a test module that demonstrates actual use of the
> > API
> > and verifies that it works as intended, followed by Documentation.
> 
> Could you also check the locks are correctly acquired? It seems that
> your APIs doesn't lock it.
> 

I did notice that I said that trace_types_lock and event_mutex should
be held for trace_array_find() but it should only be trace_types_lock,
and then I missed doing that in get_event_file() in one place.  And I
also don't really need the nolock versions, so will simplify and remove
them.  I think elsewhere event_mutex is taken where needed.  But if
talking about something else, please let me know.

Thanks,

Tom

> 
> Thank you,
> 
> 
