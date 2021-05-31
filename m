Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97AEC47082
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 17:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A8B60FE5
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 17:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhEaRGs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 May 2021 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbhEaREi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 May 2021 13:04:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE33C068FB9
        for <linux-rt-users@vger.kernel.org>; Mon, 31 May 2021 08:16:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso1666908wmi.3
        for <linux-rt-users@vger.kernel.org>; Mon, 31 May 2021 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9MpIKbkZ6mjClGwI3TGS6YF6LdAnzLJO+Z82BFOyn44=;
        b=OpN/c2ZQUWgWgVFVElumbIrsZ/S2G1VMHtpizGAE1S7iD9b+uDDZT9h7TqBbRWBgo/
         CzwXx0AV8dshwuFuFGUgyW8Dszr/PEttMWSb6SDJWiwrwb30BxV42Kj39SGX6/gOzz3e
         E09+na/4CxPerL6ebWgssJn53kotm0VlEcZnxTZj+6FaUoqIE8MSKFZtD6N4tB7rJQF5
         YEjN9w9KPuujyRdK2r/CFz5vBSCE/EKfjFJwjrl4Drsc7F3xTEl7i5HIrJrJKlHat3bP
         LbB+09a9o4ck+aHW2j4w4QYPaLUPn2SPCdkBHOnheukLcJyxqUunlwLTNGoYJzwQOtT4
         7YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9MpIKbkZ6mjClGwI3TGS6YF6LdAnzLJO+Z82BFOyn44=;
        b=pudhCb55fpFlcbVvBt22TVYdE2CVH/QCucw4CO9Nk5S98oBqfRNuzYCUJOJC9OWEYF
         oqswMji6bhuCPA9J0yEaHWRLGeYEKglO/5vEubJ0FtwHxh6rYbrECYniMw9Lg2OGqgU+
         YzGpl6XsJ4sq5Gz2v0n4zwbaRnGRTW7TsgVrs4euf4zxi8pv/MiVDrJT9YZoRUS9SL7z
         Yst1GcnTpT7/8xepeuqTiCl2uMW/z2ok9HOdVO8/VxIwRjQ0jw7HkMdsOKR6s6/W0bjH
         6DAcnYKZU7zLZaqp+3DS6Lg8VBdSQxDYHvwu4jqb7s1h0GWbjoE2YtvTfuv8musrcqhF
         w+TA==
X-Gm-Message-State: AOAM533lU/wMbMjdyl1yu7Vk7mDK1chpi5MV8AdsB1kCe7LB8ocJRxoK
        um+jAqPCyjTwgG661GI6Z6UBMmsf9V8=
X-Google-Smtp-Source: ABdhPJwnTARv1A4xyWZ9CvZ8Vsv0i8BFD/AeutB9lnZG17MdBrqW8CWJEhUyis0HZRhMZZ7ansxQtQ==
X-Received: by 2002:a05:600c:19d4:: with SMTP id u20mr21847580wmq.91.1622474198908;
        Mon, 31 May 2021 08:16:38 -0700 (PDT)
Received: from [192.168.1.11] (46-22-16-84-dynamic-cgnat.cust.swissbackbone.net. [46.22.16.84])
        by smtp.gmail.com with ESMTPSA id z6sm15660284wml.29.2021.05.31.08.16.38
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 08:16:38 -0700 (PDT)
Subject: Re: Network latency on 5.4 and 5.10
From:   Christoph Mathys <eraserix@gmail.com>
To:     linux-rt-users@vger.kernel.org
References: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
Message-ID: <6ba61deb-1348-20c8-2ad0-b46a623ee99e@gmail.com>
Date:   Mon, 31 May 2021 17:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In the trace below (5.10), the NET_RX softirq is executed very late by ksoftirqd
instead of directly by the irq thread.

Can I somehow force the irq thread to always handle the softirq? I fear that
raising the priority of ksoftirqd will cause all kinds of undesired latencies
because its a rather general thread.

