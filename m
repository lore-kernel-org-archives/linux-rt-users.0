Return-Path: <SRS0=fwOa=AZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68147C433E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 01:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CADF21548
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 01:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGNBU5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgGNBU4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Jul 2020 21:20:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B26A206F0;
        Tue, 14 Jul 2020 01:20:56 +0000 (UTC)
Date:   Mon, 13 Jul 2020 21:20:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Itai Handler <itai.handler@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: aarch64 boot time increases with rt
Message-ID: <20200713212054.2e675557@oasis.local.home>
In-Reply-To: <CAFpOueS0rvys4Q81D3HEYX2U1vM808qQ4w+z6QxCWi1KJBGXXQ@mail.gmail.com>
References: <CAFpOueS0rvys4Q81D3HEYX2U1vM808qQ4w+z6QxCWi1KJBGXXQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 13 Jul 2020 17:56:05 +0300
Itai Handler <itai.handler@gmail.com> wrote:

> Hi,
> 
> I observed that aarch64 boot time increases considerably with rt
> (PREEMPT_RT_FULL=y).

You mean compared to non PREEMPT_RT_FULL of the same kernel?

> This is observable also in latest 4.19 rt (4.19.127-rt55).
> Following is a fragment from kernel log (with rt) which shows that
> bringing up 4 CPUs takes about 210 ms:

I'd suggest trying 5.4 or even 5.6-rt.

> 
> [    0.120951] smp: Bringing up secondary CPUs ...
> [    0.184860] Detected VIPT I-cache on CPU1
> [    0.187344] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
> [    0.262931] Detected VIPT I-cache on CPU2
> [    0.263390] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
> [    0.329296] Detected VIPT I-cache on CPU3
> [    0.329872] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
> [    0.331557] smp: Brought up 1 node, 4 CPUs
> 
> Note that these times are from qemu, however the problem is also
> noticeable on real hardware.
> 
> I traced the code and found that the slow down is caused in
> workqueue_prepare_cpu().
> This function creates the worker threads.
> 
> On real hardware, it takes about 8 ms to create each worker thread.
> Before digging into it in more detail, I would like to hear your opinion.
> 
> Steven, what ftrace command line parameters do you recommend to use in
> this case?

Well, you could try: ftrace=function_graph ftrace_graph_filter workqueue_prepare_cpu

If workqueue_prepare_cpu is a traceable function (not inlined nor notrace set).

-- Steve

