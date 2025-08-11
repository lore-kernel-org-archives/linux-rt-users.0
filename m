Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84803594F;
	Mon, 11 Aug 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903766; cv=none; b=d+tnseF5jnOX7MboYLfAGhCbeJe8Mi4cT+MS58/MTJlxayRP+kgECG6Zy1g5wAQ2sroMZv59CkBgBVEB09+dTqWRzmy81pNP/Owy+ixM4F0ysCGK4Edz90YJ9Y7ab0ZHZ+4Vc2be83laLKmxEUfDEOyP0J089gu+AkCBEz+uAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903766; c=relaxed/simple;
	bh=3gvCQOh6C5GJIsuPURtBiqN006xYmsfrt4uX4V1wT1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEvK5gRkV0maibQ9wDKwo3qlqUc9cr0m7v8I5fC6kHeYwz+vOcRuQz/Vc//NrmgJtMnzjy57bNYEhIFBgG2h1JlFdxhuGiufpnAiQocuYK+pujIMwWolpuNhhl+1h4zRGHtQoxbDwDvMSt0ufWEEgmQ9Hk8n4R+SLSBHdSHRJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k/obJeoS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dT6uveYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k/obJeoS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dT6uveYr"
Date: Mon, 11 Aug 2025 11:15:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754903760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xhk8ImetUzF8D0zaYt5H2LhPKkbfmmDl4qiWDQ3+Yns=;
	b=k/obJeoSdTlreKOiO839gioCZpb79DC5QxDpfh52u1p/xuxIrl+bABA3xf2OuizloY/v/2
	IdcFODJhgq8SnAn8VjkqAclaKNASSsIUFYym3gkVt/FiV2IkwduMQOIxQawTcpz9CqmVva
	FnrZjDc1MdiAjzv589070n9Zx0ma3vNQZw7TQpksyTRp4X8w/NwjTC1qmanxXnlE9Ku/tP
	S3kZWNsjSlsOFZrQhvnyYbN4FhLyX9zaMSVha8o5vqpDjoGzbjSjpmZh1EX6hmRdO0cxS0
	77KjbhNX1o4f+lR7C4XA+qsLg6/ZHmRjaGm/va0aCle5ZpTV42WaL67uWf+9KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754903760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xhk8ImetUzF8D0zaYt5H2LhPKkbfmmDl4qiWDQ3+Yns=;
	b=dT6uveYr/y0FouDVq4hoDzonHMQ2drGBSiuSMB/5VKBKTzJ6ekocxWOGZI5fSYGfynbZ1O
	xHx2EXNWKjxGuaDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: linux-usb@vger.kernel.org, linux-rt-users@vger.kernel.org,
	gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [BUG] usb: sleepable spinlock used in USB bh_worker softirq on
 PREEMPT_RT
Message-ID: <20250811091559.CXIs7FvU@linutronix.de>
References: <1f8dd706-0eb0-4e09-a0fe-fc48fb24005e@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1f8dd706-0eb0-4e09-a0fe-fc48fb24005e@kzalloc.com>

On 2025-08-11 00:05:49 [+0900], Yunseong Kim wrote:
> While running a PREEMPT_RT-enabled kernel I observed a sleepable
> spinlock (rt_spin_lock) being taken from a softirq context within
> the USB core framework. On PREEMPT_RT, spin_lock() may sleep when
> contended. This is unsafe in softirq context and can cause hangs or
> deadlocks.
>=20
=E2=80=A6
> I believe this requires a change in the USB core framework rather than
> just in individual drivers.
>=20
> Kernel config, full logs, and reproduction steps can be provided on
> request.
>=20
> This bug was uncovered during my work to fixing KCOV for PREEMPT_RT aware=
ness.
> Link: https://lore.kernel.org/all/ee26e7b2-80dd-49b1-bca2-61e460f73c2d@kz=
alloc.com/t/#u

I'm confused. Is this new or this the same bug that was reported by you
in the thread you linked?
The kcov issue should be fixed by
	https://lore.kernel.org/all/20250811082745.ycJqBXMs@linutronix.de/

> Best Regards,
> Yunseong Kim

Sebastian
