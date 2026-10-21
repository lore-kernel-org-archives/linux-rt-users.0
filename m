Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565328;
	b=sKrjDnxyag4ypNvCF3r2l7traAIh+YQfeeO6FGfPEac4DQtzPSt8gKVeyQtY0kJ2XGJL
	 v+NTkoL40Yt2OP3vzlP+9WJBgGqNBd1ZLKN41BWWckMUId7hyrVm7rmLMqjhw1CkjTrUu
	 yy1vOlHO3Fkxs9AYiCLo518M3BCCpwSoymtRctyMce/hwDAlyNAULhjqwuOmARZm+Cko6
	 krzOK9us9ODN9qhI28PBT1vTBztzRMJYbP0y/165BXJQsLbqceamAHjs5gJvR57LeWh5Z
	 0W7pVcAHMtyCLzUo+YBdKZqHATAb31Ox+lpEIs37XK3SRJImNqrrlxI3fyAu4Vi290Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565328;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=lbDYTq6pZ2AVgxzdq4GniOK+XX4ME4V8hGldgOwtNto=;
	b=22d+JbcC3rEkDD2QbrWZO5/u9wWTqfWfVNm57C6BtU+oP3N1hBz4/1gCLpStbSlN348q
	 tA+68fgZ8eCN2K8nB5DL49C/2BwgrgegdX8v+sHHyKkauG+TQdHqSMXLhLwF9SUUii6Da
	 RmVkCKEH2HS9qWN9Tk6gg2V0MIl7+YUTq8iMO+4yJrf/IniuJuPicvFEJbcTQx3YSoFa3
	 /vc8p/o5436mvzBBtC+t78xsD7feYYKgujXUg7nLId/d9VegI25hRGpR11Hf4tMQAXFHm
	 0ssWq+nsbl+Jh6YAqPdSnGSJxdp0Yg1QVd/W75F333CcPBucEByIi1JORHa7xXNLGMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xQfVOIxr;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Y7VJlr3k;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443F606A31E
	for <linux-rt-users@vger.kernel.org>; Wed, 21 Oct 2026 06:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1443F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xQfVOIxr;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Y7VJlr3k
Date: Wed, 21 Oct 2026 08:48:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792565325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbDYTq6pZ2AVgxzdq4GniOK+XX4ME4V8hGldgOwtNto=;
	b=xQfVOIxrOR7jtu7H9GE9CEPMDW5P1rX/hwcE0p14bU972Zku/ug+BHFkIYZpLqFC0ARWqz
	1v283+0Xaqm7+4i4KP+7I5K0JKX90KUyB/ZTU3twHy9/KVHfmKKBNT7+4jyLd98oe/ER+L
	ew2mQd4JHqi/HqymRZiLyL489NfLDVTT9bxCLfJls5I2t8cPzfeykXbxjbqDHg/Q/5tLv9
	FCWZ6WOh/xYe7gftanSu7NOpJ+cjToUPJAbIp81/b8NZ6N/njJazgR7bLcCuh7GtXoVfoD
	Zecu7PZYuKKI+hs9eMgHP8gEd3XXvDpLGD8/dSjJTDuz4+g0cngc3GNXH/cWAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792565325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbDYTq6pZ2AVgxzdq4GniOK+XX4ME4V8hGldgOwtNto=;
	b=Y7VJlr3kHC697ezf5CtIcKpY/ifsXR1gfakYAJ0PF27uWDv1Agk0pj3kQ735k6KWH4w0A+
	Yk+9gI4AN39l0aDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Bart Wensley <bartwensley@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Restore tracing parameters
Message-ID: <20261021064844.SBwm7htb@linutronix.de>
References: <20261019102909.3339372-1-costa.shul@redhat.com>
 <20261020101646.Xb1lEbqY@linutronix.de>
 <CADDUTFyDT4Bx_MEpF9tCZfm9ECP33WatpfBjQ=2WH0dpRrXodA@mail.gmail.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADDUTFyDT4Bx_MEpF9tCZfm9ECP33WatpfBjQ=2WH0dpRrXodA@mail.gmail.com>

On 2026-10-20 20:39:27 [+0300], Costa Shulyupin wrote:
> On Tue, 20 Oct 2026 at 13:16, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > Could you please get rid of the DebugFS class in it?
> > The tracing folder should be auto-mounted at /sys/kernel/tracing by the
> > distribution. Currently it is also auto mounted at
> > /sys/kernel/debug/tracing if something is accessing this folder and this
> > is subject to vanish. Mounting it does not help then either.
> 
> In the OpenShift/Kubernetes containers tracefs by default is at
> /host/sys/kernel/tracing and /host/sys/kernel/debug/tracing.
> Therefore, only the DebugFS mount and umount are redundant.

Interesting.
But how does this even work without extra glue around it? Is this the
global tracefs or per-namespace tracefs?
Does this still work with CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED=n ?

Be aware that this is the only tool in rt-tests that still uses the
debugfs path.

> Costa

Sebastian
