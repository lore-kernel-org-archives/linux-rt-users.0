Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5B3CF5E
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Aug 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683626; cv=none; b=qmrbr6+1ApLKXG/Hip7Be9oroqscU/qmirxJuvBE5myhlTRMcuEVY+CNkyu3Dj/IftsCUJ0jsS6qwHHTHWCU8FFxuRQcWJ0YzKZJIt9MYtEFzBIp/USdqXxL8lvUEuikWRu3UnC4ov1Zh903RlBTKJ88tTasm6emi37j71FZnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683626; c=relaxed/simple;
	bh=NrDxDTywIZAKLZIzKY4EDjeRZ2cv3FPGu36veFA7nBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwGqmuZKy0NashiMv6W+wfe9ZMF22jfzwRVC0jmysw/t4tOm04GgW6gAWM40eFomc657TeMQsQhlG2J2sA89f3C43b4NHBUu2Sv09DUwIkomDvo0U+b55yh1zp66IWHPuEb7wQKFHyaQOBaIj4SO4zvYAmDBm01lF8XL8y8jxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2xyVU3P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2xyVU3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724683622;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=e0dTEudDpX+aw1prbYiOhAa1VTgUH4ryoWKKV7V+mVY=;
	b=A2xyVU3P6nATl/8tHKjgVfOxTgZq/5wulbJvAF/f9xM/d9O8T3WiHvlXE/TnjKQTGz28fR
	CpyvbpuX3YGJTDmIx0rqB/0Sa58D3LyEtAGztMjFGg4AIhVv1CC2RYGmpFIQlxQv6f742f
	AQ9rf6adS382EkexXOxpPuh5gLj+tz4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-lVN0oPGuMSqI5oETOMjfcg-1; Mon,
 26 Aug 2024 10:46:58 -0400
X-MC-Unique: lVN0oPGuMSqI5oETOMjfcg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 265831955EB3;
	Mon, 26 Aug 2024 14:46:57 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.65.37])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B04E19560AE;
	Mon, 26 Aug 2024 14:46:55 +0000 (UTC)
Date: Mon, 26 Aug 2024 10:46:52 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: pmaldek@suse.com, williams@redhat.com, john.ogness@linutronix.de,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: test 1: was: Re: A Comparison of printk between upstream and
 linux-rt-devel
Message-ID: <ZsyVXMqM2SK0aYyV@debarbos-thinkpadt14sgen2i.remote.csb>
Reply-To: debarbos@redhat.com
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZshiIdUFQs4CKW2t@pathway.suse.cz>
 <Zsjd0WUNIU8_kprt@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZsyK-s2D8eqqBrXU@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uUAiRA6JiMMv6L5l"
Content-Disposition: inline
In-Reply-To: <ZsyK-s2D8eqqBrXU@pathway.suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--uUAiRA6JiMMv6L5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2024 at 04:02:34PM +0200, Petr Mladek wrote:
> > If you have any other questions, please let me know. I would be happy to re-do
> > these tests with different kernels, configs + other variables and controls.
> 
> It might be interesting to redo the 1st test without the crashdump.
> I wonder if console_flush_on_panic() would allow to see the panic
> backtrace with the stock kernel.

Sure. 

I disabled the systemd kdump service unit via systemctl, and performed a reboot
to ensure that the crashkernel would not be armed.

Performing a trial run of console_blast.sh shows results similar to what was
documented previously, with the difference being we don't reboot after the test
is completed and the kernel has effectively "crashed" via the sysrq-trigger.

I have appended the serial console output as an attachment. You will see that we
do not get a final trace printed.

--uUAiRA6JiMMv6L5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="console_blast_nocrashdump_output.txt"

