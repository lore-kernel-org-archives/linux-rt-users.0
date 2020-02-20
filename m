Return-Path: <SRS0=oqvG=4I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C08C11D00
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 22:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C8720801
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Feb 2020 22:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582239400;
	bh=MqnugRcvRyxMKhg+YAUlSRgmEzmHtz5ojXiyZUM287s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=PtWXc0n/Bo/E+n2hGscnmT6X8By+73AQXAAW2Z6Lzbtg5Xd7xqcQgNV+O8hibxRtA
	 VhX0/b7yQcVGccdCYgd1G16gBkSM4toxHG/0dKDLFqZbr9Vw1iIpx7Q24as10zgYs4
	 mszsiZnhRilhkgZpcgtpTGjbHCdnllEhL7sQ9/Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgBTW4g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbgBTW4g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Feb 2020 17:56:36 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685DC206F4;
        Thu, 20 Feb 2020 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582239395;
        bh=MqnugRcvRyxMKhg+YAUlSRgmEzmHtz5ojXiyZUM287s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=usgIpvoHgHrASYKfE/E71nr1K+UQRzQSgh1soWdSr6uKzFaE4HCvOAkGmTy6hjdx8
         FkLp/sunNCNT4zGgS9it0Ld2ydVFuSlTy06PFr/7rFoxUQLWHjBazf6ZjgMntVsmAq
         +koN7oiCwUAVH6TDqoFdyvLFvpGNwKuknpTiefGA=
Message-ID: <1582239393.12738.10.camel@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Fix synth event test to avoid using
 smp_processor_id()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Thu, 20 Feb 2020 16:56:33 -0600
In-Reply-To: <20200220174801.2b793ae1@gandalf.local.home>
References: <158193313870.8868.10793333111731425487.stgit@devnote2>
         <158193314931.8868.11386672578933699881.stgit@devnote2>
         <20200220174801.2b793ae1@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On Thu, 2020-02-20 at 17:48 -0500, Steven Rostedt wrote:
> On Mon, 17 Feb 2020 18:52:29 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since smp_processor_id() requires irq-disabled or preempt-disabled,
> > synth event generation test module made some warnings. To prevent
> > that, use get_cpu()/put_cpu() instead of smp_processor_id().
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/trace/synth_event_gen_test.c |   23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> 
> I just noticed this patch, after applying my version that just uses
> the
> raw_smp_processor_id(). We don't really care what CPU it is do we?
> 
> I didn't want a test to muck with preemption disabling and all that
> fun.
> 

Right, we don't really care, it's just to test the trace API - for this
it could even be a constant.  I just happened to pick that as an
example, and wasn't expecting unrelated complications.

Tom 

> -- Steve
