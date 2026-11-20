Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198757;
	b=l+Tj4LuXLKJ2a+Z9VMHaGO4kV3s7+gvuCLB51SOLSXUJBwFmQBnDWMejhU8GwTvv1VX6
	 tizAO2hJ4Z3qyTknQZcwAVZaKCkj3yHfZ6ziMbzvzDDmOFKNUmw5ZMW4vjnvCxi1JFLn9
	 0LTzHYaaAPMbBhiAVe5RfrV7gwUygVoaziwn+m8gmRJt81UYEawWudg7oaVpob1qm0T7D
	 gApRveN0GA6PGXiqPxpx8WjTlGMsaXrqZt+w5qVv4lHjgZOt+MWTAPnX3kU3rQYt+HXck
	 u8sHz8Ex5tPGALowc1JoWOfeOf3YJJE7mKwiyNnyP4cIIkDyUclyBcquXcQzoeL2lXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6FUYcrD2ChNOm77umqGfBpxNsoS7ZAGf06/dNNITF3g=;
	b=iV8ZQnFB7k0UZ+OTDREWrnRlZcFwHeIli3Li9oREcJODV24sPsKFolLInku6/SVoyDqg
	 +vhAm9bi7/lEP6vII9fNMTM7xfUrFphfc5x6RpZy0bxQU3QZLDo4LC0JgUNBZ1HyoIRwI
	 x/0iC1aRR2HtlU55nQDYLiKY/vF7vY/WfoWKNm1NmoVQFu4F59PPOSr6gRtedYVeQJd18
	 QOWpZ9uHS7tQgX0SZeVOf/PUeaM3fF0SAWzXTazj7DRf6osJLu6E2DbnS7ZlOu2sggpIx
	 VylZ5AmCoXM6cAv/w6jJhMwNniFTw+ufk04phnBy5amFV87s1DYG3oTqwD1CnN/GQbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jidg5fuu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303C606B230
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 18:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B303C606B230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jidg5fuu
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f020d0169eso6532285ad.0
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2026 10:19:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795198756; cv=none;
        d=google.com; s=arc-20260327;
        b=K7LIerKMjuOfEXgcca2YjQSDFeI0ZlsSniNLBHNY7v8k2hKXDH03jzp8394ELKQ2Cc
         CdtMC5v5pipMJlc7+IYBA9EZQ3KI9/PTYyLVOgPCx3nxZPkh6LKxha9bxuqEsKZ6VMy0
         zOYyKKanqBlGwtOoOiqwADUfyRqyaa4DPqYtOKrF3jMichOA77Nbpi1dWHlEVTXv262G
         LP6i+khhcb/j+JclYxr7tWMyVEXTK1PC4fHva9sJSluinadbtULIwOFaa5MqQBiCx7rc
         n3l9H7zyugTNkpXGj+TTkezkCCP7Kgsnw8u7k5glLBjl4KsbkVq1kZp8rNtZk1Ox/iCV
         h+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FUYcrD2ChNOm77umqGfBpxNsoS7ZAGf06/dNNITF3g=;
        fh=QjBLOwwS9chwNIj3WWaxr7n4vT9YzvEW4T358wygz4w=;
        b=obLRmrHMYs7BpTjoioB+0dJ3l4tl1LbWZztmoVM1mh6TCjKVzIL/w1KeMcNV7V//uS
         9elUYwk7GhWemzvZJ/l/oBtSOf00YBXIO0waVowFUPsvi1lWO1vbl+YSNbckMwtmWgYS
         18iPRJZmlkHEUVS2Uy8cgIDKO+ZJIyMJXiiWLVvpCpvlIdf+R/MgYtjRWmUwD4dVp94d
         vbG07J+GdmCbpFZa0+JjW8+F9jE00XVNy03zSW/sz1/SGistIPETycUx3UyffYRMAVOu
         FcpoFE2hJls4D0MQeiNL266bK3fbFJiH/rdZJn9hOcOn1kt0g+lhiKw0wbDgXPCXmw46
         +w5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198756; x=1795803556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6FUYcrD2ChNOm77umqGfBpxNsoS7ZAGf06/dNNITF3g=;
        b=Jidg5fuunw4EYR2XPW0aGeaUC/aLy/87pXylqQM2qNsBnWLsRXuxtBxCVflPQnktTn
         hj4sEnsZUI5tPg6rNDC/LBV+MypkICLLZqDupAQ3ZSGb+bJJCn3RxaD2iuXg7DzgLe9B
         es+HuyxxEGbCyQTnPvstiytEHyGjLNHAhXoDUWt5/0Wwn/F1Md0JV8r7mbO3CSKJ7FS+
         8ZOI6B4L3hKyoZrcQqna1wQURNlHm9y8MRmksd7fLps1GOYBOPj88DJ1KqVPWVhYfsas
         q6Nb5hvR5BJrUrtAI1YdqxqKmW935zgajTuHH3+R7rqNHISifYXPc1xMci6MiSZus51i
         NR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198756; x=1795803556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FUYcrD2ChNOm77umqGfBpxNsoS7ZAGf06/dNNITF3g=;
        b=0STvDZ3DxbDzrMlNybi/Br7sxmh4nuLWf4OHxTlAY9tfs2tGytv1YRrHRqxT14J9rO
         RZq7zW+h6Ll+erxXK+yqSZbIaB2H0yYq8aFwJEKu/PXQCX6lGXn0h34jYfwAAIDvyotj
         uHn4oXRWaiQU95Iy4WcTyzCLK4toHeotteyozKJTFYl1GyV/yQWEVrXLJuhzQwP2FG2L
         iSYVPu0XdUORhV0jhkAL/JgAKzNlVlIB01CMLXAP6wdzJflbjFQVKofr2nbPwz/raJlJ
         6rzj1exKjtM1zPjDYtIEwMan8shrk4R8Yq6nGBk2yOTAnHm1bXL3jAqvc4fHUNCgedJY
         K6kQ==
