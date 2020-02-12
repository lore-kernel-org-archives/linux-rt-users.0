Return-Path: <SRS0=WKTr=4A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE85CC2BA83
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 03:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5C42082F
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 03:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgBLD27 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:28:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbgBLD27 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 22:28:59 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F22D32082F;
        Wed, 12 Feb 2020 03:28:57 +0000 (UTC)
Date:   Tue, 11 Feb 2020 22:28:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing: Don't return -EINVAL when tracing soft
 disabled synth events
Message-ID: <20200211222856.67cdc386@rorschach.local.home>
In-Reply-To: <20200212122415.6dd7d33c19d1eeddae0ccfb8@kernel.org>
References: <cover.1581374549.git.zanussi@kernel.org>
        <df5d02a1625aff97c9866506c5bada6a069982ba.1581374549.git.zanussi@kernel.org>
        <20200212122415.6dd7d33c19d1eeddae0ccfb8@kernel.org>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 12 Feb 2020 12:24:15 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 10 Feb 2020 17:06:49 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > There's no reason to return -EINVAL when tracing a synthetic event if
> > it's soft disabled - treat it the same as if it were hard disabled and
> > return normally.
> > 
> > Have synth_event_trace() and synth_event_trace_array() just return
> > normally, and have synth_event_trace_start set the trace state to
> > disabled and return.
> >   
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Thanks for the review Masami, but these patches have already landed in
Linus's tree ;-)

-- Steve
