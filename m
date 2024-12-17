Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A912C7FD
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417117; cv=none; b=aSv6vZIjaisc5DC2WsH6wbvlzO06MTx97Zw5/9cBjLtzVr/uZflHOXu+Eg1rxqv2VrB6quiynC/3MPENHHy04+c2FSY+GyKjKV+otmSCeoR4gQZEoww52JX2VyoHxQ+auHwGqgKIx9xa72sWilfYNThtUxwmEsnfh6oC29wmOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417117; c=relaxed/simple;
	bh=+li4faVRH0eZJKDJEF0YEABspwKkfr95Oow10sXjjPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YglbdTD4HHS/ul8SI3kBm5W7m+CdZu7QmYQmjPNCptKZuaKLMeeiBlTPv0yiTump29XRvlGdra+RlZztGw8nHedZ0vxEwkZvFik8aGQue0hHCTNvc7cVoJpcGrA73Hhjdrvmz4CLsDZroMjZ0CnPujYErQv4Tjl2fJn5uJtt8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DeiXm4sm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DeiXm4sm"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0ac3be718so636347a12.1
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Dec 2024 22:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734417114; x=1735021914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNUy/VzIdeCIbR7v9wc81f8SCWB+LBO/wU0yS+rxp3U=;
        b=DeiXm4smOw4mTeYQkOUacibqvBUAL3D/82rztNIxHAsJeFfEnvJUkJjw/gTcTFMp+W
         4GsIeT18Lcxzo0rq6A6yOqaB413sN6RhqyXtCPjee7hdLNn1/9Ay6I21xdhLvkheME1c
         IJhV+SGsbtHKMCLXYpLDt5iudSpBL23kbJLy+yjRdsqiu/Ds24GkT2NvXNRcjh8UPCwr
         vU2O56mJZxt/Tq6HFGD9hzIZhfboXvUQ0QuTIQ3QyCsxXQawkg7jRCqMhlJvbrpEMLzk
         YrTjnRJBWJLhm0cAgDjTndnzpXkuPzBvQfhtB8fZAD0VTXqg432XUwseNUPT+Vw//vwt
         5ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417114; x=1735021914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNUy/VzIdeCIbR7v9wc81f8SCWB+LBO/wU0yS+rxp3U=;
        b=A7rnlin5UEL0/mq6/tHMJgYTn72uMwuHAnNTbpUn0ebKT5lCjz+dkHQgmRp+HUZfa4
         Z/UR8voxddtq58izxU+9+7uXZVXqD2GKvGBVMhfTv6PV03S6a9+ujxuzQDC5eD4bAuKS
         2TafacGrNTU9fOfurktckn6HW5L4d/6C+oasiZP7h5eBgDPV5m0s89UXrywFuSmOjJs4
         bNqpUY1p7Xb4ixIul5c3DXg2T8gAkVGdf2jsOEtP4SQFsXJSYHnXWB3wOUnZBy6rLrZc
         KDuNI3er8yjZlgAy3iuC1jp/k2CKwqVTVwjjwdVt/GqVkL4XbrsUG2+6DRNUuPtrMk9E
         TajA==
X-Forwarded-Encrypted: i=1; AJvYcCX2R3o7CnPuCVvHAcRCKjHBTblyj+Z4NaRRfF88vFcr5mkxIC5Lvn/TK/JLEr/od4fun5lScm228DeJ1XyP5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YymD122kZI0BdJ76mh1VD9DU5VwvlaV95pGQ58/Ff+BVjKMde5g
	NWNF56TZLtZ0TyM8f24MV8G+URXy3EO0SK1sPRcilJXcEe0EQkankp+IL1XusDY=
X-Gm-Gg: ASbGncv/3QXaIE0M24v+Gfjz3PyBL2F+gQVDV40hHvbeIO9KOqE9g4NXf+rnL9GLc5I
	aaFOjcT8Q/Btv1ymqc5U/6Kc1re6vm0O3MxbQem7TIEkuF3CMFP4PwjQM6GKkYJjR4TFbWnpfsX
	OrUNURk24TTjP5hjXDqaf5QA5WvtQGNJC2r5Ewp4jroEFN6/bVQaO7+jEKHSauJ8Upmxr+6h3dY
	jFYVTR3YILFuu3XuaidrHuMpDZSCIJNeye2P8vS
