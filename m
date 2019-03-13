Return-Path: <SRS0=s/eb=RQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E59C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638B32147C
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552487870;
	bh=qkfTDZ//14cTqXpCbQMorCnPESzMrW1yNqpkwcTR8BE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uYN+aGFjjYjMnoLZNwzLoLeZb2funwiCmGO9nU8zgaQwfayHGd10VgOO+D2TNvM0v
	 ZYbBBMvW3Z7NsnFy1jEtuP2ZweazvdneVGA1kDhpz7foq8wlKd0wWnCH37Sc4RV+Zp
	 SX4c1dPsTRY/nmzNBH6H301cnHw++gboB1U+Ah7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfCMOho (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfCMOho (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Mar 2019 10:37:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765372087C;
        Wed, 13 Mar 2019 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552487863;
        bh=qkfTDZ//14cTqXpCbQMorCnPESzMrW1yNqpkwcTR8BE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K9DH7LQqXrktyi6vmBNjaeTVAIYRKgQmNibZ71/S3TnwuFvdbJlXWVuB6B6i8bGmT
         z+rkIkwJ9xumC/m4czUGytSK9OgHIHUVQS5vqIvYgLdeAY14Nb3Cg1+OWxCVfGUEMd
         st2osd0GbLyjM1OkUGqND/1VRyelMgBYhoE99QxI=
Date:   Wed, 13 Mar 2019 23:37:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] tracing/probe: Check maxactive error cases
Message-Id: <20190313233739.09f58a0c5762d9a43470046b@kernel.org>
In-Reply-To: <20190313092051.77d04675@gandalf.local.home>
References: <155248005229.10815.334731901778152247.stgit@devnote2>
        <155248006270.10815.14600382508884855084.stgit@devnote2>
        <20190313092051.77d04675@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 13 Mar 2019 09:20:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 13 Mar 2019 21:27:42 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Check maxactive on kprobe error case, because maxactive
> > is only for kretprobe, not for kprobe. Also, maxactive
> > should not be 0, it should be at least 1.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_kprobe.c |   10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index d5fb09ebba8b..d47e12596f12 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -624,7 +624,11 @@ static int trace_kprobe_create(int argc, const char *argv[])
> >  	if (event)
> >  		event++;
> >  
> > -	if (is_return && isdigit(argv[0][1])) {
> > +	if (isdigit(argv[0][1])) {
> > +		if (!is_return) {
> > +			pr_info("Maxactive is not for kprobe");
> 
> So now 'p1:..." will error out and not just be ignored?

Yes, I think it is better to tell user "your command has a
meaningless option, maybe you made a mistake" than ignore that.

Thank you,

> 
> -- Steve
> 
> > +			return -EINVAL;
> > +		}
> >  		if (event)
> >  			len = event - &argv[0][1] - 1;
> >  		else
> > @@ -634,8 +638,8 @@ static int trace_kprobe_create(int argc, const char *argv[])
> >  		memcpy(buf, &argv[0][1], len);
> >  		buf[len] = '\0';
> >  		ret = kstrtouint(buf, 0, &maxactive);
> > -		if (ret) {
> > -			pr_info("Failed to parse maxactive.\n");
> > +		if (ret || !maxactive) {
> > +			pr_info("Invalid maxactive number\n");
> >  			return ret;
> >  		}
> >  		/* kretprobes instances are iterated over via a list. The
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