X-Forwarded-Encrypted: i=1; AL+hErEDq3tX6H88FZIk4/eqn9g83jsi/C/n2EzmwzGrm1Cl71+8TsacB5dPaTCtM/reGpRvLSqnd/uqQD3zgSq+nw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/AdIpJxRfk4M+4QpdIkNORHTqzrC49v3aPQnkaK3HZmXCoU5Od
	Mro9Fvsmkb6AEh8Q8yje5qAZEeKcQtSqv6GIaniuVUpAwLBs6w3DNdS8Vq+COTprIMewW61XsAB
	ZGpqX96EDScQ4pICHTCBDYSUqYSXxEvg=
X-Gm-Gg: AZFdTZeBzBKpLMqzFL3TQ+z+s6N/NXxhULG1oORvukRSan2prX826B4J3ChVEt6nYtU
	VljR0tdPUjyQi4uwTqAjkkfw064rxrJ1SX7oEFZQM/kcyDjxrQNbCuAoCdnR4Ndhy39ubW4h0R7
	DjwiWeSGondYuk1N2Wr9ZspR8MmpVSq79mCkTrRH8flbDte43H2GJeLvQn2sYrN8wECOO3rlBgh
	c88wDE0LvN8tnJP4Sk4l1cOtoWWxNHqyk4JWdMeNEtM9ZGKd0d+tXQvSpXNkOTFg36VXrRYJiUp
	Ug7yVx2ryogSE5JqOC9O5oKEQTAXsKHywf/0HJ0iAaTxPHTPYreRbSuGeAZKf7QDqV8FTwMQiSw
	KAyKkRnkmCRFTrnKwJKsOahuANc+Xseuixh1YeuQZvJwoeH4EPH++hVS7kBmuL1q1Hd1p
X-Received: by 2002:a17:903:4b07:b0:2ef:de9a:e59 with SMTP id
 d9443c01a7336-2f03f1a1767mr37410195ad.23.1795198755912; Fri, 20 Nov 2026
 10:19:15 -0800 (PST)
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJuRqcD2=42CTQk2PSHofSmt+=H=qKT-x-ZXD76TwVshaepBAw@mail.gmail.com>
 <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
From: Florent Carli <fcarli@gmail.com>
Date: Fri, 20 Nov 2026 19:19:04 +0100
X-Gm-Features: AclHuK_LqX6_8yrX27ovYiu2OgdiE-yTgZNYyoT5miAuxF8i1_t91IXeVajxW-w
Message-ID: <CAJuRqcCc-p3OYAp1Sz=qFPRLPgig=Vnnmemz-NsdER35sQHdiQ@mail.gmail.com>
Subject: Re: [REGRESSION] 6.12.y, 6.18.y: fair server runs SCHED_OTHER ahead
 of SCHED_FIFO on an idle CPU (fixed in 6.19)
To: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-rt-users@vger.kernel.org, 
	Gabriele Monaco <gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Juri,

