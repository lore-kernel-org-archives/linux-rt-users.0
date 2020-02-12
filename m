Return-Path: <SRS0=WKTr=4A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D1AC2BA83
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 05:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DEC2082F
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 05:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581485095;
	bh=un39J9qMdFa34cg769TCV5eJ4cUV9zXRUQ4ROVrkKkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2R40uhCufPq17nJmQFUOttoVFnP8Af55SOd3dVZekkWVEqXll1Ovdiaz3USFMjFm1
	 0YyDDi/ImOMlAVZEIsxVzRVBlt+DCX+AK/NUps+wyEysNr0GiesKpHY0HNRDzMFMu1
	 Rl6zamw5txLquCTYCD5uT8o4aUp3juKICbD+S/pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgBLFYw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgBLFYw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Feb 2020 00:24:52 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C5D206ED;
        Wed, 12 Feb 2020 05:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581485091;
        bh=un39J9qMdFa34cg769TCV5eJ4cUV9zXRUQ4ROVrkKkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XYPCFWCn6aeHqaUSojGBWrFtcqPp6nTnI6lZTPz2WcM5KqXO/hLlqlnNBKvz11agO
         UPzZuLSWKoQC9/1sPTo0jWbOPQCNJxMlDwM3tvQldvu/JfsEwahsTykhdmdYyDs5ak
         dBnLHihu3I5oT/Qx43nss4j5IRkA7jpJpQkoRgKU=
Date:   Wed, 12 Feb 2020 14:24:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing: Don't return -EINVAL when tracing soft
 disabled synth events
Message-Id: <20200212142447.210356f96a6a8b93461ae80c@kernel.org>
In-Reply-To: <20200211222856.67cdc386@rorschach.local.home>
References: <cover.1581374549.git.zanussi@kernel.org>
        <df5d02a1625aff97c9866506c5bada6a069982ba.1581374549.git.zanussi@kernel.org>
        <20200212122415.6dd7d33c19d1eeddae0ccfb8@kernel.org>
        <20200211222856.67cdc386@rorschach.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 11 Feb 2020 22:28:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 12 Feb 2020 12:24:15 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Mon, 10 Feb 2020 17:06:49 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > There's no reason to return -EINVAL when tracing a synthetic event if
> > > it's soft disabled - treat it the same as if it were hard disabled and
> > > return normally.
> > > 
> > > Have synth_event_trace() and synth_event_trace_array() just return
> > > normally, and have synth_event_trace_start set the trace state to
> > > disabled and return.
> > >   
> > 
> > Looks good to me.
> > 
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> 
> Thanks for the review Masami, but these patches have already landed in
> Linus's tree ;-)

Oh, OK. But I think [3/3] still has a real bug (not checking state->disabled
in __synth_event_trace_end()).
I'll send a fix.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
