Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C781C7017
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Mar 2025 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263831; cv=none; b=t8UPbP3TIb6he4w3s/ZK1gn3rqrWI6ebo6vWCHQMaGLFEDj2GSvJRyXZnmzgG1V/ZTEiAhgJm85XljrELTDMdCBqx81plGqSi11AnDbW9/tqGqul/TjW5VIdr0zzNQHf/RRA2m5Wm1wOT3jY8T5te98w655X/VOA+7BDQFpWZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263831; c=relaxed/simple;
	bh=XnsPLRnXSWb7buELfPusaeb+B8AlBgoQQP15h/UL+Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLt2I4CLFJ89pLlMwHLzz/XXg1qI4mquCJUH+wYw3cYW8tTr69SlTAVKhaDQk9m/ky/fU0irof7AW8NmDO0Fgxwfq/6Jra07H8hgvPfsm/PzqLT1u/RUfY3QgPLMuOWlogYgMzVqkb9vEWxsSRTmJ996ozz+pxsrZc5dKHhVga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VIVHm+Ry; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VIVHm+Ry"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bbe818049so640665e9.3
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Mar 2025 04:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741263826; x=1741868626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M16Hx03LPq6Hpxa+7YZIfd9IWWJDL42bnuEv+y5yizM=;
        b=VIVHm+RyJq8WE+p3322eTYpgG1NYzUqgF/ySd4KpZlDQJX2sqN7C++0yPJZhyIOKRF
         u+O1u4+JrFQs6ve8P48QZjJIgdUhInvJNsKVvCNzBOuJuk3bMvdxfDltvWApMwB2DagZ
         g5ecaOwERnTOcwPhvDQBZX2x3CyvwDVZvU4SFv0xFL2tJQii/0Azank772wFa6PH+7LQ
         ob47J/aATABG8YNxm8JCQ7VCjyA60pQhfxrPjaU4bz/WRX5CD5NY8XjpnxxQtZYM9Pep
         qJfWHg5net0118fYAauk91UI2G/xMstHOO1YVh1zBP4umx/dRvDb+Z9gKozTc29N83tv
         6c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741263826; x=1741868626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M16Hx03LPq6Hpxa+7YZIfd9IWWJDL42bnuEv+y5yizM=;
        b=wqGGArRTpDdhUyPzAja11B9tdRVd7IyA72u/Hq72twYeCgUVdmZqVDfsc/h1F4eEBt
         HbvFLNlmXQdrrhAiT1nO6Ws6oz1GMkFMYjvV6Wq960NwZX88n6t51NsF40RGXV050gqh
         sWC2WBAoI9iOMxJSn91K3bxoWa1MNwqaOt+GchLq5UhWotMMnxaScW7yOdk8L+GrWxyc
         hL8OIGqElTLukKjBazz/0GPkGNLr0ms6OyCq+JVD433agUt42ghysNjw6z9m68KuY5Ab
         PcaAsyaY9zTpfNGapmeE90ptBFt6jyavgAGrvR7fWEtN+CpEnlryyBl0wKzY7IYUzG5g
         jPEA==
X-Forwarded-Encrypted: i=1; AJvYcCUao4SqIc8Xro7z68+qJyqd4+mJ5Hd/ETN6Q6iU9K+qNrqdeP+vOPJlHOJcLlB+ehYWdD26I8ikHULXnmYeDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlcD8pWBI+5s1zWvhWTsQNBRIutubvyPueVwzquywk2y0zKTN3
	7LMtjaUgEoxqpc2tKbAQEiywJdZESxXu8/PwZFSkjzhEJrX2mTyVf2ZwQF446oA=
X-Gm-Gg: ASbGncuwASlCsh1ybnGfVp6QhiXXI1Tw4Awk6RevGad5PxHgUijnOfX+JvJ84OEdMnn
	6TngdoPXWj60dqWWW/NpPitgXo6Qrnv2ik21ddRJl63LTxxiySpDlLyn3j8lHnRgV2yqGV3gWHM
	mPaIRrw5gtJmBwvOsyRZUQdVdiqFu1VdsOY0rMdwKQ+J3FHBh/aL/pf36SxJ9DJXE/Uj4+zrMf3
	rwu2/r0igbCC7jZkOjSP1uLeB1R8B28YQ1XTqUkc2jKuchv+MlIFI8U3RHpb7q6pyaJrwFOt9wl
	XgzJp8/X5IB1ybv2u3bPx18pPY0ab+EyLn1RtJghA4CT2Bt4dUHjRFrzz3IkaFeOSkZsYveM1od
	heTQ6ODLpw8HVVIjnZwpBnwVmM7c9akI8YslgaxlZn1VHDpSHKw==
