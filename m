Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFE346E4C
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Jan 2026 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751254; cv=none; b=Fp5OrHsM/v9hGlvCHPqlsvh+pcCl19DnJof56yVQdZo/S2fTP3JIeuJOW2wuRmbSBnSw7AUYuhuaDlplWQXYz+/CokfL4X0pteWFaEr/29W/9jxgCDH1ybqFQVZKknBygV4RpS68olVZ4t8ZAYEZ6smdcWBQOdHAwMOBRBd3Lok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751254; c=relaxed/simple;
	bh=SHET8sLgdL248LUeTzpRaiWknGc4tunfjA+TSPvicjk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=YuEXjPT4AnggCioJ1kJ0HSONKgXN+xtLDPd6p4TfCUYIeKbIykqPNU43Gg4V/eBmgDM6NTC13S9EPJV3O50lvaUL+0Z0fUUk0FJXxRTfE43Pz1u5+siPu6Q6Iu4Ag+QVjid/dsuANEDXQuO+oCIrhbYkW0vXwqFDlE+G8xg7CPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knu.ac.kr; spf=pass smtp.mailfrom=knu.ac.kr; dkim=pass (2048-bit key) header.d=knu-ac-kr.20230601.gappssmtp.com header.i=@knu-ac-kr.20230601.gappssmtp.com header.b=H4++SMh6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=knu-ac-kr.20230601.gappssmtp.com header.i=@knu-ac-kr.20230601.gappssmtp.com header.b="H4++SMh6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f2676bb21so15131125ad.0
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jan 2026 21:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=knu-ac-kr.20230601.gappssmtp.com; s=20230601; t=1769751251; x=1770356051; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRhIiBiKoV38yzXRNF6mTxOejQtr5zvYqvXzFWDoKBo=;
        b=H4++SMh6wUjND9nDESjNXFeckm6UGcIao29GvH1HssaZRTIbSrYqGFZz7/kZ+gTf9M
         7dTz5cv81dK4uyuQa+B/f9Uz0dD/IgP0HXg/W+JbyY8x5od8P+Wf5AcMZeHvNIUIeM0e
         IRCy/9I0zeKB5aOZn+5cMRzhwPK4AGmlDV08MBLoUc50B0g49Xnc+kgdCFm7LyM120Ma
         JZsvXu+zV/5RIJDFgZYDExn1RrC/YpC8spTiRiR+MCmKgxmMNOe4GDEidkDGy7g5B+K/
         csLtKt/FTOKesE4I7vlX6CfKU+stD8tcudIhcm9i0cnYvX3aC0N1Ef2Tv/UoZI3RvAN+
         c3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769751251; x=1770356051;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRhIiBiKoV38yzXRNF6mTxOejQtr5zvYqvXzFWDoKBo=;
        b=LmS0SbqCfKXdNNkbmrzLDQpom2DkzzDv4rPQsRCuUnNjzktQ4oYBy4PXTTCwGd/JWh
         Niy87upTzjmUS5wNuoMDFO+WZ8zF6hr3mVesDrXaJ/smlMpgAX93ySoXW+ihg2ZighAf
         tNNxoaYvg0P2MNDrVrBgBdA9kH4Rezs+nerNvnVm3R3NDA03cgAA860B5aOq1llVwG+R
         ryIZMsUcvdJKc9gPyuqMZXRtEiHOrAvzL2XDnBXqLBARyU2hSpMHxzsuxK/4IS9xkHMU
         9fLl0SgIQny/71J6w5WkrSWRUr/r7iErA9fMKKdMymj8DMMtrbwvMDgtW+cNPWi2H3Lf
         m1Hg==
X-Gm-Message-State: AOJu0YwVu4F7qhRSr8LH9ERpGTl4bkZmaobxpU7g4dR9mADsxJ6f8RgA
	4vpsLNkdUouP25gckZaV44jFFNZkj8LZ+PxtNvyzdXkCuhgmvskPsd4NUQx+3y9VBAFs9Q95Snj
	tOjLdYDY=
X-Gm-Gg: AZuq6aLW3imJL1c7YkANo0q+3BTmO/pyE/qhv5e6faJVTX3QAGVHWkELGNnDAqL/alT
	m0SNMe4eX0TIPHG3GG+pkmbJg+n2mRdwA/CYMhc9kaR1e2QtXuRb9epIkuHQ8TTY+RsxKKyRhMl
	4QrY9P5APCHntYV9XoFBx/+Q0ztCCtigKqn81L/Ig7ai0sTDO9DahOewjqoHFclU/fRvngs2uDp
	PwbsWmoE1qtX0UczNahmyTBm5qTfvBwGfsgQKS6YzODiu7Hh4/UJ7cGW1ZCv4g9YMXsego8ePaL
	/568Lm76bEw4msICbCBYx9Ombi5UwkaI4eMne28gpW4DVAcOciaH1H0sQTeAhXgt1MeJ5Xjuyvi
	B8UF7lNQBrlv9m1ysTlNmgb00zQ09Xeq7XhSRvdidcil2D1/S9PhLDhNIwjrfEA33TtweNXAhkV
	IXrowvmV91Ymr8gryvxoJVupD+Kh4=
X-Received: by 2002:a17:903:1112:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2a8d993d3b3mr14770855ad.50.1769751250764;
        Thu, 29 Jan 2026 21:34:10 -0800 (PST)
