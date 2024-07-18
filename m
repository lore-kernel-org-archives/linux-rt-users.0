Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4638DE1
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721284700; cv=none; b=nGaKvpjfPS2Vf1gRoKg3Yd5RTIBtWDxyT9E3P8XGRfEPZxy0rSaJbuf1SW+MH1D6V/XZSTyTnUTB7WxwGlm+3pKfVW+UovnSx5x/CfoUNFYWO1UjwdybkiqjJ/R4xPdpHOAjaqV8SuKJy2Cp23RJbfuLdVCNEvJbsjiWgFu0wEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721284700; c=relaxed/simple;
	bh=wR9uDfkMV+jdZ7xKHxA0oyFy3GtMvb1KolsV1OBRyDE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kn3S8n9tROdyv3DL23hL1w05DGAyL7VR2TCGslI1dwDzq5L7cD4dqrCvym5loJOFS2JKR+Q6Da0MVeG0Pja/hTLBa5rigjpRXTQDhYx9j0QWxm+D2Ix5Lajd48+LId6w5cJC8hIDygIHj6WnT4gxz/EXL6WIfImuFBjLJPQUUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXFHs+sf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXFHs+sf"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso562391e87.1
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jul 2024 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721284696; x=1721889496; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gdo495u9LnmTrqnDylxYtjSKCshS0GUgkTL6BLomN9s=;
        b=KXFHs+sf2lEPj6sOhImvjezOxJDmp80Oi1uqCKBLklLCuwlOcoDjD+LmgkliPGdn+M
         OwXxk1DaEuSBUzrwdySK9JSJT2yUL3Y8AEkmUtMtdcgzpTS/+CceFH3D9DXcyDqdE/ku
         IGSOJQ9Xf1SO5AirbQzAj0tIvEpxoN++6+tGabm48yIj7LbV+G2aq51RxCXCCMCenCdK
         fdKHx0kNx5kjUloRvDDdUyqmSqcO22FPjuMAf8Ld+QFe3bZDhZF6IeJ2zzOk7lw/E3TV
         oD+c9Jzgrxdj6MPRv4eG+BnjG7Sj5wd+y9jKWidO4BZacSITSM/Eg7qi1/wCpF/OKg7X
         Pghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721284696; x=1721889496;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gdo495u9LnmTrqnDylxYtjSKCshS0GUgkTL6BLomN9s=;
        b=WTvydQ8+tIIiTmOQ6bquNb5oyadZkW2uh45pwMlPqbPNtdDhZwIy5cNCEpXd58kB/P
         hHQxJ81t4gcg8ZGBSSipua9Ok1Mmp5WWAil6k8XWe2nl8uGhGv024j6QpBYELQy6orzV
         H6Oqa496BNRM2meZeD4M7qVjz5gdJrRSATMTkCrZClrI2NR6pG6aBgPW4UxgXx/F8uDL
         A9vhq4uoxNTP5IiPs4j13o0H5AXPlHKZe7SaaTxWI+x0VXjwSD+IHYNADnFhLVq3LKnD
         XCN2zGXpOdKR5Qw9wGaJre2g4NmqEO6sfiJCPsnaW9wWyGlo/YueBkNYidHW3ON5sAty
         ztIg==
X-Gm-Message-State: AOJu0YzyG9nVsB1x36xfBfFEyHeoMY5CvTSImeXAQC7nKlS6psevThee
	jlyYB2rRnYBYKsTF2Le3QfgjTOiKzZ9/XcJKaod6P3zYIXWGcRWNAZZcel+YaWs+f36ictRYmio
	set64k1JWfZwhi2rQCeMhORXIVV/Js5WIk68FtA==
X-Google-Smtp-Source: AGHT+IF0OjUSh0IzM5rqg3lAh3CdtKkpcaNsCwBbD8xGk+mJLi19/R1DIgvSsn/tYTRbk1AlaAC80/oIKevCCaq4Tkc=
X-Received: by 2002:a05:6512:3a82:b0:52c:e0fb:92c0 with SMTP id
 2adb3069b0e04-52ee53f6d75mr2694837e87.34.1721284695528; Wed, 17 Jul 2024
 23:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Du Dengke <pinganddu90@gmail.com>
Date: Thu, 18 Jul 2024 14:38:05 +0800
Message-ID: <CAKHP1dvNRstrd_JQK9J+83UPmv7GNRfODx9L_nmOO-JawKXvyw@mail.gmail.com>
Subject: cyclictest: lttng debug the reason why switch graphic window case
 cyclictest become high
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all
My environment
Machine: intel-x86-64  with 4 cores
Linux Kernel: 5.10.0
Rootfs: using yocto(kirkstone) plus meta-intel layer, build a rootfs with x=
fce
Lttng : lttng (LTTng Trace Control) 2.13.8
rt-tests: v2.7 [https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/=
]

