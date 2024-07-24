Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FE15ADA1
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835030; cv=none; b=EATYlvhJk+YjbPiYIIq+taU/bKdE7PB2uqI4Ou6J3XZ/plMNO2cdvjvnu1fyWarQlikBctH3TerQoi30TZktdY03rEwQFidkRO98na9/9454eHXbH9qucFYDded4QqZEQXqTk2r9W9qeTngQj81q9ap74Yc/6PVef5e+q+7cojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835030; c=relaxed/simple;
	bh=9lzGcTsjUsB6S6EdyExUvnh+GeNLBVuPCJvBQjl890E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0BoAxj+DfABOBMOh/CeHRk2vRkGDtz5Hq4PC0HZtCoDK+itCX0pRfQpbJxMsCEjPKOKUAFz1dpyimPmLupNkdtoUh8hbebkyXJwmR/A+MWQ+yIB0qMCL1YKrWc0Rsm9Iy1NYMxh7McIVSAso/X1xs3ReS76ofqE2MBxEb6AcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com; spf=fail smtp.mailfrom=sidebranch.com; dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b=ij6aVFrP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sidebranch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sidebranch-com.20230601.gappssmtp.com header.i=@sidebranch-com.20230601.gappssmtp.com header.b="ij6aVFrP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc587361b6so10559435ad.2
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidebranch-com.20230601.gappssmtp.com; s=20230601; t=1721835025; x=1722439825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5o9Mw8RmfLVksfovxLllGsHIN0+cGet25s7A79df3k=;
        b=ij6aVFrPV62PvaEL2jTAEIeCuPXfpfngvbiqanDCmj8u3KSRoCJ4KaTUJxvCGC0WqA
         lpnFZJTf7F5TA4jjrq0D0LGRhPmf2Gx1bo1O74qlA4uiiocRoE5d8ZzJYQ0rf/YxTtso
         BNjakNwhYkOYQz6VTCTiSu5UKPmhZIbvmIjyDm+gmMlPEfpgkwQnR8MmeN+RdCQ3Lngk
         3z10LxZy2L+iwSqKDP/uIWq2I/qs2celO7q6GSMaVN+GEDD0uet26q+is3Cp+RQK2QMt
         e7ULKU68bpHW6RLVNxvYhbaz5Pym7bYDX9Kv1F/QameokJvuIOzzbinxaus55bkV07sy
         AXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721835025; x=1722439825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5o9Mw8RmfLVksfovxLllGsHIN0+cGet25s7A79df3k=;
        b=OiNWm1ZhO+chZRncnFg5fq3QF1jfr8qLqwRXaZPfzfq6/TOQZEJpTSMSaWZc7OAnsW
         6h2HPRGKME7/ovZ/G/0n0XeGui2XOGNf9FX2nVMXL0EaPzPeuYTTRnzvjiFMBRnaILcC
         lz/WGRRye1fGcslzfo+kyzP8R0uKYeZUhRKLEhshovVq31ygV8yRsmfMtwzlN5aVcnk3
         sT89i1MFoKjKqq8kojVSHlVzxJGjwngFM00FMzOTf+FVhpVZDOMgIgLljLQySfcP5v3+
         qq+AAzJt3VMhWjcKu+0XHyl5QcSOBiXb2gxZc3CVqt2WtJfyHjwLUzuZUlCwRYLP2gKn
         ohlw==
X-Gm-Message-State: AOJu0YzIe29EULcLHG9r04nY84MC+g/l9o1tcGHRD8HNWEmxR01rOY08
	A8upoh620EY+ZGuX8mgRY4fQqmUkbBO1HUikskXKtB7pPwpUi17rTm0b9523aDyNpEpnSFS/Vr0
	vqJVy4TlgOHOYP4JuVJkKiVVNAHEjMnpIvmvMYFR5w8VCs0gYR+8=