Received: from smtpclient.apple ([121.181.215.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8dc225543sm7976435ad.73.2026.01.29.21.34.09
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 21:34:10 -0800 (PST)
From: =?utf-8?B?6rmA66+87IiY?= <m.kim@knu.ac.kr>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: =?utf-8?Q?EtherCAT_on_PREEMPT=5FRT=3A_send-recv_tail_=7E50-80?=
 =?utf-8?Q?=CE=BCs=2C_looking_for_guidance_?=
Message-Id: <C35885A5-1CAD-4373-927A-CBEB7DF116EA@knu.ac.kr>
Date: Fri, 30 Jan 2026 14:33:58 +0900
To: linux-rt-users@vger.kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)

To: linux-rt-users@vger.kernel.org
Subject: EtherCAT on PREEMPT_RT: send-recv tail ~50-80=CE=BCs, looking =
for guidance

--
Hi all,

I'm working on reducing worst-case EtherCAT send-recv round-trip
latency on PREEMPT_RT 6.8-rt8, targeting under 50=CE=BCs. I've done
ftrace analysis over ~50k cycles and tried two kernel-side fixes,
but the measured tail (50-80=CE=BCs) exceeds what my trace can account
for (~31=CE=BCs). I'd appreciate help identifying what I'm missing.

=3D=3D Environment =3D=3D

  - Kernel: 6.8.0-rt8 (PREEMPT_RT)
  - CPU: Intel, core 3 isolated
    - isolcpus=3Ddomain,managed,3 nohz_full=3D3 rcu_nocbs=3D3
    - intel_pstate=3Ddisable idle=3Dpoll intel_idle.max_cstate=3D0
  - NIC: RTL8168H (r8169 driver), IRQ pinned to CPU3
    - Coalescing off: rx-usecs=3D0, rx-frames=3D1
  - EtherCAT master: SOEM (Open EtherCATsociety)
    - SCHED_FIFO 99, pinned to CPU3, 1ms cycle
    - AF_PACKET raw socket (ETH_P_ECAT)
    - Measures send-recv with clock_gettime(CLOCK_MONOTONIC)

=3D=3D What I've tried =3D=3D

Using ftrace (function_graph + sched_switch) on CPU3:

1) ksoftirqd preemption during NAPI poll

   During rtl8169_poll() =E2=86=92 napi_gro_receive() =E2=86=92 =
sock_def_readable()
   =E2=86=92 wake_up(), SOEM (FIFO 99) preempts ksoftirqd/3 (CFS) =
mid-poll.
   SOEM then blocks on rt_spin_lock (socket wq_head->lock, held by
   wake_up) =E2=86=92 D state ~2=CE=BCs =E2=86=92 returns to ksoftirqd =
=E2=86=92 preempts again
   after recv() completes. Measured overhead: 5.5=CE=BCs mean, up to =
25=CE=BCs.

   Fix: chrt -f -p 99 ksoftirqd/3

   Result: D state eliminated, recv() peak improved ~3=CE=BCs, but
   max got worse (77=CE=BCs =E2=86=92 88=CE=BCs).

2) TX completion IRQ elimination

   Each cycle generates two polls: TX IRQ triggers poll#1 (rtl_tx
   cleanup only, ~1.3=CE=BCs), then RX IRQ triggers poll#2. Gap: =
3-13=CE=BCs.

   Fix: Masked TxOK from interrupt enable register.

   Result: recv() distribution narrowed, but send-recv unchanged
   (TX poll + gap overlaps with wire delay).

   Combined: No improvement beyond H1 alone.

=3D=3D The discrepancy I can't explain =3D=3D

send-recv breakdown with H1 applied (from sched_switch trace):

  Component         Mean    Tail (P99/Max)
  -------------------------------------------
  send() syscall    ~2=CE=BCs    stable
  Wire RTT          ~7=CE=BCs    stable
  RX IRQ handling   ~2=CE=BCs    ~3=CE=BCs
  Sched delay       ~1=CE=BCs    ~10=CE=BCs
  Poll start delay  ~1=CE=BCs    ~13=CE=BCs
  RX poll (napi)    ~5=CE=BCs    ~6=CE=BCs
  recv() return     ~1=CE=BCs    stable
  -------------------------------------------
  Trace total       ~19=CE=BCs   ~31=CE=BCs

But SOEM measures send-recv tails of 50-80=CE=BCs using
clock_gettime(CLOCK_MONOTONIC) around the send()+recv() pair.

That's a gap of roughly 19-49=CE=BCs that my trace doesn't cover.

My tracing (function_graph on rtl8169_poll + sched_switch events)
covers the kernel NAPI path, but I suspect there are latency
sources outside this window =E2=80=94 in the send() path, the
syscall entry/exit, the userspace-to-kernel transitions, or
somewhere else I haven't instrumented.

=3D=3D Question =3D=3D

What could account for the ~20-50=CE=BCs gap between what ftrace
shows in the NAPI/sched path (~31=CE=BCs worst case) and what the
application measures end-to-end (50-80=CE=BCs)?

Are there known latency sources in the PREEMPT_RT network path
=E2=80=94 such as softirq-to-userspace return, AF_PACKET socket
processing, syscall exit, or something else =E2=80=94 that
function_graph + sched_switch tracing would not capture?

I've tried the specific fixes described above. Happy to collect
additional traces with different tracepoints if someone can
suggest what to instrument next.

Thanks,

=E2=80=94
Minsu Kim
Undergraduate Student
School of Mechanical Engineering & Computer Science
Kyungpook National University (KNU), Daegu, South Korea

Email: m.kim@knu.ac.kr=
