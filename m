Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE0280CD4;
	Tue, 10 Jun 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542593; cv=none; b=JVAn7ui0A1xYZBiBhENavZQBg1f+RanrWOY/M52f0oBZZCyPVdmSKfd2T5q8ujVQ0B14WGqTi7PAM+QYAhrblVCQkwhSVzttDHKwm3MJaqtb8zO7/2usDOsCxTHtiHbWZXSQejd6Gsr0fzCx+CBjWF0RmSquga1VgzKo+pTq7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542593; c=relaxed/simple;
	bh=iQzS2WQbWOWbTOyrLzsF7RCjMQgnxOw9QPaZj4N8AeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S7COoLYh6tG//JZsrvV4McrMG1Z4gDOirSe2k5qjGwlU4nGinNq9uup012DI1e7M4J8SemyIFeFtqmD14q/r3l5r/Xw+ruuUn2FobppfohWtwZigqcwc56RmKp9Y8dBIDdRgLJqRldqs33G3irK14j8qKEhWrKdNA30P2vTS4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WR+kp8Wj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HxIJlttx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WR+kp8Wj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HxIJlttx"
Date: Tue, 10 Jun 2025 10:03:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749542589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JC13SiAcnC4HIaDrqQGIIFsY3yqn/Wtrmzioa3Cq4k8=;
	b=WR+kp8WjxxxFIbVZpf53RuGrpOFXE/VcmYpHWfiw+5vYv4N8Ihs6oYjkJ+0N2SebE53/8D
	FNmyixAT++U0DQJVTZnyxhu91nMV7fvJEqAxKG4fQowRMyRwPAP+fX5M6gndv+t9PP4rUl
	/dv7pbbdzPSLCCbG/W1UDzcWIyLFDZtCeipEGjSbjnWYF/Sgz7GHcKLF4lwvkc7oViHPQM
	IlNt048Iy661Rljd1lNwHRbVw816vy0gTV1mTqR6uD/P0Ti1GzPvtaEfgwjsIeo5afEN5R
	ol4YmQ1FWkvy4oc+k/XLs018DLWK7HshkSgT1HNCnNHFyovI25gPKe24b4fetg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749542589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JC13SiAcnC4HIaDrqQGIIFsY3yqn/Wtrmzioa3Cq4k8=;
	b=HxIJlttxslVBs+pdU/XrOO1m7VBqxhP/fQj1Nwf60Eoz9vJ7hYZ2OWPzKd29gl+e21lTQO
	hKEhgWEyY4tCMvDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.16-rc1-rt1
Message-ID: <20250610080307.LMm1hleC@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.16-rc1-rt1 patch set. 

Changes since v6.15-rt2:

  - Rebase to v6.16-rc1

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.16-rc1-rt1

The RT patch against v6.16-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.16/older/patch-6.16-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.16/older/patches-6.16-rc1-rt1.tar.xz

Sebastian