My steps:
prepare
1. isolate the cpu 3 (form 0-3)
2. kernel boot: [ isolcpus=3D3 skew_tick=3D1 rcu_nocbs=3D3 idle=3Dpoll
irqaffinity=3D0,1 nowatchdog nohz_full=3D3 rcu_nocb_poll=3D3
processor.max_cstate=3D0 ]
3. lttng
    lttng create
    lttng enable-event  --kernel --all
    lttng add-context --kernel --type=3Dpid
    lttng start
4. cyclictest -a3 -p90 -i1000 --policy=3Dfifo --latency=3D0 -d0 -D 30m
[running on cpu 3]
    at first, the output was=EF=BC=9A
---------------------------------------------------------------------------=
---------------------------------------
 root@wanghuo:~# cyclictest -a3 -p90 -i1000 --policy=3Dfifo --latency=3D0 -=
d0 -D 30m
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.28 0.06 0.02 1/275 3560

T: 0 ( 3559) P:90 I:1000 C:   3940 Min:      3 Act:    3 Avg:    3 Max:    =
   5
---------------------------------------------------------------------------=
---------------------------------------

5. on other side, before switch graphic windows, record time:
    root@wanghuo:~# date +"%H:%M:%S.%N"
    13:27:45.066881975

** On keyboard: Alt+tab  switch graphic window [in my case: two xfce
terminal window] **

Above cyclictest become the following:
---------------------------------------------------------------------------=
---------------------------------------
root@wanghuo:~# cyclictest -a3 -p90 -i1000 --policy=3Dfifo --latency=3D0 -d=
0 -D 30m
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 1.82 0.65 0.24 2/278 3580

T: 0 ( 3559) P:90 I:1000 C: 106182 Min:      3 Act:    3 Avg:    3 Max:    =
  19
---------------------------------------------------------------------------=
---------------------------------------
Ctrl + C terminal the the cyclictest, record time:
    root@wanghuo:~# date +"%H:%M:%S.%N"
    13:27:50.352793751

So the cyclictest latency become high between:  13:27:45.066881975  -
 13:27:50.352793751

6. lttng stop

7. lttng-schedtop analyse the result=EF=BC=9A
lttng-schedtop --cpu 3 --limit 15 --procname cyclictest
lttng-traces/auto-20240718-132132/
output:
---------------------------------------------------------------------------=
---------------------------------------
root@wanghuo:~# lttng-schedtop --cpu 3 --limit 15 --procname
cyclictest lttng-traces/auto-20240718-132132/
Checking the trace for lost events...
Warning: progressbar module not available, using --no-progress.
Timerange: [2024-07-18 13:25:56.676039486, 2024-07-18 13:28:10.507314182]

Scheduling top
Wakeup               Switch                 Latency (us)   Priority
CPU   Wakee                      Waker
[13:26:08.547304577, 13:26:08.547339024]          34.447         20
3   cyclictest (3559)          cyclictest (3558)
[13:27:48.027388352, 13:27:48.027401140]          12.788         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:45.496388132, 13:27:45.496398962]          10.830         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:52.724388253, 13:27:52.724398485]          10.232         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:47.892391804, 13:27:47.892400202]           8.398        -91
3   cyclictest (3559)          Unknown (N/A)
[13:27:46.363171892, 13:27:46.363179359]           7.467         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:46.646020129, 13:27:46.646027581]           7.452         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:47.926391872, 13:27:47.926397774]           5.902        -91
3   cyclictest (3559)          cyclictest (3558)
[13:26:55.787340266, 13:26:55.787345656]           5.390         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:47.976880846, 13:27:47.976886138]           5.292         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:26:11.349340471, 13:26:11.349345733]           5.262         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:35.911339881, 13:27:35.911345135]           5.254         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:28:00.132341317, 13:28:00.132346562]           5.245         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:00.000341299, 13:27:00.000346504]           5.205         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:46.444124979, 13:27:46.444129682]           4.703         20
3   cyclictest (3558)          ksoftirqd/3 (30)
---------------------------------------------------------------------------=
---------------------------------------

8. according to above operation time interval =EF=BC=9A 13:27:45.066881975 =
 -
 13:27:50.352793751
the bigger latency  12.788, 10.830, 8.398  shotted
---------------------------------------------------------------------------=
---------------------------------------
[13:27:48.027388352, 13:27:48.027401140]          12.788         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:45.496388132, 13:27:45.496398962]          10.830         20
3   cyclictest (3558)          ksoftirqd/3 (30)
[13:27:47.892391804, 13:27:47.892400202]           8.398        -91
3   cyclictest (3559)          Unknown (N/A)
---------------------------------------------------------------------------=
---------------------------------------

