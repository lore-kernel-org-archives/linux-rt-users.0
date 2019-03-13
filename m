Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75420C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437302146E
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552508112;
	bh=j5OUZFoSXRITy87q/qwgDKqVDBBqBzqeAy0BpiIzXvI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=fpbInOA8HbFAaYaefr/xFGNwe8TAYB/BHzofa+uq95YhQi5Ke4R4r2MLyNROvn2aF
	 g7jf2xRTiH4uh4uF4ndIGZWfigXx/0KZLZtMuY6ClqE/CMhDLfIiuetIEKL1//qVbs
	 wJOJTqSNwoznBeqSLWk0aPu2jTRJ1Qp6BYShklas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfCMUPI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfCMUPH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 16:15:07 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 337C920693;
        Wed, 13 Mar 2019 20:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552508106;
        bh=j5OUZFoSXRITy87q/qwgDKqVDBBqBzqeAy0BpiIzXvI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BzF63iBE39OoHtb3tFTblgH63veaxbqR8Pxgt1HkQSlPKebedkHR1Rn6jVzEGAmAb
         mmfAEqaCXluEscCw0yISAZrpxjZ6HeS2P+3WleMW5l3+2GE9taoUGZka9pD7zpxvMU
         uDOTBlJ89PLN0Sg21oLm7VLpjqgwDZinB9Wo1ubY=
Message-ID: <1552508104.4293.31.camel@kernel.org>
Subject: Re: [RFC PATCH 0/7] tracing: Use common error_log with probe events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org, bigeasy@linutronix.de,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 13 Mar 2019 15:15:04 -0500
In-Reply-To: <155248005229.10815.334731901778152247.stgit@devnote2>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Masami,

On Wed, 2019-03-13 at 21:27 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> Here is a series of patches which applies common error_log framework
> to
> probe events. While applying it, I found I missed to check some
> errors
> in parser. Also, I made a testcase for this feature (only for kprobe
> event side, please make your test for the hist errors too).

Yep, will update the hist errors case too.

> Thus I made this as a series which contains some bugfixes (a kind of
> hardening), cleanups, and a test besides of the main patch.
> 
> Please feel free to pick this series to your series. I think some
> bugfixes might be better to push Steve's urgent branch.
> Let's talk with Steve.
> 

Thanks for doing this!  I'll try them out and pick up anything Steve
doesn't.

Tom

> Oh, note that this series can be applied on your v3 series, except
> for [4/5] :)
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (7):
>       tracing/probe: Check maxactive error cases
>       tracing/probe: Check event name length correctly
>       tracing/probe: Check the size of argument name and body
>       tracing/probe: Check event/group naming rule at parsing
>       tracing/probe: Verify alloc_trace_*probe() result
>       tracing: Use tracing error_log with probe events
>       selftests/ftrace: Add error_log testcase for kprobe errors
> 
> 
>  kernel/trace/trace_kprobe.c                        |   90 ++++--
>  kernel/trace/trace_probe.c                         |  280
> +++++++++++++++-----
>  kernel/trace/trace_probe.h                         |   76 +++++
>  kernel/trace/trace_uprobe.c                        |   43 ++-
>  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   91 +++++++
>  5 files changed, 449 insertions(+), 131 deletions(-)
>  create mode 100644
> tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> 
> --
> Masami Hiramatsu <mhiramat@kernel.org>
