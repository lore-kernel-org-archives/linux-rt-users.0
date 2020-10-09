Return-Path: <SRS0=IZRq=DQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD47C43457
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 15:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7A4222BA
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Oct 2020 15:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV2UeSfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbgJIPBd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388692AbgJIPBc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Oct 2020 11:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602255691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jw9BGCjsMnawuKcN1MaKWrpBeOgyBKD0wIZxYikBvLU=;
        b=gV2UeSfx5Z/S9vNgMf7IYcFy8MmNxZ/PIIsTszTV3UOxb0MoFic/McUYR3jwI6JAv0TtFv
        UQ84lYPpE3Afy1LjMgt9JKmRn4i44NBtULZPnUpmUg1QgOYL9lGzWgitWXffz/w2m5vHyM
        JsLoCLLxy7D1H2u+zN4qCuO808zek7s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-s26U2yVePd6yY1T1zE9iOw-1; Fri, 09 Oct 2020 11:01:28 -0400
X-MC-Unique: s26U2yVePd6yY1T1zE9iOw-1
Received: by mail-wm1-f70.google.com with SMTP id z7so4331654wmi.3
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Oct 2020 08:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jw9BGCjsMnawuKcN1MaKWrpBeOgyBKD0wIZxYikBvLU=;
        b=g6kD6pv3EAv/Sud4v7vl724TkPMNtJYx/qYWifUOV2uS2pvdaQ/3XvcGn6bXD5IUsW
         237qwMeZ5vBHwueoQB8funrVVkzHFPrqzO8MFtGNzDZPEDoE+EWB3Ruj0X8aZv6RDYKL
         vXs4R0bsEYLSQP1sAwUFJ5I9fD0Ma7yBJ3MAEdIoa8aie8USWn4jTuPGN4o59Bh+iorv
         pYjditAQjaS4AyMfF/sT1nxSn/XTz49BvS0I7N/DT8IdR81uJkKHhZaD0hMNxA1vQXzH
         fIXwXJPhpo2QHpqw0k2HRp9G+IK+zzgEL6zgyqbrWVUYlAXIVIs8w1ujfyGoqFqaldM1
         1yiA==
X-Gm-Message-State: AOAM532FPvfEArcTvLrxdGjbNscYqOfBf9axGLQ/VOra9iiu8cPi3xk1
        7Lkqt11xPNNaEDP9nTdPFXpITlNXEsFEoQShIlPdRgGfSxw8+s+3k958bUTUaDcqlbqFZRVk6RQ
        6bywH6vB+9zNjWTkQt2UHCfYA9Ik=
X-Received: by 2002:adf:db52:: with SMTP id f18mr15316212wrj.397.1602255687029;
        Fri, 09 Oct 2020 08:01:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjMYvv6sQxurdClUr+kt8QQxyRlFV6jcGxXmrF4sk5T7xan/0EfmLzenmf5EVFN0jPQhO1Xg==
X-Received: by 2002:adf:db52:: with SMTP id f18mr15316180wrj.397.1602255686745;
        Fri, 09 Oct 2020 08:01:26 -0700 (PDT)
Received: from localhost.localdomain ([151.29.23.182])
        by smtp.gmail.com with ESMTPSA id u5sm13861613wru.63.2020.10.09.08.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:01:26 -0700 (PDT)
Date:   Fri, 9 Oct 2020 17:01:24 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com, echaudro@redhat.com,
        atheurer@redhat.com
Subject: Re: [PATCH 5.9 RT] net: openvswitch: Fix using smp_processor_id() in
 preemptible code