X-Google-Smtp-Source: AGHT+IFsubZy1stzLlAQAO2x9t8qCSSvv55Pi5w0YDWBthveEExrqPR8Wq2/UXbzt8+RS0SQ+6/D5w==
X-Received: by 2002:a05:600c:3d1a:b0:439:9a1f:d73d with SMTP id 5b1f17b1804b1-43bd2ae647bmr19310215e9.8.1741263826596;
        Thu, 06 Mar 2025 04:23:46 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1886787f8f.3.2025.03.06.04.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:23:46 -0800 (PST)
Date: Thu, 6 Mar 2025 13:23:43 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>, Peter
 Collingbourne <pcc@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Thiago Jung Bauermann
 <thiago.bauermann@linaro.org>, Mark Brown <broonie@kernel.org>, Kristina
 Martsenko <kristina.martsenko@arm.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Jinjie Ruan <ruanjinjie@huawei.com>, Juri Lelli
 <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 1/1] arm64: enable PREEMPT_LAZY
Message-ID: <20250306132343.6b902a3d@mordecai.tesarici.cz>
In-Reply-To: <Z8hAZ09Q40fxLJSk@J2N7QTR9R3>
References: <20250305104925.189198-1-vschneid@redhat.com>
	<20250305104925.189198-2-vschneid@redhat.com>
	<Z8hAZ09Q40fxLJSk@J2N7QTR9R3>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 12:15:35 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Mar 05, 2025 at 11:49:25AM +0100, Valentin Schneider wrote:
> > From: Mark Rutland <mark.rutland@arm.com>
> > 
> > For an architecture to enable CONFIG_ARCH_HAS_RESCHED_LAZY, two things are
> > required:
> > 1) Adding a TIF_NEED_RESCHED_LAZY flag definition
> > 2) Checking for TIF_NEED_RESCHED_LAZY in the appropriate locations
> > 
> > 2) is handled in a generic manner by CONFIG_GENERIC_ENTRY, which isn't
> > (yet) implemented for arm64. However, outside of core scheduler code,
> > TIF_NEED_RESCHED_LAZY only needs to be checked on a kernel exit, meaning:
> > o return/entry to userspace.
> > o return/entry to guest.
> > 
> > The return/entry to a guest is all handled by xfer_to_guest_mode_handle_work()
> > which already does the right thing, so it can be left as-is.
> > 
> > arm64 doesn't use common entry's exit_to_user_mode_prepare(), so update its
> > return to user path to check for TIF_NEED_RESCHED_LAZY and call into
> > schedule() accordingly.
> > 
> > Link: https://lore.kernel.org/linux-rt-users/20241216190451.1c61977c@mordecai.tesarici.cz/
> > Link: https://lore.kernel.org/all/xhsmh4j0fl0p3.mognet@vschneid-thinkpadt14sgen2i.remote.csb/
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > [testdrive, _TIF_WORK_MASK fixlet and changelog.]
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
> > [Another round of testing; changelog faff]
> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > ---
> >  arch/arm64/Kconfig                   |  1 +
> >  arch/arm64/include/asm/thread_info.h | 16 +++++++++-------
> >  arch/arm64/kernel/entry-common.c     |  2 +-
> >  3 files changed, 11 insertions(+), 8 deletions(-)  
> 
> Catalin, Will, given this is small and self-contained, I reckon it makes
> sense to pick this up ahead of Jinjie's series to move arm64 over to the
> generic entry library (which is on my queue of things to review). Even
> if we pick up both, it'll be easier to bisect and debug issues caused by
> this patch alone.
> 
> The fixes/cleanups from Mike and Valentin look right to me, so FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thank you, all. Much appreciated.

Petr T
