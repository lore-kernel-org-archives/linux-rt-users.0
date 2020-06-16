Return-Path: <SRS0=2Bnr=75=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE61C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 17:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0FB20882
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 17:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBgmdMRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgFPRFA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:05:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40711 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730613AbgFPRE7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jun 2020 13:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592327097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQw+UFxN5DZFPam2oKMGGVyVcPpoQl3xU3v1u5lp85g=;
        b=DBgmdMRxhjGku65nj7C95CvTAs0mb5ahXaYEeFqjcUbP/IoH7iQE++cZunSnd/2p4Eg8Z/
        ocCi0OFzmddS9uw0+fr6xe4kZLeHAQDGBHOj4+LYOtgvBouR0mborbTReFMyEzivnU4T9C
        ouP1doFqLjS+Hv9rizgBBQqS5Ls99WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-y3P_yXU6PDO_xcu6_o4CCA-1; Tue, 16 Jun 2020 13:04:53 -0400
X-MC-Unique: y3P_yXU6PDO_xcu6_o4CCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD34887342B;
        Tue, 16 Jun 2020 17:04:52 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-9.gru2.redhat.com [10.97.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94D0B1C4;
        Tue, 16 Jun 2020 17:04:49 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 3AAF141887FC; Tue, 16 Jun 2020 14:04:25 -0300 (-03)
Date:   Tue, 16 Jun 2020 14:04:25 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 2/2] mm: page_alloc: drain pages remotely
Message-ID: <20200616170425.GA324900@fuller.cnet>
References: <20200616161149.392213902@fuller.cnet>
 <20200616161409.299575008@fuller.cnet>
 <20200616163248.z5bdrx7gj2sf7d3m@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616163248.z5bdrx7gj2sf7d3m@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 16, 2020 at 06:32:48PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-16 13:11:51 [-0300], Marcelo Tosatti wrote:
> > Remote draining of pages was removed from 5.6-rt.
> > 
> > Unfortunately its necessary for use-cases which have a busy spinning 
> > SCHED_FIFO thread on isolated CPU:
> > 
> > [ 7475.821066] INFO: task ld:274531 blocked for more than 600 seconds.
> > [ 7475.822157]       Not tainted 4.18.0-208.rt5.20.el8.x86_64 #1
> > [ 7475.823094] echo 0  /proc/sys/kernel/hung_task_timeout_secs disables this message.
> > [ 7475.824392] ld              D    0 274531 274530 0x00084080
> > [ 7475.825307] Call Trace:
> > [ 7475.825761]  __schedule+0x342/0x850
> > [ 7475.826377]  schedule+0x39/0xd0
> > [ 7475.826923]  schedule_timeout+0x20e/0x410
> > [ 7475.827610]  ? __schedule+0x34a/0x850
> > [ 7475.828247]  ? ___preempt_schedule+0x16/0x18
> > [ 7475.828953]  wait_for_completion+0x85/0xe0
> > [ 7475.829653]  flush_work+0x11a/0x1c0
> > [ 7475.830313]  ? flush_workqueue_prep_pwqs+0x130/0x130
> > [ 7475.831148]  drain_all_pages+0x140/0x190
> > [ 7475.831803]  __alloc_pages_slowpath+0x3f8/0xe20
> > [ 7475.832571]  ? mem_cgroup_commit_charge+0xcb/0x510
> > [ 7475.833371]  __alloc_pages_nodemask+0x1ca/0x2b0
> > [ 7475.834134]  pagecache_get_page+0xb5/0x2d0
> > [ 7475.834814]  ? account_page_dirtied+0x11a/0x220
> > [ 7475.835579]  grab_cache_page_write_begin+0x1f/0x40
> > [ 7475.836379]  iomap_write_begin.constprop.44+0x1c1/0x370
> > [ 7475.837241]  ? iomap_write_end+0x91/0x290
> > [ 7475.837911]  iomap_write_actor+0x92/0x170
> > ...
> > 
> > So enable remote draining again.
> 
> Is upstream affected by this? And if not, why not?

It is affected. The workqueue thread for a given CPU is SCHED_OTHER, which can't
interrupt a SCHED_FIFO task which does not sleep.