The third was cyclictest child process [pid: 3559 ]: 8.398
[13:27:47.892391804, 13:27:47.892400202], print the kernel event
between that time:
---------------------------------------------------------------------------=
---------------------------------------
[13:27:47.892391804] (+0.000000922) wanghuo sched_waking: { cpu_id =3D 3
}, { pid =3D 0 }, { comm =3D "cyclictest", tid =3D 3559, prio =3D -91,
target_cpu =3D 3 }
[13:27:47.892394602] (+0.000000989) wanghuo sched_wakeup: { cpu_id =3D 3
}, { pid =3D 0 }, { comm =3D "cyclictest", tid =3D 3559, prio =3D -91,
target_cpu =3D 3 }
[13:27:47.892394927] (+0.000000325) wanghuo timer_hrtimer_expire_exit:
{ cpu_id =3D 3 }, { pid =3D 0 }, { hrtimer =3D 0xFFFFAC844128FE78 }
[13:27:47.892395159] (+0.000000232) wanghuo
x86_irq_vectors_local_timer_exit: { cpu_id =3D 3 }, { pid =3D 0 }, {
vector =3D 236 }
[13:27:47.892396194] (+0.000001035) wanghuo power_cpu_idle: { cpu_id =3D
3 }, { pid =3D 0 }, { state =3D 4294967295, cpu_id =3D 3 }
[13:27:47.892398345] (+0.000002151) wanghuo rcu_utilization: { cpu_id
=3D 3 }, { pid =3D 0 }, { s =3D "Start context switch" }
[13:27:47.892398828] (+0.000000483) wanghuo rcu_utilization: { cpu_id
=3D 3 }, { pid =3D 0 }, { s =3D "End context switch" }
[13:27:47.892400202] (+0.000001374) wanghuo sched_switch: { cpu_id =3D 3
}, { pid =3D 0 }, { prev_comm =3D "swapper/3", prev_tid =3D 0, prev_prio =
=3D
20, prev_state =3D 0, next_comm =3D "cyclictest", next_tid =3D 3559,
next_prio =3D -91 }
---------------------------------------------------------------------------=
---------------------------------------

compare a normal  low latency cyclictest child process
---------------------------------------------------------------------------=
---------------------------------------
[13:26:13.630390278] (+0.000000209) wanghuo sched_waking: { cpu_id =3D 3
}, { pid =3D 0 }, { comm =3D "cyclictest", tid =3D 3559, prio =3D -91,
target_cpu =3D 3 }
[13:26:13.630390610] (+0.000000332) wanghuo sched_wakeup: { cpu_id =3D 3
}, { pid =3D 0 }, { comm =3D "cyclictest", tid =3D 3559, prio =3D -91,
target_cpu =3D 3 }
[13:26:13.630390839] (+0.000000229) wanghuo timer_hrtimer_expire_exit:
{ cpu_id =3D 3 }, { pid =3D 0 }, { hrtimer =3D 0xFFFFAC844128FE78 }
[13:26:13.630391080] (+0.000000241) wanghuo
x86_irq_vectors_local_timer_exit: { cpu_id =3D 3 }, { pid =3D 0 }, {
vector =3D 236 }
[13:26:13.630392852] (+0.000001772) wanghuo power_cpu_idle: { cpu_id =3D
3 }, { pid =3D 0 }, { state =3D 4294967295, cpu_id =3D 3 }
[13:26:13.630393057] (+0.000000205) wanghuo rcu_utilization: { cpu_id
=3D 3 }, { pid =3D 0 }, { s =3D "Start context switch" }
[13:26:13.630393245] (+0.000000188) wanghuo rcu_utilization: { cpu_id
=3D 3 }, { pid =3D 0 }, { s =3D "End context switch" }
[13:26:13.630393524] (+0.000000279) wanghuo sched_switch: { cpu_id =3D 3
}, { pid =3D 0 }, { prev_comm =3D "swapper/3", prev_tid =3D 0, prev_prio =
=3D
20, prev_state =3D 0, next_comm =3D "cyclictest", next_tid =3D 3559,
next_prio =3D -91 }
---------------------------------------------------------------------------=
---------------------------------------
The two compare show :  when switch graphic windows case
sched_waking  209 to 922
sched_wakeup 332 to 989
rcu_utilization  205 to 2151
sched_switch  279 to 1374
increasing high.

Is my thinking right? If I am right, the cyclictest runing on core 3 ,
which isolate form irq, userspace application, why above function
affected?

Thanks
dengke
