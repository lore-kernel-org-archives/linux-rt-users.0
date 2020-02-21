Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4EFC35647
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 10:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA1424653
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 10:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582280668;
	bh=4eMYs7KLiD72Bm0LL7jMLy8vANd+p7TFOfu9aQGi7vc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uWeOA0OFD2iE1R3LJ/g7CZIn/G6iZPVa1PpZHhq/172POqcX5+2SBaOviHf5sla5j
	 SjzUNV9tLjrk1XaM9iCMdV4psixUFmtgvlhmAzI0ZHN5vHZguq/VlwUwZf2FhCTDBe
	 TTrhNP3mbL3MvloLTdbQx9w/9ICm4w5wW4i+f0kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgBUKYX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:24:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgBUKYX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 05:24:23 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71A02207FD;
        Fri, 21 Feb 2020 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582280663;
        bh=4eMYs7KLiD72Bm0LL7jMLy8vANd+p7TFOfu9aQGi7vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nSdKaMGMDNwFGw+q/0EGzr1b0O2Ui4Ei9Nkx+5KVEvGNXpU5fbG7ZI4bECR1LiFVh
         o2ZDhUwMyRoWHshGS0NvPzVLsaGfjFpZqk9lmolkCRm4bIthzC8T1hn2TJOhB1NYHi
         9+ME1WGttWiRzgoA+zyxdWvKSsN9f60F+ksktcCM=
Date:   Fri, 21 Feb 2020 19:24:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Fix synth event test to avoid using
 smp_processor_id()
Message-Id: <20200221192419.ce690df36a60d46da5d6d866@kernel.org>
In-Reply-To: <20200220174801.2b793ae1@gandalf.local.home>
References: <158193313870.8868.10793333111731425487.stgit@devnote2>
        <158193314931.8868.11386672578933699881.stgit@devnote2>
        <20200220174801.2b793ae1@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 20 Feb 2020 17:48:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

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
> I just noticed this patch, after applying my version that just uses the
> raw_smp_processor_id(). We don't really care what CPU it is do we?
> 
> I didn't want a test to muck with preemption disabling and all that fun.

OK, I confirmed that the ring_buffer_nest_start() ensures the preempt
disabled. So just using raw_smp_processor_id() is good to me.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
