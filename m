Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18D33555B
	for <linux-rt-users@vger.kernel.org>; Fri, 27 Mar 2026 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646426; cv=none; b=XX1NjNibr+1VIJgFYQY+kHluuwagiPW5ovPZMUl0MgLLQhh2XyIHve1YQpOr9d6fy/iSynIYQvfe6ltiXEilRs55dA1ilahs2nIMXeExqU85/Yt1TWf7BYwB8+/D/4BajgcRi4ltJVS384l+oc26Wk2RGHXAoXUc8t2mK1ZJ7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646426; c=relaxed/simple;
	bh=zO5ZQduTxTCmSDqyTGew3zVq4QVTM0kkUNYM6Qjch50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZxG4l5QmNqcHZRv4n+6YVaNesfVMFSOxTu6McSXYIzS+ZDNmYqDkjEBfV7UwKAHvlmKja/3aLBRUkFEvrCmzJlWn/hgVFXs+4gyi7P5R8L+ihwFcfyD6fXYln0UnlmzgYtBrCzslLhO9bAqDFYTHQnd2cTI74Sn/2WncSokVk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+GvqxhO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nNy5HERm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+GvqxhO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nNy5HERm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774646423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcY/ZAkLvNE5jmsW6XKb47cOytwFbrLwLeYAjxJQGVc=;
	b=J+GvqxhO4kGq7RLbhgNQ2BlFgqTXRsl09r6GuMI+7KGpShFsb2uswDMuoVOZZ05XoXS7l+
	2DSXWcwX4/QTmhqxwu32LDE3pq3iGXyjd+xM4+ezRBT/rpiQrE9yY/C4I5E+8TfT0AAFVf
	4LyWWJlkfYfGVgcz3x3gaZUyy2VneiQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-PGk_CDzAOYKezVse9gWeBg-1; Fri, 27 Mar 2026 17:20:20 -0400
X-MC-Unique: PGk_CDzAOYKezVse9gWeBg-1
X-Mimecast-MFC-AGG-ID: PGk_CDzAOYKezVse9gWeBg_1774646420
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b220c72bbso88426031cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Mar 2026 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774646420; x=1775251220; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kcY/ZAkLvNE5jmsW6XKb47cOytwFbrLwLeYAjxJQGVc=;
        b=nNy5HERmmtLtI52xPFO8uCgsoy40P2OXG4O7yWiNPVDB6ZdGIxHyee2VDCsKXqq7jY
         KiAGCWsBQO+z4A+m0G53USxTtXvJWdKt25cYKRscKYg8VfoPhGbHq5G61JJstynia+bJ
         S1pSfZjWPoEPcBUGgTzdhBexT1YEPijSusai43nElhuSBplHa30koUdfvjs0I5kbjFLT
         L1IOLv5ZWEnIdI+/4Yue+NESSeB14K+1tNpx7fL5XBib/uIH5ILCpLaEPg5x+Um6Iyob
         fWqznnpdr5Hxrf5E39Gv/Y35oiszucBbPp0O0Zh+qsD0cUdeQoOszGpHP5QOYC9+wYW9
         M7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774646420; x=1775251220;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcY/ZAkLvNE5jmsW6XKb47cOytwFbrLwLeYAjxJQGVc=;
        b=K0hkCxlGRD7Ny5e01WzqhIn1uzN9CIacETfQSgwhr7MrPmb8hCv0svrX7FkIFrTuZH
         ybQbdCpM8DHAdZrdh5xIijjNYp4h1j18sURloCNv3fQ3o4igSLEusFKsikw5AtJjkKZ/
         g2Wc2YbbtGxlqheBPwl1BBXZA17NlNLuOqYrGzoWT9Os/DZd/HARLyV8/cuvFAQl/9F4
         NzFABtedWT5vddAC4n6tbEOSsWqt4zC0l0BIeWx0kh1vh+KuwrpvTL2oo4XaiFL3Jao/
         A2XaguJjwzFOsplZ3ePfjcB3aGRBT9hKudk6pSKJ406GoyLqUifq/2YKMP75+wgIti1Q
         Hbhg==
X-Forwarded-Encrypted: i=1; AJvYcCXiF+P4rmPsg4chpPp1BasT2O95CjB6AXB/o5+jGdPiNiHmQtX29Uoa5VVzvSPdXAo25SR58353U5lezPx1/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YylqnWw1CU8E8IzpGi7LDCjSL7QK+58BD4eJdQ7akq3FvfHFp7T
	zvDe0kp+wyYfJKihfvtKaDdd13VQBHkx7RvU8kSxr/7Ilcpi+AF76h0iOMYshGld/KXLjHlSYYg
	nsjDFjhgQSp7i5mcgozOUw062zkhUTjaWhn1NiihbdUZ9af7mnQe+HzQwBf9E+NL0o7wX
