Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA30C4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 15:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DB260ED5
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 15:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhHPPZr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Aug 2021 11:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhHPPZr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Aug 2021 11:25:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C219160231;
        Mon, 16 Aug 2021 15:25:14 +0000 (UTC)
Date:   Mon, 16 Aug 2021 11:25:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, bristot@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/1] tracing: Provide more parseable hist trigger output
Message-ID: <20210816112508.37ba2875@oasis.local.home>
In-Reply-To: <42a2672432301de9beee593765bb49f739ce493a.camel@kernel.org>
References: <cover.1628807056.git.zanussi@kernel.org>
        <20210813182436.0ca56fe333a80fb7188f0b14@kernel.org>
        <42a2672432301de9beee593765bb49f739ce493a.camel@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 13 Aug 2021 10:31:03 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> > $ echo 1 > /sys/kernel/tracing/options/hist-json
> > 
> > This will no need to add additional pseudo file but just add an
> > option to
> > the ftrace.
> >   
> 
> That sounds like a good idea, thanks for the suggestion!

My only worry about this approach is that it affects all events in the
instance (please make this an instance option).

But I think I still rather have it affecting all events in an instance
than to bloat the directories with yet-another-file.

Yeah, make it an option.

Thanks!

-- Steve