X-Google-Smtp-Source: AGHT+IEUBvEUyJKmbN/Gy7tV+AlEYEDEWcKvV+iwAgUwD3kGN8tGjkFyGS6LHy5OHNjHboez56NjdWn3GNsfLn41dcE=
X-Received: by 2002:a17:90a:d983:b0:2cc:ef14:89e3 with SMTP id
 98e67ed59e1d1-2cd27416915mr9231575a91.15.1721835025354; Wed, 24 Jul 2024
 08:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMjhiJiqfz67Aba8KAKTHjO7TjGADvM2S0qDVrGfF+XkT5DeAw@mail.gmail.com>
 <CAFTL4hws_4D2-ez+TkGZU5ZWUys=yqmAjxiQa52K6zXwe6nqMA@mail.gmail.com> <CAMjhiJhZQvr1qEdUm3T2v=JDETO4iWjjo5Lfc=XQgkm4yPwXtg@mail.gmail.com>
In-Reply-To: <CAMjhiJhZQvr1qEdUm3T2v=JDETO4iWjjo5Lfc=XQgkm4yPwXtg@mail.gmail.com>
From: Leon Woestenberg <leon@sidebranch.com>
Date: Wed, 24 Jul 2024 17:30:12 +0200
Message-ID: <CAMjhiJhzwBKGYGKEdsiZjaiPDPE5mz=hazV2dS-THcUKHsDSUA@mail.gmail.com>
Subject: Re: rcuc/ thread on isolated CPU
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
On Wed, Jul 24, 2024 at 4:46=E2=80=AFPM Leon Woestenberg <leon@sidebranch.c=
om> wrote:
> On Wed, Jul 24, 2024 at 4:35=E2=80=AFPM Frederic Weisbecker <frederic@ker=
nel.org> wrote:
> >
> > Le mer. 24 juil. 2024 =C3=A0 16:06, Leon Woestenberg <leon@sidebranch.c=
om> a =C3=A9crit :
> > > CPUs." and also tried with rcutree.nohz_full_patience_delay=3D1000.
> > Are you sure you have the proper patch applied? It is not yet upstream:
> >
With the patch installed and adding kernel command option
rcutree.nocb_patience_delay=3D1000 I can still get rcuc to run on the
isolated #4.

       osnoise/4-1525    [004] ....1   697.437093: sample_threshold:
start 697.437087644 duration 3220 ns interference 0
       osnoise/4-1525    [004] ....1   697.437094: sample_threshold:
start 697.437090864 duration 3150 ns interference 0
       osnoise/4-1525    [004] dNh11   697.438575: irq_noise:
local_timer:236 start 697.438570024 duration 4740 ns
          rcuc/4-678     [004] d..3.   697.438588: thread_noise:
rcuc/4:678 start 697.438582884 duration 4190 ns
       osnoise/4-1525    [004] ....1   697.438588: sample_threshold:
start 697.438567684 duration 20490 ns interference 2


[    0.031422] rcu: RCU NOCB CPU patience set to 1000 milliseconds.
[    0.031420] rcu: Preemptible hierarchical RCU implementation.
[    0.031421] rcu: RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D16.
[    0.031421] rcu: RCU priority boosting: priority 1 delay 500 ms.

[    0.031422] rcu: RCU NOCB CPU patience set to 1000 milliseconds.

[    0.031423] rcu: RCU_SOFTIRQ processing moved to rcuc kthreads.
[    0.031423] No expedited grace period (rcu_normal_after_boot).
[    0.031423] Trampoline variant of Tasks RCU enabled.
[    0.031424] Rude variant of Tasks RCU enabled.
[    0.031424] Tracing variant of Tasks RCU enabled.
[    0.031424] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.031425] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D16
[    0.031431] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.031432] RCU Tasks Rude: Setting shift to 4 and lim to 1
rcu_task_cb_adjust=3D1.
[    0.031434] RCU Tasks Trace: Setting shift to 4 and lim to 1
rcu_task_cb_adjust=3D1.
[    0.033438] rcu: Offload RCU callbacks from CPUs: 4-15.
[    0.033439] rcu: Poll for callbacks from no-CBs CPUs.
[    0.033441] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.915368] rcu: Hierarchical SRCU implementation.
[    0.915369] rcu: Max phase no-delay instances is 1000.

Regards, Leon.