While tracing, I also see some PI here and there, that introduce various amounts
of latencies. Is there a good way to find the mutex responsible for the PI?


     RTController-20346   [001] .....12  3001.164215: netif_rx: dev=lo skbaddr=00000000f2ce0335 len=60
     RTController-20346   [001] d...113  3001.164215: softirq_raise: vec=3 [action=NET_RX]
     RTController-20346   [001] .....12  3001.164215: netif_rx_exit: ret=0
     RTController-20346   [001] .....12  3001.164216: net_dev_xmit: dev=lo skbaddr=00000000f2ce0335 len=74 rc=0
     RTController-20346   [001] ...s.12  3001.164216: softirq_entry: vec=3 [action=NET_RX]
     RTController-20346   [001] ...s.12  3001.164216: netif_receive_skb: dev=lo skbaddr=00000000f2ce0335 len=60
<IRQ from returning EtherCAT packet>
     RTController-20346   [001] d..H212  3001.164217: irq_handler_entry: irq=131 name=ecat0-rx-0
     RTController-20346   [001] d..H212  3001.164217: irq_handler_exit: irq=131 ret=handled
     RTController-20346   [001] d..H412  3001.164217: sched_waking: comm=irq/131-ecat0-r pid=19970 prio=19 target_cpu=001
     RTController-20346   [001] dN.H512  3001.164218: sched_wakeup: comm=irq/131-ecat0-r pid=19970 prio=19 target_cpu=001
     RTController-20346   [001] dN.s112  3001.164218: rcu_utilization: Start context switch
     RTController-20346   [001] dN.s112  3001.164219: rcu_utilization: End context switch
     RTController-20346   [001] dN.s212  3001.164219: sched_stat_runtime: comm=RTController pid=20346 runtime=37773 [ns] vruntime=50306493110 [ns]
     RTController-20346   [001] d..s212  3001.164221: sched_switch: prev_comm=RTController prev_pid=20346 prev_prio=120 prev_state=R+ ==> next_comm=irq/131-ecat0-r next_pid=19970 next_prio=19
     RTController-20346   [001] d..s212  3001.164221: x86_fpu_regs_deactivated: x86/fpu: 00000000a8ca490d load: 0 xfeatures: 3 xcomp_bv: 8000000000000003
<IRQ thread starts working>
  irq/131-ecat0-r-19970   [001] d...2..  3001.164222: write_msr: 48, value 0
  irq/131-ecat0-r-19970   [001] d..h1..  3001.164222: local_timer_entry: vector=236
  irq/131-ecat0-r-19970   [001] d..h2..  3001.164222: hrtimer_cancel: hrtimer=00000000cbde1eb6
  irq/131-ecat0-r-19970   [001] d..h1..  3001.164222: hrtimer_expire_entry: hrtimer=00000000cbde1eb6 function=hrtimer_wakeup now=3001159523681
  irq/131-ecat0-r-19970   [001] d..h3..  3001.164223: sched_waking: comm=SafetyLogicShad pid=20142 prio=30 target_cpu=001
  irq/131-ecat0-r-19970   [001] d..h4..  3001.164223: sched_wakeup: comm=SafetyLogicShad pid=20142 prio=30 target_cpu=001
  irq/131-ecat0-r-19970   [001] d..h1..  3001.164223: hrtimer_expire_exit: hrtimer=00000000cbde1eb6
           <idle>-0       [000] ....1..  3001.164223: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164224: cpu_idle: state=0 cpu_id=0
  irq/131-ecat0-r-19970   [001] d..h1..  3001.164224: write_msr: 6e0, value 91a6aa5a118
  irq/131-ecat0-r-19970   [001] d..h1..  3001.164224: local_timer_exit: vector=236