X-Gm-Gg: ATEYQzzLPmxmbtBHrsKNhvDxNU1Ar34NTgw7iKdIpOZQhYalH2El9GxvUivwDZocB2Z
	9Bnxhg/ElwDrqOw19gnVV/cuFkfSo4ZMNbS/F/nr6MsltoFmUwVf2ghy4XVmtvCUaKah+CRccwP
	0LNEdg71M+7RCalHlONUkZNkUYz54wmyLToUtTnH6UjBFe3iN7tJyqIea5sWO19yn0FC4nV658L
	EAjZUKNZMnOkWHjT878TP3Ms8G8uevSxWc1hKDJhBXuc9zCpbTS1xJg/EJaC/Hx4GLgTmSq62Vy
	IhO+MKH6w1RwWnLIS/QtCFB/O514c+V+1212EVwZNV2JDPtzal+yqHknnIU5JS7mPw9gHwZ/oID
	Mexml2cTZf7CTvOJkBCRWoY9BHR5F7SyzW1+NKMHecWAE8SJwvXg=
X-Received: by 2002:a05:622a:11c1:b0:509:2b5a:7ff with SMTP id d75a77b69052e-50ba37d1cd0mr57723311cf.10.1774646419740;
        Fri, 27 Mar 2026 14:20:19 -0700 (PDT)
X-Received: by 2002:a05:622a:11c1:b0:509:2b5a:7ff with SMTP id d75a77b69052e-50ba37d1cd0mr57722851cf.10.1774646419246;
        Fri, 27 Mar 2026 14:20:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2cc79d8sm3941081cf.12.2026.03.27.14.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 14:20:18 -0700 (PDT)
Message-ID: <279cd4c6b4eece55a63936f2ad0912e41be7838b.camel@redhat.com>
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes ~50us noise spikes on isolated PREEMPT_RT cores
From: Crystal Wood <crwood@redhat.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>, 
	florian.bezdeka@siemens.com
Cc: namcao@linutronix.de, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 	linux-rt-users@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, frederic@kernel.org, vschneid@redhat.com, 
	gregkh@linuxfoundation.org, chris.friesen@windriver.com, 
	viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com, 
	jan.kiszka@siemens.com
Date: Fri, 27 Mar 2026 16:20:17 -0500
In-Reply-To: <20260327183610.594667-1-ionut.nechita@windriver.com>
References: <480f889c1744132f39983178fbad90ad11e081ed.camel@siemens.com>
	 <20260327183610.594667-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 20:36 +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> On Thu, 2026-03-27 at 08:44 +0100, Florian Bezdeka wrote:
> > A revert alone is not an option as it would bring back [1] and [2]
> > for all LTS releases that did not receive [3].
>=20
> Florian, Crystal, thanks for the feedback.
>=20
> I understand the revert concern regarding the CFS throttle deadlock.
> However, I want to clarify that the noise regression on isolated cores
> is a separate issue from the deadlock fixed by [3], and it remains
> unfixed even on linux-next which has [3] merged or not.

Nobody's saying that [3] would fix your issue.  They're saying that the
deadlock issue is the reason why simply reverting the epoll change is
not acceptable, at least on kernels without [3].

> I've done extensive testing across multiple kernels to identify the
> exact mechanism. Here are the results.
>=20
> Tool: eBPF-based osnoise tracer (https://gitlab.com/rt-linux-tools/eosnoi=
se)
> which uses perf_event_open() + epoll on each monitored CPU, combined
> with /proc/interrupts delta measurement.

I recommend sticking with the kernel's osnoise (with or without rtla).

Besides the IPI issue, it doesn't look like eosnoise is being
maintained anymore, ever since osnoise went into the kernel.

> Setup:
>   - Hardware: x86_64, SMT/HT enabled (CPUs 0-63)
>   - Boot: nohz_full=3D1-16,33-48 isolcpus=3Dnohz,domain,managed_irq,1-16,=
33-48
>     rcu_nocbs=3D1-31,33-63 kthread_cpus=3D0,32 irqaffinity=3D17-31,49-63
>   - Duration: 120s per test
>=20
> IRQ delta on isolated CPUs (representative CPU1, 120s sample):
>=20
>                     6.12.79-rt    6.18.20-rt    7.0-rc5-next-rt   6.18.19=
-rt    7.0-rc5-next-rt
>                     spinlock      spinlock      spinlock           rwlock=
(rev)   rwlock(rev)
>   RES (IPI):        324,279       323,864       321,594            0     =
        1
