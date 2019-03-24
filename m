Return-Path: <SRS0=fj9P=R3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE29C43381
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Mar 2019 10:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C22222D1
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Mar 2019 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553422295;
	bh=fTY6ByfBDjTqTC0vO4fhTB4xlWJtyXhHJRuBJjcij3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=U3KirEKXE6T6V8uIqr4sAZzGu2ZgAagT0ywKA0S7TcfuLS4kW/zGpNlhOTKhloVgk
	 or1JX8rsJGJuxZHYIOyXVUTrMWc+gpLMjWhHk+lxKnXp7LheCJgPbiOLumHNZtujaB
	 GBE3OlxtKOXfVHae+Y3maZzEWWxSD4fGMYb7i4qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfCXKL1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 24 Mar 2019 06:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfCXKL1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 24 Mar 2019 06:11:27 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B26222D0;
        Sun, 24 Mar 2019 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553422286;
        bh=fTY6ByfBDjTqTC0vO4fhTB4xlWJtyXhHJRuBJjcij3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lQFZjSc6AcJHEiDU3ytZBZa7EH+x/H4oqldi8e0n/7sV3m/H43EqLpZ66SGWY4LMd
         cEoXICGQrLym6wBM4V8Aw1oy1wvm7bwG480CxyWTuOILESeY2WXgdyO4z/00jh7wni
         6sxIESaKdBRT8Kk6iCrnrUdjzzpjdWHwV5Ji51zk=
Date:   Sun, 24 Mar 2019 19:11:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 06/11] selftests/ftrace: Add error_log testcase for
 probe errors
Message-Id: <20190324191121.16b130a0c92ea1a8ff35194c@kernel.org>
In-Reply-To: <1553346669.2307.8.camel@kernel.org>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
        <c620157fa19f9df4ebf33e3e138c1234a4b5def7.1553268040.git.tom.zanussi@linux.intel.com>
        <20190323192234.7884a15d9fab262ef70d3cab@kernel.org>
        <1553346669.2307.8.camel@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 23 Mar 2019 08:11:09 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Sat, 2019-03-23 at 19:22 +0900, Masami Hiramatsu wrote:
> > On Fri, 22 Mar 2019 10:34:32 -0500
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Add error_log testcase for error logs on probe events.
> > > This tests most of error cases and checks the error position
> > > is correct.
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   | 93
> > > ++++++++++++++++++++++
> > >  .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   | 31 ++++++++
> > >  2 files changed, 124 insertions(+)
> > >  create mode 100644
> > > tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.t
> > > c
> > >  create mode 100644
> > > tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.t
> > > c
> > > 
> > > diff --git
> > > a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors
> > > .tc
> > > b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors
> > > .tc
> > > new file mode 100644
> > > index 000000000000..281665b1348c
> > > --- /dev/null
> > > +++
> > > b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors
> > > .tc
> > > @@ -0,0 +1,93 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# description: Kprobe event parser error log check
> > > +
> > > +[ -f kprobe_events ] || exit_unsupported # this is configurable
> > > +
> > > +[ -f error_log ] || exit_unsupported
> > > +
> > > +check_error() { # command-with-error-pos-by-^
> > > +pos=$(echo -n "${1%^*}" | wc -c) # error position
> > > +command=$(echo "$1" | tr -d ^)
> > > +echo "Test command: $command"
> > > +echo > error_log
> > > +(! echo "$command" > kprobe_events ) >& /dev/null
> > 
> > Oops, this one. This must be
> > 
> > (! echo "$command" > kprobe_events ) > /dev/null 2>&1
> > 
> > [...]
> > > diff --git
> > > a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors
> > > .tc
> > > b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors
> > > .tc
> > > new file mode 100644
> > > index 000000000000..957011300bb7
> > > --- /dev/null
> > > +++
> > > b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors
> > > .tc
> > > @@ -0,0 +1,31 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# description: Uprobe event parser error log check
> > > +
> > > +[ -f uprobe_events ] || exit_unsupported # this is configurable
> > > +
> > > +[ -f error_log ] || exit_unsupported
> > > +
> > > +check_error() { # command-with-error-pos-by-^
> > > +pos=$(echo -n "${1%^*}" | wc -c) # error position
> > > +command=$(echo "$1" | tr -d ^)
> > > +echo "Test command: $command"
> > > +echo > error_log
> > > +(! echo "$command" > uprobe_events ) >& /dev/null
> > 
> > Here too.
> > 
> > Tom, if you don't mind, could you update it when you update
> > the series? Or should I resend it?
> > 
> 
> I can just change it in the next update.  I assume 2> as in the other
> patch?

Yes, that is better, since stdout goes to [ku]probe_event file.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