<PI? WTF?>
  irq/131-ecat0-r-19970   [001] d...311  3001.164225: sched_pi_setprio: comm=RTController pid=20346 oldprio=120 newprio=19
  irq/131-ecat0-r-19970   [001] d...111  3001.164226: rcu_utilization: Start context switch
  irq/131-ecat0-r-19970   [001] d...111  3001.164226: rcu_utilization: End context switch
  irq/131-ecat0-r-19970   [001] d...211  3001.164227: sched_switch: prev_comm=irq/131-ecat0-r prev_pid=19970 prev_prio=19 prev_state=R+ ==> next_comm=RTController next_pid=20346 next_prio=19
     RTController-20346   [001] d..s212  3001.164227: write_msr: 48, value 4
     RTController-20346   [001] ...s.12  3001.164230: fib_table_lookup: table 254 oif 0 iif 1 proto 6 127.0.0.1/9000 -> 127.0.0.1/57200 tos 0 scope 0 flags 0 ==> dev lo gw 114.121.0.0/1901:102:4b4f::ffff:4574:6865 err 0
     RTController-20346   [001] ...s.12  3001.164231: kmem_cache_alloc_node: call_site=__alloc_skb+0x4f/0x200 ptr=000000000d68a52d bytes_req=224 bytes_alloc=256 gfp_flags=GFP_ATOMIC node=-1
     RTController-20346   [001] ...s.12  3001.164231: kmalloc_node: call_site=__ip_append_data+0xc08/0xdf0 ptr=000000007e7f4744 bytes_req=448 bytes_alloc=512 gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC node=-1
     RTController-20346   [001] ...s.12  3001.164232: kfree: call_site=__ip_make_skb+0x2f2/0x420 ptr=0000000000000000
           <idle>-0       [000] ....1..  3001.164233: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164233: cpu_idle: state=0 cpu_id=0
     RTController-20346   [001] ...s.12  3001.164234: net_dev_queue: dev=lo skbaddr=000000000d68a52d len=54
     RTController-20346   [001] ...s.12  3001.164234: net_dev_start_xmit: dev=lo queue_mapping=0 skbaddr=000000000d68a52d vlan_tagged=0 vlan_proto=0x0000 vlan_tci=0x0000 protocol=0x0800 ip_summed=0 len=54 data_len=0 network_offset=14 transport_offset_valid=1 transport_offset=34 tx_flags=0 gso_size=0 gso_segs=0 gso_type=0x0
     RTController-20346   [001] ...s.12  3001.164234: netif_rx_entry: dev=lo napi_id=0x0 queue_mapping=0 skbaddr=000000000d68a52d vlan_tagged=0 vlan_proto=0x0000 vlan_tci=0x0000 protocol=0x0800 ip_summed=0 hash=0x00000000 l4_hash=0 len=40 data_len=0 truesize=768 mac_header_valid=1 mac_header=-14 nr_frags=0 gso_size=0 gso_type=0x0
     RTController-20346   [001] ...s.12  3001.164234: netif_rx: dev=lo skbaddr=000000000d68a52d len=40
     RTController-20346   [001] ...s.12  3001.164234: netif_rx_exit: ret=0
     RTController-20346   [001] ...s.12  3001.164234: net_dev_xmit: dev=lo skbaddr=000000000d68a52d len=54 rc=0
     RTController-20346   [001] ...s.12  3001.164235: kfree_skb: skbaddr=00000000f2ce0335 protocol=2048 location=000000005f4796b3
     RTController-20346   [001] ...s.12  3001.164235: netif_receive_skb: dev=lo skbaddr=000000000d68a52d len=40
     RTController-20346   [001] ...s.12  3001.164237: kfree: call_site=nf_conntrack_free+0x1f/0x40 [nf_conntrack] ptr=00000000d1a8317d
     RTController-20346   [001] ...s.12  3001.164237: kmem_cache_free: call_site=nf_conntrack_free+0x2e/0x40 [nf_conntrack] ptr=000000006bfc0f40
     RTController-20346   [001] ...s.12  3001.164238: napi_poll: napi poll on napi struct 0000000081e7f255 for device (no_device) work 2 budget 64
     RTController-20346   [001] ...s.12  3001.164238: softirq_exit: vec=3 [action=NET_RX]