Thanks a lot for checking.

> It would also help if you could rerun your numbers (latency and the
> starvation check) on current 6.18.y (64)

Done, with v6.18.64 built with the Debian 6.18 rt config (PREEMPT_RT,
PREEMPT_DYNAMIC, default preempt=3Dfull), in the same KVM guest as
before, 30 s runs, 3 ms spin:

                         max FIFO latency, late wake-ups (> 500 us)
                         sleep 1.00 s    sleep 1.02 s    sleep 1.04 s
  6.18.64                3010 us, 15     2998 us, 15     3012 us, 14
  6.18.64 + 4 commits      23 us, 0        13 us, 0        12 us, 0

Starvation check (SCHED_OTHER task on the CPU of a SCHED_FIFO 50 busy
loop, 4.5 s window): 4.7% of the CPU on both, 0% with the fair_server
runtime at 0. So 6.18.64 is affected as much as 6.18.15 was, and the
four commits fix it there.

Stable team: please pick the following for 6.18.y, in this order. They
cherry-pick cleanly on v6.18.64:

  e636ffb9e31b ("sched/deadline: Fix dl_server time accounting")
  f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
  1e0a2ba7afb1 ("sched: Provide idle_rq() helper")
  ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")

> - 6.12.y: e636ffb9e31b and f5a538c07df2 apply cleanly.

They apply, but they don't build as is: both use rq->donor, which
6.12 doesn't have, so my backport uses rq->curr there. I'll send the
6.12.y series in reply to this thread, rebased on v6.12.118.

> Just keep in mind that it removes starvation protection for all fair
> tasks on those CPUs (kworkers included).

Noted, thanks. We only use it until we run a kernel with the fix.

Thanks,
Florent

On Fri, Nov 20, 2026 at 6:10=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
> Hello,
>
> On 20/11/26 16:09, Florent Carli wrote:
>
> ...
>
> > On 6.12.y and 6.18.y, I see it run SCHED_OTHER tasks ahead of RT tasks
> > on a CPU where nothing starves.
>
> ...
>
> > The fix went into 6.19:
> >
> >   e636ffb9e31b ("sched/deadline: Fix dl_server time accounting")
> >   f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
> >   1e0a2ba7afb1 ("sched: Provide idle_rq() helper")
> >   ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable task=
s")
> >
> > None of them carries a stable tag, and only 1e0a2ba7afb1 applies
> > cleanly to 6.12.y or 6.18.y.
>
> Thanks for the detailed report and the reproducer, much appreciated.
>
> I had a look and I agree with your analysis. Comparing v6.19 with the
> current stable heads (6.12.118 and 6.18.64), these four are the only
> dl_server changes not yet in either branch. The other dl_server fixes
> from that period (including 115135422562 "Fix 'stuck' dl_server" and
> the two "revised wakeup rule" follow-ups) are already in stable.
>
> On applying them: with git am (no -3) I get exactly what you report,
> on both 6.18.15 and 6.18.64: only 1e0a2ba7afb1 applies on its own. The
> rejects are context only, though (upstream refactors around the
> sched_class callbacks that stable doesn't carry), and a 3-way merge
> takes care of them. With git cherry-pick, applying them in order:
>
>  - 6.18.y: all four apply cleanly, and the result matches upstream.
>
>  - 6.12.y: e636ffb9e31b and f5a538c07df2 apply cleanly.
>    ca1e8eede4fc only has a context conflict in dl_server_start() and
>    1e0a2ba7afb1 needs a adaptation.
>
> So I'm in favor of taking these for 6.18.y and 6.12.y. 6.18.y should
> go first, so that 6.12.y never carries the fix without the newer
> stable branch also having it.
>
> For 6.18.y, since the commits cherry-pick cleanly, it might be enough
> to ask the stable team to pick them by SHA.
>
> For 6.12.y, could you then send your backport, rebased on the current
> head? Please Cc Peter and Gabriele on both requests, since they authored
> the commits and myself.
>
> It would also help if you could rerun your numbers (latency and the
> starvation check) on current 6.18.y (64), as 6.18.15 is quite a bit
> older and a few dl_server fixes went in since. I tried to reproduce on a
> local VM, but I think my system was too noisy to see what you reported.
>
> Until then, setting fair_server runtime to 0 on the isolated CPUs is
> a reasonable workaround. Just keep in mind that it removes starvation
> protection for all fair tasks on those CPUs (kworkers included).
>
> Thanks,
> Juri
>