>   LOC (timer):       50,827        53,995        59,793           125,791=
       125,791
>   IWI (irq work):  359,590       357,289       357,798           588,245 =
      588,245
>=20
> osnoise on isolated CPUs (per 950ms sample):
>=20
>                     6.12.79-rt    6.18.20-rt    7.0-rc5-next-rt   6.18.19=
-rt    7.0-rc5-next-rt
>                     spinlock      spinlock      spinlock           rwlock=
(rev)   rwlock(rev)
>   MAX noise (ns):   ~57,000       ~57,000       ~57,000            ~9    =
        ~140
>   IRQ/sample:       ~7,280        ~7,030        ~7,020             ~1    =
        ~961
>   Thread/sample:    ~6,330        ~6,090        ~6,090             ~1    =
        ~1
>   Availability:     ~93.5%        ~93.5%        ~93.5%             ~100% =
        ~99.99%
>=20
> The smoking gun is RES (reschedule IPI): ~322,000 on every isolated CPU
> in 120 seconds with the spinlock, essentially zero with rwlock. That is
> ~2,680 reschedule IPIs per second hitting each isolated core.
>=20
> The mechanism: on PREEMPT_RT, spinlock_t becomes rt_mutex. When the
> eBPF osnoise tool (or any BPF/perf tool using epoll) calls
> epoll_ctl(EPOLL_CTL_ADD) for perf events on each CPU,=20

I don't see BPF calls from the inner loop of osnoise_main().  There are
BPF hooks for various interruptions...  I'm guessing there's a loop
where each hook causes an IPI that causes another BPF hook.  I
wouldn't have expected a wakeup for every sample, but it seems like
that's the default specified by libbpf (eosnoise doesn't set
sample_period).

> ep_poll_callback()
> runs under ep->lock (now rt_mutex) in IRQ context. The rt_mutex PI
> mechanism sends reschedule IPIs to wake waiters, which hit isolated
> cores. With rwlock, read_lock() in ep_poll_callback() does not generate
> cross-CPU IPIs.

Because it doesn't need to block in the first place (unless there's a
writer).

> Note on the tool: the eBPF osnoise tracer itself creates epoll activity
> on all CPUs via perf_event_open() + epoll_ctl(). This is representative
> of real-world scenarios where any BPF/perf monitoring tool, or system
> services like systemd/journald using epoll, would trigger the same
> regression on isolated cores.

Using BPF to hook IRQ entry/exit isn't representative of real-world
scenarios.  Assuming I'm right about the underlying cause, this is an
issue with eosnoise, that the epoll change exacerbates.

> When using the kernel's built-in osnoise tracer (which does not use
> epoll), isolated cores show 1ns noise / 1 IRQ per sample on all kernels
> regardless of spinlock vs rwlock =E2=80=94 confirming the noise source is
> specifically the epoll spinlock contention path.
>
> Key finding: the task-based CFS throttle series [3] (Aaron Lu, merged
> in 6.18/linux-next) does NOT fix this issue. The regression is identical
> on 6.12, 6.18, and linux-next 7.0-rc5 with the spinlock. Only reverting
> to rwlock eliminates it.
>=20
> To answer Crystal's question "when would you ever reach that path on an
> isolated CPU?" =E2=80=94 the answer is: any tool or service that uses
> perf_event_open() + epoll across all CPUs (BPF tools, perf, monitoring
> agents) will trigger ep_poll_callback() on isolated CPUs. On RT with the
> spinlock, this generates ~2,680 reschedule IPIs/s per isolated core.

Keep in mind that if you use kernel services, you can't expect perfect
isolation, or to never block on a mutex or get a callback -- but this
eosnoise issue does not mean that any perf_event_open() + epoll user
will be getting thousands of IPIs per second.

> The eventpoll spinlock noise regression needs its own fix =E2=80=94 perha=
ps=20
> a lockless path in ep_poll_callback() for the RT case, or=20

Again, if you mean the old lockless path, RT is exactly where we don't
want that.  What would be the reason to do this *only* for RT?

> converting ep->lock to a raw_spinlock with trylock semantics to avoid=20
> the rt_mutex IPI overhead.

Among other problems (what happens if the trylock fails?  why a trylock
in the first place?), you can't call wake_up() with a raw lock held.=20
It has its own non-raw spinlock.

-Crystal

