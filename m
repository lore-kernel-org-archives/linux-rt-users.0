Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF12741AC;
	Mon, 14 Apr 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643118; cv=none; b=BhGZlncgLM8RU+y01RMPa52hVmT4b+8AyzhTqlIi84ZQSb8FVS+u7ooRduu74g5JLXgVqqRj5a1VH43M4YI7XcAk3pdF55S5kSiwGL/FddUcozCnCjh134ghyogq6ttMEXa9MVx9183HlmrVIQaJ6+H7e4PBQX3g0JbaCqFyGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643118; c=relaxed/simple;
	bh=xSsefidwkQQEb+BcLhv3m4oET2YQz0MpbC/lMk/QTwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsuIvoGcMkT+60HLM+fYmCExU/js861I5a7C/PMNpErEhDXlE3Gbz8dHIbxfn+E5zYHmRYctqBTRlpXJyMT1DJjfn6c7fBQs9j3Y+Vwy9sDrtJEABhN0Ibt3ARTxfEIeaZoNeMtuUk7EtWyILmHmaRAIRelvYLsQVA+s7MFqb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TGrAF6SJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JzE52I//; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGrAF6SJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JzE52I//"
Date: Mon, 14 Apr 2025 17:05:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744643114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xSsefidwkQQEb+BcLhv3m4oET2YQz0MpbC/lMk/QTwI=;
	b=TGrAF6SJKEElFGObG3hgqyKIbggF/zZaLjMPxRFYfu6HyyG9qLC5xkyDc6FH+CGjf6nw+6
	S5p3VLXxvalPSsX0Zvp7SEuFlurnzgRUnpHLxxRRuMTG4Xim5i1KwDQ65U91i5wxmFclM5
	iMAthUSoPp8kU+y9PnrqwpOIfhtCSNmMUzr6/zAHSUMXFX0T7638JY9sbaIWCUUKcSLEis
	JIXn73BEtZ6XWA0C6Cf6nC11jb/VrchfvlkoXHpjMDA9cH0YI2fkoJLraAeT/8l4yaIoRi
	BQgTMrMzul+YDETM+bOHvcpjS2vQgrtV4tplJ5w+nA4LLuqswHNkUn+UD99/nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744643114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xSsefidwkQQEb+BcLhv3m4oET2YQz0MpbC/lMk/QTwI=;
	b=JzE52I//96asY/L2/ENCKbLE7szl8F18EpZ8Dl8sknsLCT0ui3Yy55MfxWeFAdbh7Ao/I/
	Ks6FFyz9/vTnpADA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Aaron Lu <ziqianlu@bytedance.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
Message-ID: <20250414150513.klU46xkw@linutronix.de>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
 <20250409121314.GA632990@bytedance>
 <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
 <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>

On 2025-04-14 20:20:04 [+0530], K Prateek Nayak wrote:
> Note: I could not reproduce the splat with !PREEMPT_RT kernel
> (CONFIG_PREEMPT=y) or with small loops counts that don't exhaust the
> cfs bandwidth.

Not sure what this has to do with anything.
On !RT the read_lock() in the timer can be acquired even with a pending
writer. The writer keeps spinning until the main thread is gone. There
should be no RCU boosting but the RCU still is there, too.

On RT the read_lock() in the timer block, the write blocks, too. So
every blocker on the lock is scheduled out until the reader is gone. On
top of that, the reader gets RCU boosted with FIFO-1 by default to get
out.

Sebastian
