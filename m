Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5255CC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Aug 2021 02:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C8C60FC4
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Aug 2021 02:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbhHMChP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 22:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237040AbhHMChP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Aug 2021 22:37:15 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B48260F35;
        Fri, 13 Aug 2021 02:36:48 +0000 (UTC)
Date:   Thu, 12 Aug 2021 22:36:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     bristot@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/1] tracing: Provide more parseable hist trigger output
Message-ID: <20210812223641.2bb429c9@oasis.local.home>
In-Reply-To: <cover.1628807056.git.zanussi@kernel.org>
References: <cover.1628807056.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 12 Aug 2021 17:43:23 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> I designed it so that more files/formats could be easily added as
> desired, so if you still want the csv output, let me know.  If so,
> though, please give me some more detailed idea as to what you think
> that should look like.

Thanks Tom!

BTW, I have off tomorrow, so I wont be looking at this until next week.

Although, tomorrow I'll probably spend my "free" time finishing up
slides that were due two weeks ago :-/

-- Steve