X-Google-Smtp-Source: AGHT+IGWrscI5htSPCES2JbOg/iME9ZTYkgnAA7UfY6d6DM15g4OdrBToKb76YRSs/GwW6TNCcwd/g==
X-Received: by 2002:a05:6402:1ec8:b0:5d0:bcdd:ff9b with SMTP id 4fb4d7f45d1cf-5d63c3bc400mr4962484a12.9.1734417113867;
        Mon, 16 Dec 2024 22:31:53 -0800 (PST)
Received: from mordecai.tesarici.cz ([213.235.133.107])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f35859sm3945751a12.72.2024.12.16.22.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:31:53 -0800 (PST)
Date: Tue, 17 Dec 2024 07:31:51 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-rt-users@vger.kernel.org
Subject: Re: Lazy preemption on arm64
Message-ID: <20241217073151.5aa2352a@mordecai.tesarici.cz>
In-Reply-To: <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
	<Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

V Mon, 16 Dec 2024 19:04:43 +0000
Mark Rutland <mark.rutland@arm.com> naps=C3=A1no:

> On Mon, Dec 16, 2024 at 07:04:51PM +0100, Petr Tesarik wrote:
> > Hi all,
> >=20
> > what is the plan for implementing PREEMPT_LAZY on arm64?
> >=20
> > There used to be RT patch series which enabled lazy preemption on
> > arm64, but this architecture was "sacrificed" in v6.6-rc6-rt10, as
> > collateral damage of switching to PREEMPT_AUTO.
> >=20
> > IIUC lazy preemption is currently implemented only for architectures
> > with CONFIG_GENERIC_ENTRY, but there is no inherent dependency on it.
> > So, is the plan to convert arm64 to GENERIC_ENTRY (and then get
> > PREEMPT_LAZY for free), or is somebody working on CONFIG_PREEMPT_LAZY
> > for arm64 without that conversion? =20
>=20
> I don't think there's an agreed upon plan either way.
>=20
> Jinjie Ruan has been looking to move arm64 over to GENERIC_ENTRY:
>=20
>   https://lore.kernel.org/all/20241206101744.4161990-1-ruanjinjie@huawei.=
com/
>=20
> AFAICT, the only bits that we get "for free" from GENERIC_ENTRY would be
> the logic in raw_irqentry_exit_cond_resched() and
> exit_to_user_mode_loop(), and all we'd need to enable this on arm64
> as-is would be as below.

@bigeasy: Would it be OK for you to add the below patch to the next
6.13 RT patches?

Mark tagged it with "HACK", but to me it actually looks just as good as
the good old (pre-PREEMPT_AUTO) arm64 patch. ;-)

Petr T

> ---->8---- =20
> From 16ae3c84d8e1691fe670dbfb4c643cab4fa2065f Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Mon, 16 Dec 2024 18:32:44 +0000
> Subject: [PATCH] HACK: arm64: enable PREEMPT_LAZY
>=20
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/Kconfig                   |  1 +
>  arch/arm64/include/asm/thread_info.h | 12 +++++++-----
>  arch/arm64/kernel/entry-common.c     |  2 +-
>  3 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 100570a048c5e..7926bc78a1c46 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -39,6 +39,7 @@ config ARM64
>  	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> +	select ARCH_HAS_PREEMPT_LAZY
>  	select ARCH_HAS_PTE_DEVMAP
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_HW_PTE_YOUNG
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/as=
m/thread_info.h
> index 1114c1c3300a1..a2125407901ed 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -59,11 +59,12 @@ void arch_setup_new_exec(void);
> =20
>  #define TIF_SIGPENDING		0	/* signal pending */
>  #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
> -#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
> -#define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
> -#define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
> -#define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
> -#define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
> +#define TIF_NEED_RESCHED_LAZY	2	/* Lazy rescheduling needed */
> +#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
> +#define TIF_FOREIGN_FPSTATE	4	/* CPU's FP state is not current's */
> +#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
> +#define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
> +#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>  #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
>  #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
>  #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> @@ -85,6 +86,7 @@ void arch_setup_new_exec(void);
> =20
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> +#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
>  #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-c=
ommon.c
> index b260ddc4d3e9a..7993fab0cab4c 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -132,7 +132,7 @@ static void do_notify_resume(struct pt_regs *regs, un=
signed long thread_flags)
>  	do {
>  		local_irq_enable();
> =20
> -		if (thread_flags & _TIF_NEED_RESCHED)
> +		if (thread_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>  			schedule();
> =20
>  		if (thread_flags & _TIF_UPROBE)