[   98.341743] sysrq: Show State
[   98.341746] sysrq: Show State
[   98.341805] sysrq: Show State
[   98.341808] sysrq: Show State
[   98.341812] task:systemd         state:S
[   98.341814] task:systemd         state:S
[   98.341814]  stack:0     pid:1     tgid:1     ppid:0      flags:0x00000002
[   98.341818]  stack:0     pid:1     tgid:1     ppid:0      flags:0x00000002
[   98.341819] Call Trace:
[   98.341822]  <TASK>
[   98.341823] Call Trace:
[   98.341826]  <TASK>
** 1350 printk messages dropped **
[   98.343803]  __schedule+0x239/0x5f0
** 6045 printk messages dropped **
[   98.352944] task:ksoftirqd/0     state:S
** 3818 printk messages dropped **
[   98.358691]  </TASK>
** 3993 printk messages dropped **
[   98.364724]  __schedule+0x239/0x5f0
** 5827 printk messages dropped **
[   98.373395]  stack:0     pid:95    tgid:95    ppid:2      flags:0x00004000
** 9347 printk messages dropped **
[   98.388519]  stack:0     pid:127   tgid:127   ppid:2      flags:0x00004000
** 10901 printk messages dropped **
[   98.428235] task:irq/41-AMD-Vi5- state:S
** 5360 printk messages dropped **
[   98.448338] task:hwrng           state:S
** 12329 printk messages dropped **
[   98.493601]  ? __pfx_scsi_error_handler+0x10/0x10
** 7339 printk messages dropped **
[   98.520931]  stack:0     pid:771   tgid:771   ppid:2      flags:0x00004000
** 7980 printk messages dropped **
[   98.550662] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fde360a3e69
** 10491 printk messages dropped **
[   98.590210] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdf45e7ae69
** 6175 printk messages dropped **
[   98.613575] RBP: 00007fdf449fead0 R08: 0000000000000000 R09: 00000000ffffffff
** 6567 printk messages dropped **
[   98.638339]  __x64_sys_poll+0x59/0x180
** 4245 printk messages dropped **
[   98.654313]  futex_wait_queue+0x65/0x90
** 4170 printk messages dropped **
[   98.670528]  stack:0     pid:1088  tgid:1069  ppid:1      flags:0x00000002
** 5860 printk messages dropped **
[   98.692918]  ORIG_RAX: 00000000000000e8
** 6133 printk messages dropped **
[   98.715895] RAX: ffffffffffffffda RBX: 00007ff74b0a9071 RCX: 00007ff74aeefa3d
** 8880 printk messages dropped **
[   98.749867] pool_workqueue_     3      1042.492756 E      1045.469652         3.000000         0.051366         7   120 
** 8053 printk messages dropped **
[   98.780632]         cpuhp/2    30      2760.969419 E      2763.960963         3.000000         0.325397        23   120 
** 7113 printk messages dropped **
[   98.807874]   .runnable_avg                  : 2048
** 5955 printk messages dropped **
[   98.830905]   kworker/u66:0   115      3624.712749 E      3627.712749         3.000000         0.069703        24   120 
** 7813 printk messages dropped **
[   98.860747]  worker_thread+0x1a2/0x390
** 3940 printk messages dropped **
[   98.875565]   .se->avg.runnable_avg          : 1024
** 4439 printk messages dropped **
[   98.892516]   .load                          : 0
** 4316 printk messages dropped **
[   98.908795]   kworker/u78:0   377        26.095030 E        26.129621         3.000000         0.006783         2   100 
** 11021 printk messages dropped **
[   98.950039] kworker/R-poll_   663      2129.785864 E      2129.820473         3.000000         0.009758         2   100 
** 12070 printk messages dropped **
[   98.995818]    kworker/15:0   112       388.594071 E       391.518359         3.000000         0.200603        30   120 
** 9029 printk messages dropped **
[   99.029797]    kworker/11:3  1404      4722.119837 E      4725.119837         3.000000         0.014217         6   120 
** 14700 printk messages dropped **
[   99.084709]    kworker/12:3   870      6965.176567 E      6967.207380         3.000000         0.978895         4   120 
** 8720 printk messages dropped **
[   99.117156]       scsi_eh_3   664      2046.903863 E      2049.769971         3.000000         0.231857        25   120 
** 8954 printk messages dropped **
[   99.149857]  stack:0     pid:1012  tgid:1012  ppid:2      flags:0x00004000
** 6789 printk messages dropped **
[   99.174901]  schedule+0x27/0xa0
** 3892 printk messages dropped **
[   99.188911] Call Trace:
** 3791 printk messages dropped **
[   99.203198]  I
** 3202 printk messages dropped **
[   99.215003]   kworker/u67:2   125         0.212548 E         2.041034         3.000000         3.071572         4   120 
** 10803 printk messages dropped **
[   99.254737]  ? __pte_offset_map+0x1b/0x130
** 8126 printk messages dropped **
[   99.284122]  /autogroup-92
** 3600 printk messages dropped **
[   99.297505] R13: 00005584f871fdc0 R14: 0000000000000020 R15: 0000000000000014
** 9498 printk messages dropped **
[   99.330610]   .util_est                      : 535
** 4236 printk messages dropped **
[   99.346220]         systemd     1        20.955195 E        23.538484         3.000000      3629.255728      3514   120 
** 11375 printk messages dropped **
[   99.388429]  idle_inject/12    91        -2.089838 E         0.906384         3.000000         0.012314         3    49 
** 11652 printk messages dropped **
[   99.431180]  schedule+0x27/0xa0
** 3668 printk messages dropped **
[   99.444182]  __schedule+0x239/0x5f0
** 5327 printk messages dropped **
[   99.463782]   idle_inject/1    25        -2.447341 E        -1.699525         0.750000         0.007383         3    49 
** 8111 printk messages dropped **
[   99.492999]  ret_from_fork_asm+0x1a/0x30
** 5359 printk messages dropped **
[   99.512530]  <TASK>
** 3485 printk messages dropped **
[   99.525227]  smpboot_thread_fn+0x14c/0x1d0
** 7829 printk messages dropped **
[   99.553923]  do_syscall_64+0x7d/0x160
** 4683 printk messages dropped **
[   99.570522]  ret_from_fork_asm+0x1a/0x30
** 4854 printk messages dropped **
[   99.587933]  ? worker_thread+0x1a2/0x390
** 4534 printk messages dropped **
[   99.604401]   kworker/u67:3   128       125.773092 E       128.547617         3.000000         2.124072         4   120 
** 21175 printk messages dropped **
[   99.682300]         0.000000         0.012444         0.000000         0.000000
** 7311 printk messages dropped **
[   99.708490] irq/34-AMD-Vi2-   186         7.151218 E        10.149175         3.000000         0.009668         3    49 
** 11867 printk messages dropped **
[   99.751749]    kworker/15:1   157       363.524100 E       366.518580         3.000000         0.232434        43   120 
** 7875 printk messages dropped **
[   99.780018] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 25 85 10 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
** 17673 printk messages dropped **
[   99.844950]       JS Helper  1082         0.980940 E         1.987451         3.000000         0.094819         9   120 
** 7557 printk messages dropped **
[   99.872930]    kworker/15:5   439      7276.089825 E      7278.500921         3.000000        15.507625       386   120 
** 7709 printk messages dropped **
[   99.901167]   systemd-udevd   869       130.203124 E       132.702555         3.000000       144.278303       794   120 
** 7793 printk messages dropped **
[   99.929998]  ? __pfx_kthread+0x10/0x10
** 3480 printk messages dropped **
[   99.942453]   .avg_idle                      : 1000000
** 4516 printk messages dropped **
[   99.959201]   .min_vruntime                  : 24352.261421
** 5470 printk messages dropped **
[   99.978045]   .left_vruntime                 : 0.000001
** 5823 printk messages dropped **
[   99.999451]   .min_vruntime                  : 25028.715552
** 5514 printk messages dropped **
[  100.019806]       rhsmcertd  1116         0.275586 E         2.583710         3.000000         0.848441         4   120 
** 14214 printk messages dropped **
[  100.071819]  worker_thread+0x1a2/0x390
** 4599 printk messages dropped **
[  100.087304] R13: 0000000000000000 R14: 0000000000000000 R15: 00005617d179d048
** 10717 printk messages dropped **
[  100.126593] Workqueue:  0x0
** 4547 printk messages dropped **
[  100.143104]  stack:0     pid:670   tgid:670   ppid:2      flags:0x00004000
** 15605 printk messages dropped **
[  100.200055]  stack:0     pid:166   tgid:166   ppid:2      flags:0x00004000
** 13310 printk messages dropped **
[  100.248464]   kworker/u65:0   114      4702.709127 E      4705.708326         3.000000         0.183141        58   120 
** 9677 printk messages dropped **
[  100.283243]     ksoftirqd/1    27      3330.798741 E      3333.774786         3.000000         1.475125        18   120 
** 9056 printk messages dropped **
[  100.316067] task:lsmd            state:S
** 4344 printk messages dropped **
[  100.332442] console_blast.s  1493      1991.029033 E      1991.034878         3.000000      1987.212265         7   120 
** 12893 printk messages dropped **
[  100.380006]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
** 7320 printk messages dropped **
[  100.407334] 
** 3868 printk messages dropped **
[  100.421585]         0.000000        14.023881         0.000000         0.000000
** 5330 printk messages dropped **
[  100.441235]   .se->exec_start                : 100146.499911
** 4222 printk messages dropped **
[  100.456794]   .runnable_avg                  : 1024
** 5825 printk messages dropped **
[  100.478193]         0.000000         0.012182         0.000000         0.000000
** 8258 printk messages dropped **
[  100.506381]  ret_from_fork_asm+0x1a/0x30
** 5162 printk messages dropped **
[  100.524495]            sshd  1418         0.931527 E         1.980859         3.000000        24.905877        90   120 
** 8990 printk messages dropped **
[  100.555956]  0 0
** 3100 printk messages dropped **
[  100.566705]  (events_unbound)
** 4345 printk messages dropped **
[  100.581791]  smpboot_thread_fn+0x14c/0x1d0
** 4108 printk messages dropped **
[  100.596361]         0.000000         0.008125         0.000000         0.000000
** 9513 printk messages dropped **
[  100.626841]         0.000000         0.006113         0.000000         0.000000
** 6440 printk messages dropped **
[  100.650932]  ? __pfx_kthread+0x10/0x10
** 7186 printk messages dropped **
[  100.676636]  stack:0     pid:381   tgid:381   ppid:2      flags:0x00004000
** 7060 printk messages dropped **
[  100.702273] RBP: 00005602f7407b30 R08: 0000000000000016 R09: 0000000000000000
** 14457 printk messages dropped **
[  100.755003] task:kworker/R-xfs-r state:I
** 5134 printk messages dropped **
[  100.773707] R10: 000055c7afadb860 R11: 0000000000000202 R12: 000055c792d450c0
** 6788 printk messages dropped **
[  100.798445]  stack:0     pid:85    tgid:85    ppid:2      flags:0x00004000
** 6419 printk messages dropped **
[  100.821490]  stack:0     pid:154   tgid:154   ppid:2      flags:0x00004000
** 6621 printk messages dropped **
[  100.845334]   .left_vruntime                 : 37402.510787
** 7707 printk messages dropped **
[  100.873425]  stack:0     pid:19    tgid:19    ppid:2      flags:0x00004000
** 6056 printk messages dropped **
[  100.895888]            ptp0   648       998.061323 E      1001.060691         3.000000         0.010931         2   120 
** 12633 printk messages dropped **
[  100.942960]         kswapd1   203       205.593831 E       208.588851         3.000000         0.025931         4   120 
** 8278 printk messages dropped **
[  100.973458] RDX: 0000000000000002 RSI: 00005613a7d5b2b0 RDI: 0000000000000001
** 6292 printk messages dropped **
[  100.996349]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
** 10333 printk messages dropped **
[  101.034626] kworker/R-kdmfl   989      2909.203729 E      2909.238322         3.000000         0.012063         2   100 
** 11900 printk messages dropped **
[  101.078426]         0.000000         1.887273         0.000000         0.000000
** 6428 printk messages dropped **
[  101.101895]          auditd  1029         0.813874 E         0.412617         3.000000         0.485911         9   116 
** 8867 printk messages dropped **
[  101.133321] 
** 4424 printk messages dropped **
[  101.149064]  stack:0     pid:998   tgid:998   ppid:2      flags:0x00004000
** 6603 printk messages dropped **
[  101.173166]   .tg_load_avg                   : 0
** 5270 printk messages dropped **
[  101.192755]         cpuhp/9    72      3253.739537 E      3256.736331         3.000000         0.221890        23   120 
** 15114 printk messages dropped **
[  101.246932]  __schedule+0x239/0x5f0
** 6146 printk messages dropped **
[  101.268515]  (xfs-buf/dm-0)
** 3758 printk messages dropped **
[  101.282435]  stack:0     pid:178   tgid:178   ppid:2      flags:0x00004000
** 6261 printk messages dropped **
[  101.305606]  ? syscall_exit_work+0xf3/0x120
** 6413 printk messages dropped **
[  101.329925]   kworker/u69:3   129      1893.152582 E      1896.144557         3.000000         7.438325         5   120 
** 8472 printk messages dropped **
[  101.361810]   kworker/u67:3   128       125.773092 E       128.547617         3.000000         2.124072         4   120 
** 8139 printk messages dropped **
[  101.392857]         0.000000       709.586689         0.000000         0.000000
** 6756 printk messages dropped **
[  101.418896]   .load_avg                      : 0
** 6408 printk messages dropped **
[  101.442924]  stack:0     pid:63    tgid:63    ppid:2      flags:0x00004000
** 6333 printk messages dropped **
[  101.466555]  ? __pfx_autoremove_wake_function+0x10/0x10
** 5576 printk messages dropped **
[  101.487197]  </TASK>
** 4249 printk messages dropped **
[  101.502377] console_blast.s  1491      3168.100729 E      3171.100729         3.000000      3147.080014         9   120 
** 7585 printk messages dropped **
[  101.531561] irq/46-AMD-Vi6-   198         0.713045 E         3.710410         3.000000         0.014817         3    49 
** 10598 printk messages dropped **
[  101.570178]   .se->sum_exec_runtime          : 3176.794321
** 4981 printk messages dropped **
[  101.589033]  schedule+0x27/0xa0
** 5551 printk messages dropped **
[  101.609818]  __schedule+0x239/0x5f0
** 3840 printk messages dropped **
[  101.624735] RBP: 00007ffd84a1ed00 R08: 0000000000000000 R09: 00007ffd84a1ecd0
** 10002 printk messages dropped **
[  101.662499]  ret_from_fork_asm+0x1a/0x30
** 5288 printk messages dropped **
[  101.682268] R10: 00000000ffffffff R11: 0000000000000293 R12: 00000000000002ee
** 12090 printk messages dropped **
[  101.726798] task:kworker/R-xfs-r state:I
** 7665 printk messages dropped **
[  101.755562]  stack:0     pid:1058  tgid:1058  ppid:1      flags:0x00000002
** 6324 printk messages dropped **
[  101.779530]   idle_inject/5    49        -2.294525 E         0.046670         2.250000         0.006113         3    49 
** 16102 printk messages dropped **
[  101.840125] RDX: 0000000000000000 RSI: 000055ea3c6fe1e0 RDI: 0000000000000007
** 7245 printk messages dropped **
[  101.867436]  ? __folio_mod_stat+0x26/0x80
** 7629 printk messages dropped **
[  101.895865]  idle_inject/10    79        -2.150560 E         0.845593         3.000000         0.012062         3    49 
** 9216 printk messages dropped **
[  101.930926] kworker/R-kalua   227       871.610895 E       871.645504         3.000000         0.000000         2   100 
** 9625 printk messages dropped **
[  101.967553]  ? do_syscall_64+0x89/0x160
** 4339 printk messages dropped **
[  101.983995] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: 000055f5524344e0
** 6795 printk messages dropped **
[  102.009680]   .rt_runtime                    : 950.000000
** 5367 printk messages dropped **
[  102.028451] -------------------------------------------------------------------------------------------------------------
** 15405 printk messages dropped **
[  102.085534] console_blast.s  1491      3749.584541 E      3752.584541         3.000000      3728.563826         9   120 
** 8261 printk messages dropped **
[  102.114810]           cupsd  1109         2.132265 E         5.126905         3.000000        14.023881        53   120 
** 7662 printk messages dropped **
[  102.141874]    kworker/13:1   140     62540.755036 E     62543.155221         3.000000        96.156447       368   120 
** 10713 printk messages dropped **
[  102.179996]  ? __pfx_kthread+0x10/0x10
** 6255 printk messages dropped **
[  102.203337] irq/45-AMD-Vi6-   197         0.706323 E         3.703758         3.000000         0.018205         3    49 
** 9498 printk messages dropped **
[  102.237757]  stack:0     pid:22    tgid:22    ppid:2      flags:0x00004000
** 11393 printk messages dropped **
[  102.279056]  stack:0     pid:73    tgid:73    ppid:2      flags:0x00004000
** 6900 printk messages dropped **
[  102.304230]  stack:0     pid:1028  tgid:1028  ppid:1      flags:0x00000002
** 9625 printk messages dropped **
[  102.339190]         0.000000         0.193222         0.000000         0.000000
** 6451 printk messages dropped **
[  102.362643]        cpuhp/15   108      4349.941258 E      4352.935137         3.000000         0.222137        24   120 
** 8473 printk messages dropped **
[  102.392796]  __schedule+0x239/0x5f0
** 7173 printk messages dropped **
[  102.418070]  ? syscall_exit_to_user_mode+0x10/0x1f0
** 9517 printk messages dropped **
[  102.451940] RSP: 002b:00007fff4c702cb8 EFLAGS: 00000246
** 9910 printk messages dropped **
[  102.487097]   .se->load.weight               : 65950
** 5086 printk messages dropped **
[  102.505010]  1 0
** 2807 printk messages dropped **
[  102.514015]   .avg_vruntime                  : -1.029731
** 4159 printk messages dropped **
[  102.528844]         0.000000        11.363456         0.000000         0.000000
** 5366 printk messages dropped **
[  102.546605]         0.000000         0.240332         0.000000         0.000000
** 5869 printk messages dropped **
[  102.568413]  ? __folio_mod_stat+0x26/0x80
** 5498 printk messages dropped **
[  102.588620]  stack:0     pid:425   tgid:425   ppid:2      flags:0x00004000
** 6326 printk messages dropped **
[  102.611715]  ? __pfx_kthread+0x10/0x10
** 5209 printk messages dropped **
[  102.630610] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000008
** 10164 printk messages dropped **
[  102.667791]  ? syscall_exit_to_user_mode+0x10/0x1f0
** 8177 printk messages dropped **
[  102.697594]  <TASK>
** 4916 printk messages dropped **
[  102.715162]         0.000000         4.110088         0.000000         0.000000
** 6099 printk messages dropped **
[  102.737522]  ? __pfx_worker_thread+0x10/0x10
** 4535 printk messages dropped **
[  102.754256]  stack:0     pid:752   tgid:752   ppid:2      flags:0x00004000
** 9417 printk messages dropped **
[  102.788681]  stack:0     pid:421   tgid:421   ppid:2      flags:0x00004000
** 6738 printk messages dropped **
[  102.813132] irq/35-AMD-Vi3-   187         0.642773 E         3.639858         3.000000         0.018896         3    49 
** 9083 printk messages dropped **
[  102.846624]  stack:0     pid:120   tgid:120   ppid:2      flags:0x00004000
** 12934 printk messages dropped **
[  102.894139]         0.000000         0.007435         0.000000         0.000000
** 11060 printk messages dropped **
[  102.935083]         0.000000         2.506764         0.000000         0.000000
** 6877 printk messages dropped **
[  102.959432]         0.000000        38.780064         0.000000         0.000000
** 7950 printk messages dropped **
[  102.988071]  __x64_sys_poll+0x59/0x180
** 6727 printk messages dropped **
[  103.012816]   kworker/13:1H   561       198.033011 E       198.067595         3.000000         0.009438         2   100 
** 7599 printk messages dropped **
[  103.040431]  schedule+0x27/0xa0
** 5447 printk messages dropped **
[  103.060389]   .dl_bw->bw                     : 996147
** 4495 printk messages dropped **
[  103.076994]    in:imjournal  1406       368.106769 E       369.366368         3.000000       395.505698     10928   120 
** 7932 printk messages dropped **
[  103.104983]  stack:0     pid:1404  tgid:1404  ppid:2      flags:0x00004000
** 12115 printk messages dropped **
[  103.148210]  ? __pfx_autoremove_wake_function+0x10/0x10
** 5517 printk messages dropped **
[  103.168034]  ret_from_fork_asm+0x1a/0x30
** 6273 printk messages dropped **
[  103.191022]         0.000000         2.701816         0.000000         0.000000
** 7200 printk messages dropped **
[  103.216724] RBP: 00007fde34bffb90 R08: 0000000000000000 R09: 00000000ffffffff
** 7445 printk messages dropped **
[  103.243418]  ? __pfx_kthread+0x10/0x10
** 4616 printk messages dropped **
[  103.260469]     kworker/1:2   781      3306.604194 E      3309.599255         3.000000         0.019748         4   120 
** 13479 printk messages dropped **
[  103.310261]   kworker/11:1H   440      4880.944166 E      4880.978742         3.000000         0.045865         9   100 
** 8234 printk messages dropped **
[  103.341339]         0.000000         0.009908         0.000000         0.000000
** 10434 printk messages dropped **
[  103.380954] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe6893eb50
** 6505 printk messages dropped **
[  103.405612]   .load_avg                      : 1024
** 6749 printk messages dropped **
[  103.431392]  ret_from_fork+0x34/0x50
** 3798 printk messages dropped **
[  103.445647]         0.000000         0.009739         0.000000         0.000000
** 6551 printk messages dropped **
[  103.470582]         0.000000         0.094819         0.000000         0.000000
** 9097 printk messages dropped **
[  103.505087]         kswapd0   202         2.388468 E         5.383258         3.000000         0.015649         3   120 
** 8180 printk messages dropped **
[  103.536168]   .removed.util_avg              : 0
** 7856 printk messages dropped **
[  103.564502]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
** 9064 printk messages dropped **
[  103.598940]         0.000000         4.903896         0.000000         0.000000
** 8850 printk messages dropped **
[  103.631536]  kthread+0xd2/0x100
** 3683 printk messages dropped **
[  103.645436]     migration/3    38       115.633036 E       116.382425         0.750000       286.756541        41     0 
** 8042 printk messages dropped **
[  103.675608] RAX: ffffffffffffffda RBX: 0000563ad359e0a0 RCX: 00007efc39017734
** 8681 printk messages dropped **
[  103.708653]  ? __pfx_kthread+0x10/0x10
** 6598 printk messages dropped **
[  103.733940]     kworker/8:2   631     72409.572790 E     72412.567831         3.000000       275.658656       583   120 
** 10190 printk messages dropped **
[  103.772320]  ? __memcg_slab_free_hook+0x100/0x150
** 5115 printk messages dropped **
[  103.791666]    kworker/14:1   165     82322.495015 E     82325.495015         3.000000        64.376292       386   120 
** 8688 printk messages dropped **
[  103.824561]    ksoftirqd/13    99      6056.156487 E      6059.146759         3.000000         0.741543        28   120 
** 12308 printk messages dropped **
[  103.869906] RAX: ffffffffffffffda RBX: 00007fb2b8b9c071 RCX: 00007fb2b8904a3d
** 10918 printk messages dropped **
[  103.911459] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
** 9629 printk messages dropped **
[  103.947621]  stack:0     pid:1355  tgid:1121  ppid:1      flags:0x00000002
** 5672 printk messages dropped **
[  103.968986]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
** 4814 printk messages dropped **
[  103.987200]  ? __pfx_irq_thread+0x10/0x10
** 5441 printk messages dropped **
[  104.007722]   kworker/u67:3   128       125.773092 E       128.547617         3.000000         2.124072         4   120 
** 8134 printk messages dropped **
[  104.038709]   kworker/u67:5   131      3427.633945 E      3430.630719         3.000000         2.296438       132   120 
** 8813 printk messages dropped **
[  104.072549]   .util_est                      : 0
** 8347 printk messages dropped **
[  104.103215]      khugepaged   150     74351.109753 E     74507.582619         3.000000        31.287398        32   139 
** 14583 printk messages dropped **
[  104.157291]  ? syscall_exit_to_user_mode+0x10/0x1f0
** 4833 printk messages dropped **
[  104.174937]  ret_from_fork_asm+0x1a/0x30
** 6370 printk messages dropped **
[  104.197595] systemd-journald[853]: /dev/kmsg buffer overrun, some messages lost.
** 6413 printk messages dropped **
[  104.220209]   .rt_nr_running                 : 0
** 6795 printk messages dropped **
[  104.244422]           tuned  1356         5.158960 E         8.036931         3.000000         0.122029         1   120 
** 11399 printk messages dropped **
[  104.283622] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3e8237f317
** 9411 printk messages dropped **
[  104.317155]  ? print_worker_info.cold+0x12/0x41
** 4916 printk messages dropped **
[  104.335038]  ret_from_fork+0x34/0x50
** 4485 printk messages dropped **
[  104.351190]   .throttle_count                : 0
** 4945 printk messages dropped **
[  104.369480] kworker/R-scsi_   628       359.262986 E       359.297581         3.000000         0.004379         2   100 
** 9464 printk messages dropped **
[  104.404181]    kworker/10:5  1139      3389.408402 E      3392.406799         3.000000         0.008125         2   120 
** 11998 printk messages dropped **
[  104.448365]    in:imjournal  1406        21.367964 E        24.367964         3.000000       497.349101     15636   120 
** 8263 printk messages dropped **
[  104.478774]   .next_balance                  : 4294.769551
** 5433 printk messages dropped **
[  104.498760]  idle_inject/11    85        -2.132842 E         0.864873         3.000000         0.005792         3    49 
** 9212 printk messages dropped **
[  104.532505] kworker/R-rcu_g     4       100.284798 E       100.293433         0.750000         0.003276         2   100 
** 15552 printk messages dropped **
[  104.589378] Call Trace:
** 4067 printk messages dropped **
[  104.602428]  stack:0     pid:1013  tgid:1013  ppid:2      flags:0x00004000
** 9060 printk messages dropped **
[  104.635126]         0.000000         0.000000         0.000000         0.000000
** 6131 printk messages dropped **
[  104.657252]          smartd  1070        16.529546 E        19.467860         3.000000        17.780391        35   120 
** 15886 printk messages dropped **
[  104.714923]  stack:0     pid:117   tgid:117   ppid:2      flags:0x00004000
** 6771 printk messages dropped **
[  104.739775]  kthread+0xd2/0x100
** 3980 printk messages dropped **
[  104.754074]  stack:0     pid:159   tgid:159   ppid:2      flags:0x00004000
** 6700 printk messages dropped **
[  104.778059]  ret_from_fork_asm+0x1a/0x30
** 6195 printk messages dropped **
[  104.800431]  ? __pfx_kthread+0x10/0x10
** 4276 printk messages dropped **
[  104.815527]  schedule+0x27/0xa0
** 5034 printk messages dropped **
[  104.834379] kworker/R-xfs-i  1011      2926.826361 E      2926.860963         3.000000         0.005520         2   100 
** 8618 printk messages dropped **
[  104.866341]  0 0
** 4603 printk messages dropped **
[  104.883115] RBP: 00007f3e809ffb50 R08: 0000000000000000 R09: 00000000ffffffff
** 10814 printk messages dropped **
[  104.922759]      sedispatch  1030         0.910163 E         0.312838         3.000000         4.318776       104   116 
** 13016 printk messages dropped **
[  104.971021] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: 000055b963b33b50
** 6343 printk messages dropped **
[  104.993920]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
** 6930 printk messages dropped **
[  105.019293]   .util_est                      : 0
** 4502 printk messages dropped **
[  105.035557] RAX: ffffffffffffffda RBX: 00007f1f7318c071 RCX: 00007f1f72fa4a3d
** 9377 printk messages dropped **
[  105.070072]    migration/14   104       118.044946 E       118.794946         0.750000         2.997975        46     0 
** 9793 printk messages dropped **
[  105.106137]  ? do_syscall_64+0x89/0x160
** 4776 printk messages dropped **
[  105.123636]  schedule+0x27/0xa0
** 4234 printk messages dropped **
[  105.139144]       kdevtmpfs   136      2994.081650 E      2997.040954         3.000000         3.063475       186   120 
** 12016 printk messages dropped **
[  105.183350]     ksoftirqd/5    51      3259.571146 E      3262.571146         3.000000         1.059236        13   120 
** 12272 printk messages dropped **
[  105.228882]   .min_vruntime                  : 21.980250
** 5592 printk messages dropped **
[  105.249274] task:migration/3     state:S
** 6533 printk messages dropped **
[  105.273508]   .removed.runnable_avg          : 0
** 5008 printk messages dropped **
[  105.291568]    pool-spawner  1130         0.871916 E         2.079774         3.000000         0.176660         3   120 
** 11149 printk messages dropped **
[  105.332989]  __schedule+0x239/0x5f0
** 5897 printk messages dropped **
[  105.354682]    ksoftirqd/11    87    101947.356432 E    101949.617326         3.000000         1.973687        28   120 
** 10975 printk messages dropped **
[  105.394430]         0.000000      6908.955084         0.000000         0.000000
** 9273 printk messages dropped **
[  105.427571]     kworker/3:1   163     86545.454294 E     86547.498382         3.000000         2.489019       143   120 
** 12064 printk messages dropped **
[  105.470090] R10: 00007fff4c702d20 R11: 0000000000000202 R12: 0000000000000000
** 6353 printk messages dropped **
[  105.492695]  kthread+0xd2/0x100
** 3700 printk messages dropped **
[  105.506244]  stack:0     pid:83    tgid:83    ppid:2      flags:0x00004000
** 9204 printk messages dropped **
[  105.539481]  ? __handle_mm_fault+0x2e8/0x720
** 4711 printk messages dropped **
[  105.557033]  __schedule+0x239/0x5f0
** 4302 printk messages dropped **
[  105.572709]  (kblockd)
** 3758 printk messages dropped **
[  105.586751]  ? __count_memcg_events+0x58/0xf0
** 5580 printk messages dropped **
[  105.606757]  stack:0     pid:182   tgid:182   ppid:2      flags:0x00004000
** 12168 printk messages dropped **
[  105.651228] -------------------------------------------------------------------------------------------------------------
** 9205 printk messages dropped **
[  105.685276]   .min_vruntime                  : 2320.880111
** 5345 printk messages dropped **
[  105.704832]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
** 10135 printk messages dropped **
[  105.742254]  ? __pfx_rescuer_thread+0x10/0x10
** 8327 printk messages dropped **
[  105.772985]         0.000000         0.016491         0.000000         0.000000
** 6738 printk messages dropped **
[  105.797393]         0.000000         0.016430         0.000000         0.000000
** 9233 printk messages dropped **
[  105.831352] kworker/R-scsi_   669      2084.021290 E      2084.055889         3.000000         0.007765         2   100 
** 8960 printk messages dropped **
[  105.864048]     kworker/5:0    52      2741.307369 E      2744.299855         3.000000         0.019558         6   120 
** 8736 printk messages dropped **
[  105.896141]         0.000000         0.006994         0.000000         0.000000
** 6042 printk messages dropped **
[  105.918624]         0.000000         0.024927         0.000000         0.000000
** 5781 printk messages dropped **
[  105.939854] irq/34-AMD-Vi2-   186         7.151218 E        10.149175         3.000000         0.009668         3    49 
** 10345 printk messages dropped **
[  105.978291]  /
** 3756 printk messages dropped **
[  105.991862]   .throttle_count                : 0
** 4772 printk messages dropped **
[  106.009274]   .se->exec_start                : 105941.836413
** 6941 printk messages dropped **
[  106.034546]   .nr_spread_over                : 0
** 6037 printk messages dropped **
[  106.056439]       JS Helper  1089         0.728877 E         2.267847         3.000000         0.073408        10   120 
** 8772 printk messages dropped **
[  106.086970]  rescuer_thread+0x391/0x480
** 6294 printk messages dropped **
[  106.109013]  ? __pfx_worker_thread+0x10/0x10
** 4105 printk messages dropped **
[  106.123766]  __schedule+0x239/0x5f0
** 5587 printk messages dropped **
[  106.142502]   kworker/15:1H   175      4713.431491 E      4713.466100         3.000000         0.016423         6   100 
** 8794 printk messages dropped **
[  106.171729] RSP: 002b:00007ffeb95e7c80 EFLAGS: 00000202
** 5450 printk messages dropped **
[  106.190608] Call Trace:
** 7554 printk messages dropped **
[  106.216813]  stack:0     pid:768   tgid:768   ppid:2      flags:0x00004000
** 7412 printk messages dropped **
[  106.242713]  ? switch_fpu_return+0x4e/0xd0
** 4917 printk messages dropped **
[  106.260453]         0.000000         0.004379         0.000000         0.000000
** 10257 printk messages dropped **
[  106.298066]     kworker/0:4   230       979.459064 E       982.456039         3.000000        30.951059        10   120 
** 8938 printk messages dropped **
[  106.331568]  do_syscall_64+0x7d/0x160
** 4507 printk messages dropped **
[  106.348362]  ? __pfx_worker_thread+0x10/0x10
** 4808 printk messages dropped **
[  106.365956] RAX: ffffffffffffffda RBX: 00007ffc0978e080 RCX: 00007f188e6289f8
** 8532 printk messages dropped **
[  106.397197] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
** 6075 printk messages dropped **
[  106.420184] -------------------------------------------------------------------------------------------------------------
** 9894 printk messages dropped **
[  106.456993]         0.000000         0.646502         0.000000         0.000000
** 6524 printk messages dropped **
[  106.480976]  stack:0     pid:156   tgid:156   ppid:2      flags:0x00004000
** 5860 printk messages dropped **
[  106.502493]   .avg_vruntime                  : 135202.191522
** 4897 printk messages dropped **
[  106.518967]  do_syscall_64+0x7d/0x160
** 5231 printk messages dropped **
[  106.538230]  __x64_sys_futex+0x127/0x1e0
** 4240 printk messages dropped **
[  106.553886]  ? syscall_exit_to_user_mode+0x10/0x1f0
** 9525 printk messages dropped **
[  106.589827] -------------------------------------------------------------------------------------------------------------
** 9394 printk messages dropped **
[  106.625466]         0.000000         2.042591         0.000000         0.000000
** 9557 printk messages dropped **
[  106.660306]  S
** 2961 printk messages dropped **
[  106.671000]  ? __pfx_irq_thread_dtor+0x10/0x10
** 5052 printk messages dropped **
[  106.688784]   .clock                         : 106688.193646
** 10128 printk messages dropped **
[  106.725746]  stack:0     pid:48    tgid:48    ppid:2      flags:0x00004000
** 10958 printk messages dropped **
[  106.765912] 
** 4597 printk messages dropped **
[  106.782904]   .exec_clock                    : 0.000000
** 5576 printk messages dropped **
[  106.802911]   kworker/11:1H   440      4880.944166 E      4880.978742         3.000000         0.045865         9   100 
** 8201 printk messages dropped **
[  106.832191]         0.000000         0.043071         0.000000         0.000000
** 5901 printk messages dropped **
[  106.853896]       JS Helper  1089         0.728877 E         2.267847         3.000000         0.073408        10   120 
** 9228 printk messages dropped **
[  106.887417]  stack:0     pid:660   tgid:660   ppid:2      flags:0x00004000
** 10779 printk messages dropped **
[  106.927012]   kworker/u69:3   129      1893.152582 E      1896.144557         3.000000         7.438325         5   120 
** 13989 printk messages dropped **
[  106.976441]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
** 12476 printk messages dropped **
[  107.021838]  ? sysrq_handle_showstate+0x10/0x20
** 5775 printk messages dropped **
[  107.042739] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
** 10044 printk messages dropped **
[  107.077999] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
** 7384 printk messages dropped **
[  107.104871]   .right_vruntime                : 0.000001
** 9889 printk messages dropped **
[  107.140776]  stack:0     pid:1084  tgid:1069  ppid:1      flags:0x00000002
** 6359 printk messages dropped **
[  107.164102]    kworker/3:0H    41        50.382795 E        50.417259         3.000000         0.019847         4   100 
** 8841 printk messages dropped **
[  107.195941] kworker/R-scsi_   673      2084.031990 E      2084.066589         3.000000         0.006602         2   100 
** 9638 printk messages dropped **
[  107.229752]   .idle_h_nr_running             : 0
** 7963 printk messages dropped **
[  107.258471]    kworker/7:0H    65       111.869122 E       111.903659         3.000000         0.011081         4   100 
** 8910 printk messages dropped **
[  107.291525]         0.000000         1.194368         0.000000         0.000000
** 6833 printk messages dropped **
[  107.316947]         0.000000         0.011701         0.000000         0.000000
** 9167 printk messages dropped **
[  107.350815]  stack:0     pid:205   tgid:205   ppid:2      flags:0x00004000
** 8215 printk messages dropped **
[  107.381413]    kworker/8:0H    71       242.347306 E       242.381812         3.000000         0.014780         4   100 
** 10799 printk messages dropped **
[  107.421871]     kworker/4:0    46      1095.895828 E      1098.893594         3.000000         5.876490        50   120 
** 8336 printk messages dropped **
[  107.452918]  kthread+0xd2/0x100
** 5549 printk messages dropped **
[  107.473722] kworker/R-kdmfl   989      2909.203729 E      2909.238322         3.000000         0.012063         2   100 
** 8347 printk messages dropped **
[  107.505088] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007efcabbb1b44
** 7376 printk messages dropped **
[  107.532434]         cpuhp/2    30      2760.969419 E      2763.960963         3.000000         0.325397        23   120 
** 13059 printk messages dropped **
[  107.581404]  <TASK>
** 4467 printk messages dropped **
[  107.598418] kworker/R-rcu_g     4       100.284798 E       100.293433         0.750000         0.003276         2   100 
** 12084 printk messages dropped **
[  107.642620]         0.000000        91.166024         0.000000         0.000000
** 7811 printk messages dropped **
[  107.672133] kworker/R-inet_   137         8.674709 E         8.709318         3.000000         0.001874         2   100 
** 12327 printk messages dropped **
[  107.718143]  stack:0     pid:1491  tgid:1491  ppid:1488   flags:0x00000000
** 5948 printk messages dropped **
[  107.740189] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
** 6439 printk messages dropped **
[  107.764295]  ? __pfx_irq_thread_fn+0x10/0x10
** 6864 printk messages dropped **
[  107.789644]  ret_from_fork+0x34/0x50
** 8383 printk messages dropped **
[  107.821357]  stack:0     pid:676   tgid:676   ppid:2      flags:0x00004000
** 6970 printk messages dropped **
[  107.847286]     kworker/5:0    52      2741.307369 E      2744.299855         3.000000         0.019558         6   120 
** 13728 printk messages dropped **
[  107.899176]  stack:0     pid:1059  tgid:1059  ppid:1      flags:0x00000002
** 6161 printk messages dropped **
[  107.922147] kworker/R-tpm_d   168         0.949909 E         0.915300         3.000000         0.002274         2   100 
** 11651 printk messages dropped **
[  107.966377]         0.000000         0.005520         0.000000         0.000000
** 6018 printk messages dropped **
[  107.989052]         0.000000         0.367507         0.000000         0.000000
** 10729 printk messages dropped **
[  108.029296] Call Trace:
** 4610 printk messages dropped **
[  108.046709]  ? __pfx_bpf_lsm_file_permission+0x10/0x10
** 8536 printk messages dropped **
[  108.079011]         0.000000         0.012331         0.000000         0.000000
** 6160 printk messages dropped **
[  108.102401]  stack:0     pid:1403  tgid:1403  ppid:1      flags:0x00000002
** 5299 printk messages dropped **
[  108.122444]         polkitd  1069         0.650191 E         2.344970         3.000000        29.204190       135   120 
** 8202 printk messages dropped **
[  108.153305]         0.000000         0.038644         0.000000         0.000000
** 5935 printk messages dropped **
[  108.175555]   .idle_h_nr_running             : 0
** 4570 printk messages dropped **
[  108.192572]   .nr_spread_over                : 0
** 5010 printk messages dropped **
[  108.211539]     kworker/7:1   160    134066.133787 E    134069.112306         3.000000         6.450876       210   120 
** 12385 printk messages dropped **
[  108.258222]   .load                          : 1048576
** 4568 printk messages dropped **
[  108.275711] RBP: 00007f8f289ff080 R08: 0000000000000000 R09: 00007f8f289feef0
** 8289 printk messages dropped **
[  108.307077]    kworker/14:2   419       827.548039 E       830.546256         3.000000         0.247934        39   120 
** 7980 printk messages dropped **
[  108.337159] irq/37-AMD-Vi3-   189        12.717988 E        15.715323         3.000000         0.012063         3    49 
** 8639 printk messages dropped **
[  108.369524] RAX: ffffffffffffffda RBX: 00007efc882716c8 RCX: 00007efc88330d97
** 7468 printk messages dropped **
[  108.397847]  (events_highpri)
** 3945 printk messages dropped **
[  108.412463] console_blast.s  1494     10031.871900 E     10032.879392         3.000000     10019.814933        15   120 
** 9400 printk messages dropped **
[  108.447714]   kworker/u71:2   144      5284.856528 E      5287.851979         3.000000         0.069652        10   120 
** 12710 printk messages dropped **
[  108.494696]     ksoftirqd/8    69      4972.731231 E      4975.731231         3.000000         0.824300        28   120 
** 7747 printk messages dropped **
[  108.523724]    kworker/11:1   166    149492.004338 E    149495.004338         3.000000        13.504333       412   120 
** 10380 printk messages dropped **
[  108.562804]  ret_from_fork_asm+0x1a/0x30
** 4259 printk messages dropped **
[  108.578862]  schedule+0x27/0xa0
** 7165 printk messages dropped **
[  108.605922]  stack:0     pid:1008  tgid:1008  ppid:2      flags:0x00004000
** 8459 printk messages dropped **
[  108.637390]   kworker/15:1H   175      4713.431491 E      4713.466100         3.000000         0.016423         6   100 
** 12658 printk messages dropped **
[  108.684986]     ksoftirqd/6    57      5546.943064 E      5549.918336         3.000000         0.515733        24   120 
** 7886 printk messages dropped **
[  108.713850]     kworker/4:0    46      1095.895828 E      1098.893594         3.000000         5.876490        50   120 
** 8242 printk messages dropped **
[  108.745072] task:kworker/u67:0   state:I
** 4754 printk messages dropped **
[  108.763131] RBP: 00007ffc0978e070 R08: 0000000000000001 R09: 0000000000000007
** 7235 printk messages dropped **
[  108.790450] RDX: 0000000000000000 RSI: 00007ffecd30ede0 RDI: 0000000000000005
** 10321 printk messages dropped **
[  108.829423]   .avg_vruntime                  : 40.478512
** 6928 printk messages dropped **
[  108.855583] -------------------------------------------------------------------------------------------------------------
** 7922 printk messages dropped **
[  108.885187] console_blast.s  1497      4620.409070 E      4620.481261         3.000000      4607.827454         7   120 
** 15391 printk messages dropped **
[  108.942907] R13: 0000000000000000 R14: 00007ffe7d180390 R15: 00007ffe7d180270
** 7082 printk messages dropped **
[  108.969820] console_blast.s  1493     10601.777310 E     10603.783656         3.000000     10597.960542        18   120 
** 9069 printk messages dropped **
[  109.004431]         0.000000         0.014959         0.000000         0.000000
** 10885 printk messages dropped **
[  109.045379]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
** 7363 printk messages dropped **
[  109.073118]           tuned  1356         5.158960 E         8.036931         3.000000         0.122029         1   120 
** 13815 printk messages dropped **
[  109.125702]  stack:0     pid:48    tgid:48    ppid:2      flags:0x00004000
** 6422 printk messages dropped **
[  109.149853] irq/35-AMD-Vi3-   187         0.642773 E         3.639858         3.000000         0.018896         3    49 
** 12791 printk messages dropped **
[  109.197321]  <TASK>
** 5168 printk messages dropped **
[  109.216820]         0.000000         0.016430         0.000000         0.000000
** 5902 printk messages dropped **
[  109.238913]  stack:0     pid:1498  tgid:1498  ppid:1488   flags:0x0000000a
** 6139 printk messages dropped **
[  109.261612] rcu_tasks_trace    16        99.650095 E       100.397560         0.750000         0.003147         2   120 
** 9063 printk messages dropped **
[  109.295360]         kswapd1   203       205.593831 E       208.588851         3.000000         0.025931         4   120 
** 9010 printk messages dropped **
[  109.329154]         0.000000         0.000000         0.000000         0.000000
** 9365 printk messages dropped **
[  109.364033]   .tg_load_avg                   : 16278
** 6673 printk messages dropped **
[  109.389510]  ? __pfx_kthread+0x10/0x10
** 4378 printk messages dropped **
[  109.405590]  ? __pfx_kthread+0x10/0x10
** 6092 printk messages dropped **
[  109.428606]  stack:0     pid:631   tgid:631   ppid:2      flags:0x00004000
** 7028 printk messages dropped **
[  109.455241] RSP: 002b:00007fdf451ffbb0 EFLAGS: 00000293
** 4941 printk messages dropped **
[  109.472934] R13: 00005584f871fdc0 R14: 0000000000000020 R15: 0000000000000014
** 6512 printk messages dropped **
[  109.497698]   .util_est                      : 0
** 8723 printk messages dropped **
[  109.530713] RAX: ffffffffffffffda RBX: fffffffffffffea0 RCX: 00007f3537237d97
** 6148 printk messages dropped **
[  109.554428]  ? print_cpu+0x246/0x460
** 4516 printk messages dropped **
[  109.571472]  schedule+0x27/0xa0
** 6785 printk messages dropped **
[  109.597151]  stack:0     pid:39    tgid:39    ppid:2      flags:0x00004000
** 9001 printk messages dropped **
[  109.631023] kworker/R-xfs-r  1006      2926.799421 E      2926.834021         3.000000         0.005941         2   100 
** 13063 printk messages dropped **
[  109.680526]     ksoftirqd/5    51      3259.571146 E      3262.571146         3.000000         1.059236        13   120 
** 9481 printk messages dropped **
[  109.716227]  stack:0     pid:129   tgid:129   ppid:2      flags:0x00004000
** 8058 printk messages dropped **
[  109.746287] irq/47-AMD-Vi7-   199         0.719777 E         3.717303         3.000000         0.015569         3    49 
** 7952 printk messages dropped **
[  109.776432]  __schedule+0x239/0x5f0
** 5043 printk messages dropped **
[  109.795424] console_blast.s  1504     11423.668729 E     11426.668729         3.000000     11423.219080        21   120 
** 8315 printk messages dropped **
[  109.826930] cfs_rq[10]:/autogroup-92
** 4057 printk messages dropped **
[  109.842132]  ? exc_page_fault+0x73/0x160
** 6541 printk messages dropped **
[  109.867136]   kworker/u69:5   133      1620.969985 E      1623.953154         3.000000         4.110088         5   120 
** 8168 printk messages dropped **
[  109.897701]   .rt_throttled                  : 0
** 4235 printk messages dropped **
[  109.913943] R13: 00007fff0d6a7320 R14: 0000000000000001 R15: 00007fff0d6a72a0
** 5797 printk messages dropped **
[  109.935959]  stack:0     pid:159   tgid:159   ppid:2      flags:0x00004000
** 5365 printk messages dropped **
[  109.956208]  watchdog+0x73/0xa0
** 4042 printk messages dropped **
[  109.971209]  ? __pfx_kthread+0x10/0x10
** 3998 printk messages dropped **
[  109.986380]  stack:0     pid:49    tgid:49    ppid:2      flags:0x00004000
** 9513 printk messages dropped **
[  110.021723] RSP: 002b:00007f3e80ffeb20 EFLAGS: 00000293
** 5793 printk messages dropped **
[  110.043793]    ksoftirqd/14   105    170707.156046 E    170710.150415         3.000000         0.326614        32   120 
** 12305 printk messages dropped **
[  110.089975] irq/37-AMD-Vi3-   189        12.717988 E        15.715323         3.000000         0.012063         3    49 
** 9215 printk messages dropped **
[  110.124575]  stack:0     pid:153   tgid:153   ppid:2      flags:0x00004000
** 6724 printk messages dropped **
[  110.149669] kworker/R-netns     7       100.297073 E       100.305720         0.750000         0.002254         2   100 
** 9138 printk messages dropped **
[  110.184467]   .tg_load_avg                   : 0
** 4679 printk messages dropped **
[  110.202114]  kthread+0xd2/0x100
** 5663 printk messages dropped **
[  110.223906]   .rt_runtime                    : 950.000000
** 9140 printk messages dropped **
[  110.258114]           sleep  1512         1.562400 E         4.108850         3.000000         0.646502         2   120 
** 15843 printk messages dropped **
[  110.318380]  __schedule+0x239/0x5f0
** 4264 printk messages dropped **
[  110.334391]  stack:0     pid:1010  tgid:1010  ppid:2      flags:0x00004000
** 5923 printk messages dropped **
[  110.355835]   .next_balance                  : 4294.775614
** 8192 printk messages dropped **
[  110.386244]         0.000000         0.007435         0.000000         0.000000
** 5950 printk messages dropped **
[  110.409042]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
** 8440 printk messages dropped **
[  110.440946]    kworker/R-md   169         7.329361 E         7.363970         3.000000         0.000000         2   100 
** 7965 printk messages dropped **
[  110.471493]         kswapd1   203       205.593831 E       208.588851         3.000000         0.025931         4   120 
** 12880 printk messages dropped **
[  110.520285]  stack:0     pid:70    tgid:70    ppid:2      flags:0x00004000
** 5363 printk messages dropped **
[  110.540555]         0.000000         0.002274         0.000000         0.000000
** 8617 printk messages dropped **
[  110.572783]         0.000000         0.012062         0.000000         0.000000
** 6323 printk messages dropped **
[  110.596476]         0.000000         1.475125         0.000000         0.000000
** 6365 printk messages dropped **
[  110.620039]   .min_vruntime                  : 12251.434335
** 7446 printk messages dropped **
[  110.647864] irq/28-AMD-Vi0-   180         7.118037 E        10.115592         3.000000         0.015300         3    49 
** 8542 printk messages dropped **
[  110.679860]         0.000000         0.001102         0.000000         0.000000
** 6476 printk messages dropped **
[  110.704424]  ret_from_fork+0x34/0x50
** 4286 printk messages dropped **
[  110.720584]  stack:0     pid:1006  tgid:1006  ppid:2      flags:0x00004000
** 7224 printk messages dropped **
[  110.747926]  stack:0     pid:132   tgid:132   ppid:2      flags:0x00004000
** 10105 printk messages dropped **
[  110.786065]    kworker/12:0    94      5305.147526 E      5308.140322         3.000000         0.035407         8   120 
** 9691 printk messages dropped **
[  110.822912]         0.000000         0.231857         0.000000         0.000000
** 13600 printk messages dropped **
[  110.874099] 
** 4774 printk messages dropped **
[  110.890968]   .se->vruntime                  : 203857.579074
** 8194 printk messages dropped **
[  110.920691] pool_workqueue_     3      1042.492756 E      1045.469652         3.000000         0.051366         7   120 
** 8528 printk messages dropped **
[  110.951331]  ? do_fcntl+0x2ff/0x590
** 5737 printk messages dropped **
[  110.971899]   .max_idle_balance_cost         : 500000
** 8466 printk messages dropped **
[  111.003091]  ? __pfx_futex_wake_mark+0x10/0x10
** 6920 printk messages dropped **
[  111.028289]  stack:0     pid:25    tgid:25    ppid:2      flags:0x00004000
** 5641 printk messages dropped **
[  111.049164]   .left_deadline                 : 0.000001
** 4904 printk messages dropped **
[  111.066965] 
** 3701 printk messages dropped **
[  111.080439]   .spread                        : 0.000000
** 4557 printk messages dropped **
[  111.096434]  S
** 2539 printk messages dropped **
[  111.105724]  ret_from_fork_asm+0x1a/0x30
** 7792 printk messages dropped **
[  111.134462]    xfsaild/dm-2  1017    196283.442288 E    196286.442288         3.000000         0.104454         7   120 
** 12348 printk messages dropped **
[  111.179633]  do_syscall_64+0x7d/0x160
** 6411 printk messages dropped **
[  111.202981]  stack:0     pid:30    tgid:30    ppid:2      flags:0x00004000
** 9355 printk messages dropped **
[  111.235819]     ksoftirqd/9    75      3768.012681 E      3771.003774         3.000000         0.034868        16   120 
** 9384 printk messages dropped **
[  111.270449]  kthread+0xd2/0x100
** 6278 printk messages dropped **
[  111.293196]   .left_deadline                 : 0.000001
** 5332 printk messages dropped **
[  111.312446] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
** 7088 printk messages dropped **
[  111.337928]  idle_inject/13    97        -1.466795 E         1.530941         3.000000         0.005059         3    49 
** 8870 printk messages dropped **
[  111.370463] R13: 0000000000000000 R14: 0000000000000000 R15: 000056062a0b5930
** 6252 printk messages dropped **
[  111.392818]   .se->sum_exec_runtime          : 0.000000
** 11278 printk messages dropped **
[  111.434392]         kswapd1   203       205.593831 E       208.588851         3.000000         0.025931         4   120 
** 9076 printk messages dropped **
[  111.467926]  stack:0     pid:665   tgid:665   ppid:2      flags:0x00004000
** 6173 printk messages dropped **
[  111.490378]  worker_thread+0x1a2/0x390
** 3345 printk messages dropped **
[  111.502458]         0.000000         0.015671         0.000000         0.000000
** 5661 printk messages dropped **
[  111.522557]   .clock                         : 111522.206069
** 7739 printk messages dropped **
[  111.550620]   kworker/u69:5   133      1620.969985 E      1623.953154         3.000000         4.110088         5   120 
** 7688 printk messages dropped **
[  111.578628]  1 0
** 3142 printk messages dropped **
[  111.589965]    kworker/10:4  1137      3388.709601 E      3391.703429         3.000000         0.020839         4   120 
** 7758 printk messages dropped **
[  111.618179]   kworker/u70:2   896     98403.079566 E     98405.828405         3.000000         0.935140       124   120 
** 8490 printk messages dropped **
[  111.648670]         0.000000         0.010610         0.000000         0.000000
** 13112 printk messages dropped **
[  111.695691]  ? do_syscall_64+0x89/0x160
** 4891 printk messages dropped **
[  111.713279]         0.000000         0.000932         0.000000         0.000000
** 17964 printk messages dropped **
[  111.777491]  ? __pfx_hrtimer_wakeup+0x10/0x10
** 8555 printk messages dropped **
[  111.807996]  ? __lruvec_stat_mod_folio+0x86/0xd0


--uUAiRA6JiMMv6L5l--

