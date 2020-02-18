Return-Path: <SRS0=BQEv=4G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3470CC34026
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Feb 2020 15:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A76224656
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Feb 2020 15:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582039132;
	bh=bBPJ+mRnzEMMdJSuxuJOrXFYtWZeyUv5H3TE5t6entU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=GutYJ0kU35fdKFNp63MqqmtLT/7Si1JWRduOYr0Msiw7htYq0INUzyJEM/O8EynGy
	 63WkHWuc17P1kDOprco5QdGlzctxaihPO3d8GN418jpko24fvidfYJ4s4DChpL89AN
	 ATw99mfmu4DzEe1qdTxkVEXCaKkOZR0y0dkM/lkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgBRPSs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgBRPS2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Feb 2020 10:18:28 -0500
Received: from tzanussi-mobl9 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB3C24655;
        Tue, 18 Feb 2020 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582039108;
        bh=bBPJ+mRnzEMMdJSuxuJOrXFYtWZeyUv5H3TE5t6entU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AnZd926r9ie692W1fiQLF0vApHxSV//bCa0NfejllD+h+2/V5e93e68AHoBzUa/ka
         eKJRx9BX4+cW4KIhZ9Xqnj2B4SYn5gMOktzE1z5B5oHxPaOxP3ryyXNxlg7mHpjuLo
         OaEfRU9nF9F3pnOhaKUUz1sWv3wufVDxxvm5/0dU=
Message-ID: <1582039106.18307.1.camel@kernel.org>
Subject: Re: [PATCH 0/2] tracing: Fix synthetic event generation API and test
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Tue, 18 Feb 2020 09:18:26 -0600
In-Reply-To: <158193313870.8868.10793333111731425487.stgit@devnote2>
References: <158193313870.8868.10793333111731425487.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Masami,

On Mon, 2020-02-17 at 18:52 +0900, Masami Hiramatsu wrote:
> Hi,
> 
> Here is a couple of patches to fix 2 issues LKP and I found on
> synthetic event generation test.
> 
> [1/2] is for fixing warnings on smp_processor_id() without
> disabling preemption, and [2/2] is for fixing a bug on the API
> itself which LKP reported.
> 
> Thank you,

Thank you for fixing these.

For both,

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


Tom

> 
> ---
> 
> Masami Hiramatsu (2):
>       tracing: Fix synth event test to avoid using smp_processor_id()
>       tracing: Clear trace_state when starting trace
> 
> 
>  kernel/trace/synth_event_gen_test.c |   23 +++++++++++++++++------
>  kernel/trace/trace_events_hist.c    |    4 ++--
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
