Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490730;
	b=wudEcBc/UeiWlHsJhsLROQ/yzvDFHrimQxHqIoJZJ909FLbaU4FhgI0lKPV90K5RWGEj
	 9+rwa6Rzb9rH83OSBTeUuizdK6ZX8QUGHzHLSCcnIUvkLBnBlrLiiYfbeeWPpOABBZsId
	 Zr7ieQTand26lACJFnCNq2tOR7bI/0sM0H9e2KiLXACq9lHJP1inOMGLw3YoPfV8JSsdm
	 RpRevVNcD2qHgtVVCoRAsFW6Dq3pA+nR61wx6PM/bHwZFF8MgN6uPZrtcK1tQIs1K9KZI
	 ADlGgD+juq3BZOX35zGRJ3wwmx1FDyUIsYadZGS8LLkpaxi4AMLaAPg4QsjDiuXE4Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490730;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=qItBt+DFgWhv1B9ZYISs8CvA8pwyeh2Gsl39HWiVk3k=;
	b=XSft6vreKpvXlXMv5XiNd04ztRXpp5TPEKAp9w0nmlsQaqv6BKB3I3aKHCpY1dmgWHym
	 csX+73IxX0ZKqYd9SgOvY5HfaH4IwBqYSnArLsilLQhVAxv1rSmkfAXI375uuZeZsWpEM
	 nx2+hmBQG3e3565R+3/FJRZRayDWD0Gwxt2AzGSfAK75az7I6HUfgdmHRnlp6KpWIngQu
	 uI6TgSaj7HjsA7oG9vr6qR/sNXbcRBUj7pyv/CV3M6+FjKx/EH1TpGOUC5SmHvkYmteLs
	 AOD3uRjJ8eJbMXN8U2nEU/lkZKWLqP4kqiKc8A3lzsemos7qjarhF/N/tiwmwqhWABw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=oGlkVURa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GJN759Vn;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585F606A31A;
	Tue, 20 Oct 2026 10:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0585F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=oGlkVURa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GJN759Vn
Date: Tue, 20 Oct 2026 12:05:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792490727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qItBt+DFgWhv1B9ZYISs8CvA8pwyeh2Gsl39HWiVk3k=;
	b=oGlkVURaFhoWiffZRqZp1jTkdTdBA5BVtziSWh4+/g23wdR8F2c8tEramFdEJXIK3mdczG
	FEr7tbuuUchw00Jy73ezr/1b8Y2321LTA7Q30tR6+H8e4riDCVj2MAzFrdfU/4fPhppxs1
	53XK8RLCXhKbXHFkwsnpuWxAdNstOdex1hIdoQWLqJM3FSoOcR7RmqNudChf5q76Y+2hBZ
	KcqWBy8okgxRHirvpwrNZKvPvplHZ96AATFSKDvkAIADiPhOgmB+DvUTrbX37KzuBaEfaR
	v6+zlF3LBf1obSOiOWeGlpOllbnxPd0ySCc+IfN2cBCdOuV9+T2Oyjk4+1an0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792490727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qItBt+DFgWhv1B9ZYISs8CvA8pwyeh2Gsl39HWiVk3k=;
	b=GJN759Vn2D8oORGwaNgtfecfV8I24YsXeleSX9SOS5cios2E02MvQkVQ1c6VkD6wUK6FQW
	MUYFshEjzmLv/6Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.18.57-rt9
Message-ID: <20261020100526.bFEM4NFd@linutronix.de>
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

Dear RT folks!

I'm pleased to announce the v6.18.57-rt9 patch set. 

Changes since v6.18.57-rt8:

  - A printk related change was merged upstream to workaround a Hyper-V
    related freeze on boot. Patch by John Ogness, reported by Derek
    Barbosa.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v6.18.57-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/incr/patch-6.18.57-rt8-rt9.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.18.57-rt9

The RT patch against v6.18.57 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/older/patch-6.18.57-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/older/patches-6.18.57-rt9.tar.xz

Sebastian
