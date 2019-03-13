Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AE3C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 13:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42642183F
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552482239;
	bh=6pBFmBhRit/lXvLI6vi8fHZSx5zQ44s0Fq4INl6nWZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u1ExNSmfWWPY2JYN8PnTj0j1plf6Wzcd7TNscRaRBKdTTc8Ua19K+owtVunBs0X+a
	 GcQ+0CjxyMPBHpADle1UD1ZinKfGUIv2CVPqA2zUkRaxQiVr5EnQsmccrJO4u8Jhj2
	 Nqn4HjnoghsZeutZlm5KmHubwoRSKhS+v8M9NG4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfCMNDy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfCMNDy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 09:03:54 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323072177E;
        Wed, 13 Mar 2019 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552482233;
        bh=6pBFmBhRit/lXvLI6vi8fHZSx5zQ44s0Fq4INl6nWZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mxZb5skCI62g94dwxg8F6BmNTSczq8mINcNicl/p73EpO2e3xLx+StIN4ah6B19FM
         dstMZ5ckd+m2uie13hyiwCiHdFF1s8vxlUCx5A3huvlbEdmjWiGbSNnLPbP/3rYi70
         WFt+YICBXNTeAhxZjWc7WKDHnVHFCLp2XZ0nFdqg=
Date:   Wed, 13 Mar 2019 22:03:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] tracing: common error_log for ftrace
Message-Id: <20190313220348.d0481a0a5ad7de91e90dbadc@kernel.org>
In-Reply-To: <1552409351.4293.22.camel@kernel.org>
References: <cover.1551741458.git.tom.zanussi@linux.intel.com>
        <20190305230646.e7f99c46f86c0e099ac0cd30@kernel.org>
        <20190312152605.00150aae7b781137005e9ebf@kernel.org>
        <1552409351.4293.22.camel@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 12 Mar 2019 11:49:11 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Tue, 2019-03-12 at 15:26 +0900, Masami Hiramatsu wrote:
> > Hi Tom,
> > 
> > On Tue, 5 Mar 2019 23:06:46 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > On Mon,  4 Mar 2019 17:36:43 -0600
> > > > Changes from v2:
> > > > 
> > > >   - Added [n] numbering as suggested by Masami
> > 
> > Hmm, this seems a bit different what I suggested.
> > 
> > I'm trying to port probe event's error report on
> > your error log, and I found that the number is
> > just shifted as below.
> > 
> > When I filled the log with errors.
> > =============
> > /sys/kernel/debug/tracing # cat error_log 
> > [1] trace_kprobe: error: Invalid unsigned integer string
> >   Command: r10aa00:foo/bar vfs
> >             ^
> > ...
> > 
> > [7] trace_kprobe: error: Group name must follow C naming convention
> >   Command: p:a-b/bar vfs_read
> >              ^
> > [8] trace_kprobe: error: Event name is too long
> >   Command:
> > p:a/barrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
> > rrrrrrrrrrr vfs_read
> > =============
> > 
> > And do one more error, 
> > 
> > =============
> > /sys/kernel/debug/tracing # cat error_log 
> > [1] trace_kprobe: error: Maxactive is too big
> >   Command: r0xaa00:foo/bar vfs
> > 
> > ....
> > 
> > [7] trace_kprobe: error: Event name is too long
> >   Command:
> > p:a/barrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
> > rrrrrrrrrrr vfs_read
> >                ^
> > [8] trace_kprobe: error: Event name must follow C naming convention
> >   Command: p:a/bar.c vfs_read
> >                ^
> > =============
> > 
> > The number of logs are changed :(  This can confuse users.
> > I think it is better to keep the number as a unique number for
> > each entry as below.
> > 
> 
> Hmm, that makes sense, but I wonder if that will also confuse users,
> when the log wraps around and no longer starts at [1] and there's no
> way to retrieve the previous errors.

It is OK, that is same as dmesg. If user needs to keep watching it,
it should be dumped to disk by a daemon.

> 
> I took your suggestion as a way mainly to clearly delineate each error,
> since without the [number] or something similar, they all kind of run
> together.
> 
> Not sure what advantage numbering itself provides - would some other
> non-numbered separator work?

What about timestamp, similar to dmesg?

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
