Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3B3FA5E7;
	Mon, 21 Sep 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988032; cv=none; b=OUExZJRftlfdDHFinp1M7nIMDfJioZeWF4bnllfBiMRkMtjtCdCFY7+B+sEXNqsnqUfi+SnhA2GJYLjIdr0vjQm5e9NW0W9cIEIm52chTvaPkO9RumpU8zjNIb+RJn/kOH2PxOwklp6P/LY/sziAXx2QdVtfLvi6G2Jmg2biJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988032; c=relaxed/simple;
	bh=kHLnhesuJrSiC9Nfi/VAZvYEVSl7JHYbRAIaOgxzWuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Ot3pdi/IG2I9eavbmZ6BYlHqLRNh5aG2vV7BpADeSmsV3W1KNubonwLbLZjF/xfM0LJGmhjSVRflUWGTdsaplhc+9/mfCPK4mPonybv7QWUKwavunwbqi8o0/IyXULs+fFnqyHolFhlIyuH+h9yfEk9ScWPmPXHTTamMUz68FTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KGal7qDn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KGal7qDn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
	MIME-Version; bh=kHLnhesuJrSiC9Nfi/VAZvYEVSl7JHYbRAIaOgxzWuA=;
	b=KGal7qDnEC9VPntHQqwrR7fFHtkcY3/+388uCgpr85t5+usfHKITxl90KrcsE5
	qRsQsu4pHlUzriGDmmc845HO+RUqJ51PRtst1YzGMUjMXRsOG2ibAwTKM874HIBG
	lwjZwiRuwVxelX0XoqDs5N+dPrJHNfD3XBqqsstYNRcx4=
From: Quchaosheng <quchaosheng000406@163.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun@kernel.org>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] sched/proxy: allow SCHED_PROXY_EXEC with PREEMPT_RT
In-Reply-To: <20260921100921.PsZhWgmh@linutronix.de>
References: <20260921081525.2982361-1-quchaosheng000406@163.com>
 <20260921100921.PsZhWgmh@linutronix.de>
Date: Mon, 21 Sep 2026 18:51:44 +0800
Message-ID: <178998790498.3308959.13462163523351109568@163.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l+xeDLFqVl_LBw--.21702S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1xKrW5Cw4rurWrWr13twb_yoW8GF1xpr
	ZYqw1UtayDWa1Sg3W7Cr18WryFkwn7Aay5Ary09w1Iv398KF1Igr97K345CF9Ygrs3G34Y
	qFnYgryrCFW7ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoqcUUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AAil2qxDGCH+gAA3b

On 2026-09-21 12:09:21 [+0200], Sebastian Andrzej Siewior wrote:
> Why exactly is this a good thing to do?

You are right to ask, and the commit message buries the answer instead of
leading with it.

Under PREEMPT_RT this changes nothing at runtime. p->blocked_on is only
ever set from the native mutex slow path in kernel/locking/mutex.c, and
those call sites sit inside the existing "#ifndef CONFIG_PREEMPT_RT"
block, so blocked_on stays NULL and task_is_blocked() is always false.
find_proxy_task() therefore takes the "if (!mutex)" path and returns
before it reaches mutex_wait_lock(), which means both accessors added by
this patch are dead code when PREEMPT_RT is set.

What the patch does is make a combination that the Kconfig itself already
documents as broken ("Avoid some build failures w/ PREEMPT_RT until it can
be fixed") compile again, and drop the RT stub in include/linux/sched.h
whose parameter type did not match any caller. That is the whole of it.

If that is not worth carrying, I would rather withdraw the patch than
argue for it. Enabling a config that silently does nothing is a fair
objection, and teaching the RT mutex to maintain blocked_on is the real
work here.

The v2 I sent shortly after your mail crossed with it; it only fixes a Cc
address, a comment indentation and the wording of that note, so this
thread is still the right place to decide.