<Uff, only a short one. But my packet that just arrived on ecat0 has not been handled...>
     RTController-20346   [001] d...311  3001.164238: sched_pi_setprio: comm=RTController pid=20346 oldprio=19 newprio=120
     RTController-20346   [001] dN..311  3001.164240: sched_waking: comm=irq/131-ecat0-r pid=19970 prio=19 target_cpu=001
     RTController-20346   [001] dN..411  3001.164240: sched_wakeup: comm=irq/131-ecat0-r pid=19970 prio=19 target_cpu=001
     RTController-20346   [001] dN..311  3001.164241: sched_stat_runtime: comm=RTController pid=20346 runtime=2053 [ns] vruntime=50306496047 [ns]
     RTController-20346   [001] dN.h...  3001.164242: local_timer_entry: vector=236
     RTController-20346   [001] dN.h1..  3001.164242: softirq_raise: vec=8 [action=HRTIMER]
           <idle>-0       [000] ....1..  3001.164242: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164242: cpu_idle: state=0 cpu_id=0
     RTController-20346   [001] dN.h...  3001.164242: write_msr: 6e0, value 91a6aace636
     RTController-20346   [001] dN.h...  3001.164242: local_timer_exit: vector=236
     RTController-20346   [001] dN..2..  3001.164242: sched_waking: comm=ksoftirqd/1 pid=21 prio=120 target_cpu=001
     RTController-20346   [001] dN..3..  3001.164243: sched_wakeup: comm=ksoftirqd/1 pid=21 prio=120 target_cpu=001
     RTController-20346   [001] dN..1..  3001.164243: rcu_utilization: Start context switch
     RTController-20346   [001] dN..1..  3001.164243: rcu_utilization: End context switch
     RTController-20346   [001] dN..2..  3001.164243: sched_stat_runtime: comm=RTController pid=20346 runtime=2364 [ns] vruntime=50306498411 [ns]
     RTController-20346   [001] d...2..  3001.164244: sched_switch: prev_comm=RTController prev_pid=20346 prev_prio=120 prev_state=R+ ==> next_comm=irq/131-ecat0-r next_pid=19970 next_prio=19
< because it has not yet signaled the softirq? >
  irq/131-ecat0-r-19970   [001] d...211  3001.164245: write_msr: 48, value 0
  irq/131-ecat0-r-19970   [001] d....12  3001.164245: softirq_raise: vec=3 [action=NET_RX]
  irq/131-ecat0-r-19970   [001] d...1..  3001.164246: rcu_utilization: Start context switch
  irq/131-ecat0-r-19970   [001] d...1..  3001.164246: rcu_utilization: End context switch
  irq/131-ecat0-r-19970   [001] d...2..  3001.164247: sched_switch: prev_comm=irq/131-ecat0-r prev_pid=19970 prev_prio=19 prev_state=S ==> next_comm=SafetyLogicShad next_pid=20142 next_prio=30
  irq/131-ecat0-r-19970   [001] d...2..  3001.164249: tlb_flush: pages:0 reason:flush on task switch (0)
