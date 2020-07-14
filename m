Return-Path: <SRS0=fwOa=AZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F6AC433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E6A22518
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 14:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgGNOep (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNOep (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jul 2020 10:34:45 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB8D22515;
        Tue, 14 Jul 2020 14:34:44 +0000 (UTC)
Date:   Tue, 14 Jul 2020 10:34:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Itai Handler <itai.handler@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: aarch64 boot time increases with rt
Message-ID: <20200714103443.31895064@oasis.local.home>
In-Reply-To: <CAFpOueRmBfzhPFb-q_pB1xpCQq4Cuo7rCCsc2eUPsGdaei-+3A@mail.gmail.com>
References: <CAFpOueS0rvys4Q81D3HEYX2U1vM808qQ4w+z6QxCWi1KJBGXXQ@mail.gmail.com>
        <20200713212054.2e675557@oasis.local.home>
        <CAFpOueRmBfzhPFb-q_pB1xpCQq4Cuo7rCCsc2eUPsGdaei-+3A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 14 Jul 2020 15:18:01 +0300
Itai Handler <itai.handler@gmail.com> wrote:

> I tried "ftrace=function_graph ftrace_graph_filter=workqueue_prepare_cpu",
> however, the trace appears to be empty.
> The function workqueue_prepare_cpu is not defined inline nor notrace.
> 
> Please see log below:
> # mount -t debugfs none /sys/kernel/debug
> # cd /sys/kernel/debug/tracing/
> # cat trace
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
> # cat set_graph_function
> workqueue_prepare_cpu
> # cat tracing_on
> 1
> 
> Do you have any idea why it's empty?

Hmm, does the place in question happen before ftrace is initialized?

That is, where do you see the message that has something like this:

 ftrace: allocating 41803 entries in 164 pages
 ftrace: allocated 164 pages with 3 groups

-- Steve
