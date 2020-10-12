Return-Path: <SRS0=LljW=DT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D85C433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 14:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4941206F4
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 14:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+p1N+8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403766AbgJLOD3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Oct 2020 10:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730686AbgJLNgd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Oct 2020 09:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602509787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQhfwSvFTC00iWK+doexcB4MO8bFgyxrd5Ornf8S0lM=;
        b=I+p1N+8oaXMI04Mc9+TPdBlH/Hx2eVdFxGlru/XpcM360KrAWrRTMkYEzOxziYCiFiH0El
        ULt3zkSvzCNRsWvtQff30TmHomzKVZJ9sL+Mgc1wALJ4NvDNlv1Sofmrda329EpxmvFUW7
        RvtY+oBjl6faK9OWHlhzTU5dPjY4aTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-dBQMTsoGPpyC4ET2IalxoA-1; Mon, 12 Oct 2020 09:36:25 -0400
X-MC-Unique: dBQMTsoGPpyC4ET2IalxoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1056391470C;
        Mon, 12 Oct 2020 13:36:24 +0000 (UTC)
Received: from [10.36.112.220] (ovpn-112-220.ams2.redhat.com [10.36.112.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 835AC55789;
        Mon, 12 Oct 2020 13:36:16 +0000 (UTC)
From:   "Eelco Chaudron" <echaudro@redhat.com>
To:     "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc:     "Juri Lelli" <juri.lelli@redhat.com>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com, atheurer@redhat.com
Subject: Re: [PATCH 5.9 RT] net: openvswitch: Fix using smp_processor_id() in
 preemptible code
Date:   Mon, 12 Oct 2020 15:36:14 +0200
Message-ID: <EB6A6F4F-4778-41D3-B314-4587DE7A7658@redhat.com>
In-Reply-To: <20201012082129.ocod2dlftwais65a@linutronix.de>
References: <20201009124759.592550-1-juri.lelli@redhat.com>
 <20201009154116.a4fcrrm7flxonidd@linutronix.de>
 <65BBD0B4-2A74-421A-BF81-357CD5F84747@redhat.com>
 <20201012082129.ocod2dlftwais65a@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 12 Oct 2020, at 10:21, Sebastian Andrzej Siewior wrote:

> On 2020-10-12 10:14:42 [+0200], Eelco Chaudron wrote:
>>
>>
>> On 9 Oct 2020, at 17:41, Sebastian Andrzej Siewior wrote:
>>
>>> On 2020-10-09 14:47:59 [+0200], Juri Lelli wrote:
>>>> This happens because openvswitch/flow_table::flow_lookup() accesses
>>>> per-cpu data while being preemptible (and migratable).
>>>>
>>>> Fix it by adding get/put_cpu_light(), so that, even if preempted, 
>>>> the
>>>> task executing this code is not migrated (operation is also guarded
>>>> by
>>>> ovs_mutex mutex).
>>>
>>> This warning is not limited to PREEMPT_RT it also present upstream 
>>> since
>>> commit
>>>    eac87c413bf97 ("net: openvswitch: reorder masks array based on
>>> usage")
>>>
>>> You should be able to reproduce it there, too.
>>> The path ovs_flow_tbl_lookup() -> flow_lookup() is guarded by 
>>> ovs_lock()
>>> I can't say that this true for
>>>    ovs_vport_receive() -> ovs_dp_process_packet() ->
>>>    ovs_flow_tbl_lookup_stats() -> flow_lookup()
>>>
>>> (means I don't know but it looks like coming from NAPI).
>>>
>>> Which means u64_stats_update_begin() could have two writers. This 
>>> must
>>> not happen.
>>> There are two reader which do u64_stats_fetch_begin_irq(). Disabling
>>> interrupts makes no sense since they perform cross-CPU access.
>>>
>>> -> You need to ensure that there is only one writer at a time.
>>>
>>> If mask_array gains a spinlock_t for writer protection then you can
>>> acquire the lock prio grabbing ->masks_usage_cntr. But as of now 
>>> there
>>> is one `ma->syncp'.
>>
>> I’m not too familiar with the RT kernel, but in the none RT kernel, 
>> this
>> function is called in run to completion parts only, hence does not 
>> need a
>> lock. Actually, this was designed in such a way that it does not need 
>> a lock
>> at all.
>
> _no_ As explained above, this is not RT specific.
> What guaranties that you don't have two flow_lookup() invocations on 
> the
> same CPU? You are using u64_stats_update_begin() which must not be
> preempted. This means even if preemption is disabled you must not have
> another invocation in BH context. This is due to the
> write_seqcount_begin() in u64_stats_update_begin().
> If preemption / CPU migration is not a problem in the above part, you
> can use annotation to disable the warning that led to the warning. But
> the u64_stats invocation looks still problematic.
>
>> So maybe this needs a get_cpu() instead of the light variant in the 
>> RT case?

Hi Sebastian,

I was not reading the splat correctly and thought it was from the NAPI 
path but it looks like it's from the netlink part. I think this could be 
fixed with the following patch, so both paths, NAPI, and netlink become 
non-preemptive:

--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -850,9 +850,14 @@ struct sw_flow *ovs_flow_tbl_lookup(struct 
flow_table *tbl,
         struct mask_array *ma = rcu_dereference_ovsl(tbl->mask_array);
         u32 __always_unused n_mask_hit;
         u32 __always_unused n_cache_hit;
+       struct sw_flow *flow;
         u32 index = 0;

-       return flow_lookup(tbl, ti, ma, key, &n_mask_hit, &n_cache_hit, 
&index);
+       preempt_disable();
+       flow = flow_lookup(tbl, ti, ma, key, &n_mask_hit, &n_cache_hit, 
&index);
+       preempt_enable();
+
+       return flow;
  }

  struct sw_flow *ovs_flow_tbl_lookup_exact(struct flow_table *tbl,

Note that choosing to do this in ovs_flow_tbl_lookup() and not 
flow_lookup() allows the fast-path, through NAPI, not having to call 
preempt_disable().

Any comments? If not I can sent a proper patch trough netdev.

//Eelco