< hey, why is my packet not handled by the softirq right away? >
  SafetyLogicShad-20142   [001] d...2..  3001.164250: write_msr: 48, value 4
  SafetyLogicShad-20142   [001] ....1..  3001.164250: sys_nanosleep -> 0x0
  SafetyLogicShad-20142   [001] .......  3001.164250: sys_exit: NR 35 = 0
  SafetyLogicShad-20142   [001] d......  3001.164251: x86_fpu_regs_activated: x86/fpu: 00000000e034cb86 load: 1 xfeatures: 3 xcomp_bv: 8000000000000003
           <idle>-0       [000] ....1..  3001.164251: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164252: cpu_idle: state=0 cpu_id=0
           <idle>-0       [000] ....1..  3001.164261: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164261: cpu_idle: state=0 cpu_id=0
           <idle>-0       [000] ....1..  3001.164270: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164270: cpu_idle: state=0 cpu_id=0
           <idle>-0       [000] ....1..  3001.164279: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164279: cpu_idle: state=0 cpu_id=0
           <idle>-0       [000] ....1..  3001.164289: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164289: cpu_idle: state=0 cpu_id=0
           <idle>-0       [000] ....1..  3001.164298: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164298: cpu_idle: state=0 cpu_id=0
           <idle>-0       [000] ....1..  3001.164307: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164308: cpu_idle: state=0 cpu_id=0
           <idle>-0       [000] ....1..  3001.164317: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] d...1..  3001.164317: cpu_idle: state=0 cpu_id=0
           <idle>-0       [000] d..h1..  3001.164324: local_timer_entry: vector=236
           <idle>-0       [000] d..h2..  3001.164324: hrtimer_cancel: hrtimer=00000000eb8a586a
           <idle>-0       [000] d..h1..  3001.164324: hrtimer_expire_entry: hrtimer=00000000eb8a586a function=hrtimer_wakeup now=3001159625341
           <idle>-0       [000] d..h3..  3001.164324: sched_waking: comm=EtherlabDaemon pid=20787 prio=20 target_cpu=000
           <idle>-0       [000] dN.h4..  3001.164325: sched_wakeup: comm=EtherlabDaemon pid=20787 prio=20 target_cpu=000
           <idle>-0       [000] dN.h1..  3001.164325: hrtimer_expire_exit: hrtimer=00000000eb8a586a
           <idle>-0       [000] dN.h1..  3001.164325: write_msr: 6e0, value 91a6aac112e
           <idle>-0       [000] dN.h1..  3001.164325: local_timer_exit: vector=236
           <idle>-0       [000] .N..1..  3001.164326: cpu_idle: state=4294967295 cpu_id=0
           <idle>-0       [000] dN..1..  3001.164326: rcu_utilization: Start context switch
           <idle>-0       [000] dN..1..  3001.164326: rcu_utilization: End context switch
           <idle>-0       [000] d...2..  3001.164326: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=EtherlabDaemon next_pid=20787 next_prio=20
   EtherlabDaemon-20787   [000] d...2..  3001.164327: write_msr: 48, value 4
   EtherlabDaemon-20787   [000] ....1..  3001.164327: sys_nanosleep -> 0x0
   EtherlabDaemon-20787   [000] .......  3001.164327: sys_exit: NR 35 = 0
   EtherlabDaemon-20787   [000] d......  3001.164327: x86_fpu_regs_activated: x86/fpu: 000000007cc67df0 load: 1 xfeatures: 3 xcomp_bv: 8000000000000003
< well, this sucks, no packet is ready for me... >
   EtherlabDaemon-20787   [000] ....1..  3001.164330: sys_recvfrom(fd: a, ubuf: a90c10, size: 640, flags: 40, addr: 0, addr_len: 0)
   EtherlabDaemon-20787   [000] .......  3001.164330: sys_enter: NR 45 (a, a90c10, 640, 40, 0, 0)
   EtherlabDaemon-20787   [000] ....1..  3001.164331: sys_recvfrom -> 0xfffffffffffffff5
   EtherlabDaemon-20787   [000] .......  3001.164331: sys_exit: NR 45 = -11
  SafetyLogicShad-20142   [001] ....1..  3001.164337: sys_nanosleep(rqtp: 7ffef5e5f960, rmtp: 0)
  SafetyLogicShad-20142   [001] .......  3001.164337: sys_enter: NR 35 (7ffef5e5f960, 0, 1, 32f4, 3e8, 4)
   EtherlabDaemon-20787   [000] ....1..  3001.164337: sys_sendto(fd: a, buff: a8cee0, len: 36a, flags: 0, addr: 0, addr_len: 0)
  SafetyLogicShad-20142   [001] .......  3001.164337: hrtimer_init: hrtimer=00000000cbde1eb6 clockid=CLOCK_MONOTONIC mode=REL
   EtherlabDaemon-20787   [000] .......  3001.164337: sys_enter: NR 44 (a, a8cee0, 36a, 0, 0, 0)
  SafetyLogicShad-20142   [001] d...1..  3001.164338: hrtimer_start: hrtimer=00000000cbde1eb6 function=hrtimer_wakeup expires=3001160639092 softexpires=3001160639092 mode=0x9
  SafetyLogicShad-20142   [001] d...1..  3001.164338: rcu_utilization: Start context switch
   EtherlabDaemon-20787   [000] .......  3001.164338: kmem_cache_alloc_node: call_site=__alloc_skb+0x4f/0x200 ptr=000000005b815b30 bytes_req=224 bytes_alloc=256 gfp_flags=GFP_KERNEL node=-1
  SafetyLogicShad-20142   [001] d...1..  3001.164338: rcu_utilization: End context switch
   EtherlabDaemon-20787   [000] .......  3001.164338: kmalloc_node: call_site=alloc_skb_with_frags+0x4d/0x1b0 ptr=0000000091eb5053 bytes_req=1216 bytes_alloc=2048 gfp_flags=GFP_KERNEL|__GFP_NOWARN|__GFP_NOMEMALLOC node=-1
   EtherlabDaemon-20787   [000] .....12  3001.164339: net_dev_queue: dev=ecat0 skbaddr=000000005b815b30 len=874
   EtherlabDaemon-20787   [000] .....15  3001.164339: net_dev_start_xmit: dev=ecat0 queue_mapping=0 skbaddr=000000005b815b30 vlan_tagged=0 vlan_proto=0x0000 vlan_tci=0x0000 protocol=0x88a4 ip_summed=0 len=874 data_len=0 network_offset=14 transport_offset_valid=0 transport_offset=65533 tx_flags=0 gso_size=0 gso_segs=0 gso_type=0x0
  SafetyLogicShad-20142   [001] d...2..  3001.164339: sched_switch: prev_comm=SafetyLogicShad prev_pid=20142 prev_prio=30 prev_state=S ==> next_comm=ksoftirqd/1 next_pid=21 next_prio=120
   EtherlabDaemon-20787   [000] .....15  3001.164340: net_dev_xmit: dev=ecat0 skbaddr=000000005b815b30 len=874 rc=0
  SafetyLogicShad-20142   [001] d...2..  3001.164340: x86_fpu_regs_deactivated: x86/fpu: 00000000e034cb86 load: 0 xfeatures: 3 xcomp_bv: 8000000000000003
   EtherlabDaemon-20787   [000] .....14  3001.164340: qdisc_dequeue: dequeue ifindex=2 qdisc handle=0x0 parent=0x1 txq_state=0x0 packets=0 skbaddr=0000000000000000
   EtherlabDaemon-20787   [000] ....1..  3001.164340: sys_sendto -> 0x36a
   EtherlabDaemon-20787   [000] .......  3001.164340: sys_exit: NR 44 = 874
