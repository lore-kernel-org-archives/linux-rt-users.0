Return-Path: <SRS0=6AJS=3U=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA51C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 18:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E740214D8
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 Jan 2020 18:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgAaSAW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgAaSAW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Jan 2020 13:00:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2F0214D8;
        Fri, 31 Jan 2020 18:00:21 +0000 (UTC)
Date:   Fri, 31 Jan 2020 13:00:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tzanussi@gmail.com>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 06/12] tracing: Change trace_boot to use synth_event
 interface
Message-ID: <20200131130020.51d04203@gandalf.local.home>
In-Reply-To: <20200131125539.68ab766d@gandalf.local.home>
References: <cover.1580323897.git.zanussi@kernel.org>
        <94f1fa0e31846d0bddca916b8663404b20559e34.1580323897.git.zanussi@kernel.org>
        <1580492941.24839.5.camel@gmail.com>
        <20200131125539.68ab766d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 31 Jan 2020 12:55:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 31 Jan 2020 11:49:01 -0600
> Tom Zanussi <tzanussi@gmail.com> wrote:
> 
> > Hi Steve,
> > 
> > It looks like you missed this patch when you pulled the other ones into
> >  for-next.
> >   
> 
> Ah, you're right! And my INBOX patchwork is informing me of it too (I
> have it read my email, and when I post the 'for-next' patches, it
> switches the status from "new" to "Under review", and this one is still
> "new").
> 
> Thanks for letting me know. I'll apply it now.

My latest has been pushed to ftrace/core.

-- Steve