Message-ID: <20201009150124.GV4352@localhost.localdomain>
References: <20201009124759.592550-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009124759.592550-1-juri.lelli@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 09/10/20 14:47, Juri Lelli wrote:
> The following BUG has been reported (slightly edited):
> 
>  BUG: using smp_processor_id() in preemptible [00000000] code: handler106/3082
>  caller is flow_lookup.isra.15+0x2c/0xf0 [openvswitch]
>  CPU: 46 PID: 3082 Comm: handler106 Not tainted ... #1
>  Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS 2.5.4 01/13/2020
>  Call Trace:
>   dump_stack+0x5c/0x80
>   check_preemption_disabled+0xc4/0xd0
>   flow_lookup.isra.15+0x2c/0xf0 [openvswitch]
>   ovs_flow_tbl_lookup+0x3b/0x60 [openvswitch]
>   ovs_flow_cmd_new+0x2d8/0x430 [openvswitch]
>   ? __switch_to_asm+0x35/0x70
>   ? __switch_to_asm+0x41/0x70
>   ? __switch_to_asm+0x35/0x70
>   genl_family_rcv_msg+0x1d7/0x410
>   ? migrate_enable+0x123/0x3a0
>   genl_rcv_msg+0x47/0x8c
>   ? __kmalloc_node_track_caller+0xff/0x2e0
>   ? genl_family_rcv_msg+0x410/0x410
>   netlink_rcv_skb+0x4c/0x120
>   genl_rcv+0x24/0x40
>   netlink_unicast+0x197/0x230
>   netlink_sendmsg+0x204/0x3d0
>   sock_sendmsg+0x4c/0x50
>   ___sys_sendmsg+0x29f/0x300
>   ? migrate_enable+0x123/0x3a0
>   ? ep_send_events_proc+0x8a/0x1f0
>   ? ep_scan_ready_list.constprop.23+0x237/0x260
>   ? rt_spin_unlock+0x23/0x40
>   ? ep_poll+0x1b3/0x390
>   ? __fget+0x72/0xa0
>   __sys_sendmsg+0x57/0xa0
>   do_syscall_64+0x87/0x1a0
>   entry_SYSCALL_64_after_hwframe+0x65/0xca
>  RIP: 0033:0x7f1ed72ccb07
>  Code: ...
>  RSP: 002b:00007f1ecbd9ba80 EFLAGS: 00003293 ORIG_RAX: 000000000000002e
>  RAX: ffffffffffffffda RBX: 000000000000007b RCX: 00007f1ed72ccb07
>  RDX: 0000000000000000 RSI: 00007f1ecbd9bb10 RDI: 000000000000007b
>  RBP: 00007f1ecbd9bb10 R08: 0000000000000000 R09: 00007f1ecbd9d390
>  R10: 0000000019616156 R11: 0000000000003293 R12: 0000000000000000
>  R13: 00007f1ecbd9d338 R14: 00007f1ecbd9bfb0 R15: 00007f1ecbd9bb10
> 
> This happens because openvswitch/flow_table::flow_lookup() accesses
> per-cpu data while being preemptible (and migratable).
> 
> Fix it by adding get/put_cpu_light(), so that, even if preempted, the
> task executing this code is not migrated (operation is also guarded by
> ovs_mutex mutex).
> 

This actually wants also a (sorry for missing it in the first place)

Suggested-by: Daniel Bristot de Oliveira <bristot@redhat.com>

> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  net/openvswitch/flow_table.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
> index e2235849a57e..7df27ef7da09 100644
> --- a/net/openvswitch/flow_table.c
> +++ b/net/openvswitch/flow_table.c
> @@ -732,11 +732,14 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
>  				   u32 *n_cache_hit,
>  				   u32 *index)
>  {
> -	u64 *usage_counters = this_cpu_ptr(ma->masks_usage_cntr);
> +	u64 *usage_counters;
>  	struct sw_flow *flow;
>  	struct sw_flow_mask *mask;
>  	int i;
>  
> +	get_cpu_light();
> +	usage_counters = this_cpu_ptr(ma->masks_usage_cntr);
> +
>  	if (likely(*index < ma->max)) {
>  		mask = rcu_dereference_ovsl(ma->masks[*index]);
>  		if (mask) {
> @@ -746,6 +749,7 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
>  				usage_counters[*index]++;
>  				u64_stats_update_end(&ma->syncp);
>  				(*n_cache_hit)++;
> +				put_cpu_light();
>  				return flow;
>  			}
>  		}
> @@ -766,10 +770,12 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
>  			u64_stats_update_begin(&ma->syncp);
>  			usage_counters[*index]++;
>  			u64_stats_update_end(&ma->syncp);
> +			put_cpu_light();
>  			return flow;
>  		}
>  	}
>  
> +	put_cpu_light();
>  	return NULL;
>  }
>  
> -- 
> 2.26.2
> 

