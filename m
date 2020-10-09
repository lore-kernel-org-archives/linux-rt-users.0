Return-Path: <SRS0=IZRq=DQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5755EC43457
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0563622251
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 15:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EiO9Fxtc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tVjDY3vA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbgJIPlT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbgJIPlS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Oct 2020 11:41:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C94C0613D2;
        Fri,  9 Oct 2020 08:41:18 -0700 (PDT)
Date:   Fri, 9 Oct 2020 17:41:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602258077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzoqlKvnB0DJ8DXslRDdZXi+gnl9UDKfq4lWRVndgWk=;
        b=EiO9Fxtc37/HKn+RtbL5Nc/7DbIqelxUy1uI8m9fQ+LMKkFamsCk6sCEaDB+6EhxRx/xfG
        H7NzPQpdTomL357yGw7asvR9hqLqD5X9NUQM7BjZMGVfQnS79xrujfkxxpQLggD93RGP8o
        j6DzPvH+RJzkM+AFNkQXoDeAeLizXMqU1BZtVuS8jRw48yKF3Ux4m0NvOL1CtSTjYbsdh7
        wHL1B1JgbFKThAFnrZctV7l6KWcdMxnR7pc4Rp2uLpMOfiX10qKDvQWOF6O35ZX7mTpkK7
        3SzO1TlJEEBAnhGDBRzM8sxOKsgmA8F/fLtri0v42asrAC3+Eas86VQLEHgZUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602258077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzoqlKvnB0DJ8DXslRDdZXi+gnl9UDKfq4lWRVndgWk=;
        b=tVjDY3vAW6eTHq/PXxf8DNSmv6tILey/tMm4YtDAqbONSoICd5Gx6e+8rN3Lt2fuCA/PpJ
        mcvu91zCzsdTXaCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, echaudro@redhat.com, atheurer@redhat.com
Subject: Re: [PATCH 5.9 RT] net: openvswitch: Fix using smp_processor_id() in
 preemptible code
Message-ID: <20201009154116.a4fcrrm7flxonidd@linutronix.de>
References: <20201009124759.592550-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009124759.592550-1-juri.lelli@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-09 14:47:59 [+0200], Juri Lelli wrote:
> This happens because openvswitch/flow_table::flow_lookup() accesses
> per-cpu data while being preemptible (and migratable).
> 
> Fix it by adding get/put_cpu_light(), so that, even if preempted, the
> task executing this code is not migrated (operation is also guarded by
> ovs_mutex mutex).

This warning is not limited to PREEMPT_RT it also present upstream since
commit
   eac87c413bf97 ("net: openvswitch: reorder masks array based on usage")

You should be able to reproduce it there, too.
The path ovs_flow_tbl_lookup() -> flow_lookup() is guarded by ovs_lock()
I can't say that this true for
   ovs_vport_receive() -> ovs_dp_process_packet() ->
   ovs_flow_tbl_lookup_stats() -> flow_lookup()

(means I don't know but it looks like coming from NAPI).

Which means u64_stats_update_begin() could have two writers. This must
not happen.
There are two reader which do u64_stats_fetch_begin_irq(). Disabling
interrupts makes no sense since they perform cross-CPU access.

-> You need to ensure that there is only one writer at a time.

If mask_array gains a spinlock_t for writer protection then you can
acquire the lock prio grabbing ->masks_usage_cntr. But as of now there
is one `ma->syncp'.

Sebastian