< only now the packet is being handled >
      ksoftirqd/1-21      [001] d...2..  3001.164340: write_msr: 48, value 0
      ksoftirqd/1-21      [001] ...s.12  3001.164341: softirq_entry: vec=3 [action=NET_RX]
      ksoftirqd/1-21      [001] ...s.12  3001.164342: kmem_cache_alloc: call_site=__build_skb+0x1f/0xe0 ptr=000000006c4a30be bytes_req=224 bytes_alloc=256 gfp_flags=GFP_ATOMIC
      ksoftirqd/1-21      [001] ...s.12  3001.164342: napi_gro_receive_entry: dev=ecat0 napi_id=0x0 queue_mapping=1 skbaddr=000000006c4a30be vlan_tagged=0 vlan_proto=0x0000 vlan_tci=0x0000 protocol=0x88a4 ip_summed=0 hash=0x00000000 l4_hash=0 len=874 data_len=0 truesize=2304 mac_header_valid=1 mac_header=-14 nr_frags=0 gso_size=0 gso_type=0x0
      ksoftirqd/1-21      [001] ...s.12  3001.164342: napi_gro_receive_exit: ret=3
      ksoftirqd/1-21      [001] ...s.12  3001.164342: netif_receive_skb: dev=ecat0 skbaddr=000000006c4a30be len=874
      ksoftirqd/1-21      [001] ...s.12  3001.164343: napi_poll: napi poll on napi struct 0000000028309abc for device ecat0 work 1 budget 64
   EtherlabDaemon-20787   [000] ....1..  3001.164343: sys_futex(uaddr: 7f8d9fca7000, op: 1, val: 1, utime: 0, uaddr2: 5b9663, val3: bb9)
      ksoftirqd/1-21      [001] ...s.12  3001.164343: softirq_exit: vec=3 [action=NET_RX]
   EtherlabDaemon-20787   [000] .......  3001.164343: sys_enter: NR 202 (7f8d9fca7000, 1, 1, 0, 5b9663, bb9)
      ksoftirqd/1-21      [001] ...s.12  3001.164343: softirq_entry: vec=8 [action=HRTIMER]
