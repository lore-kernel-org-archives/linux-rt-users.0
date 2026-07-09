Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220482D7DD4;
	Thu,  9 Jul 2026 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604202; cv=none; b=cFAJhRMeFwqk6S0ITCCoXqoLEuLgiHz6/KID3pbO1qUP00PvlikIc39SV/CzgdlobE30AREcyu6ey6eqIrrHBeD4KkkLmWlnGivRIbO3w4XIJUmgvYkJCwA0ebgyG+erkeKou2OYLe8KDZf8mmKq4rAORDfmH3sBaHAFMq5SCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604202; c=relaxed/simple;
	bh=BMeeq6fIt5jL7uijqlCJzenfKPQy2/kxMvJsSDX2bAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EpeX5QXjM5F+nmAhLZTk06NC6xJ8Hp1mWRGybRK17AmpImve8gPo2SBA3hSt1bFYf6HOsdSAXC6lU/m8sf+1H0I0A06UL/mMaSd2HBr9VVVzq8Lz2J4+E0PA8sXHHJsuih0qpH9o2kyQYumMh3mIowniJYAlVVxtPD+NjGoS9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zZ4FHlQo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+EenamWD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZ4FHlQo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+EenamWD"
Date: Thu, 9 Jul 2026 15:36:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783604197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uZgeuZ0n0lLdBlNmhh7Wr3J2Qtsvn8CcGUa5btfbdps=;
	b=zZ4FHlQoW5Z7KzKFkGXwLYZBrS5glKHeYedEJbDSas06B3Cz0GHj68lviPt0nGX++uiNnj
	Gd3PJodTV7hoyfr4uLMDi/dBAEw2tMBJ250yvOaJthWomJ6E2BKsZwSeMLpcTXfd6zHfSp
	7FyhMRETCsJJKp13W99gDdpY5qzTt3M3mWpOrgWc8Ff/HtAs1CKjUUdY9YR9AwypUyTByV
	V+V4PvVPb4CExPrPRP+mC1WaE8n7tttnE06aDA0VmdWXxK/1hMI6Gx7maNgR42nBSxPZBd
	w+Ipf1cOAL0aZt3LIlEpBx2Ezdy5GuPdF6iFBRwybiMhNgm5p3/AacI90KfsOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783604197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uZgeuZ0n0lLdBlNmhh7Wr3J2Qtsvn8CcGUa5btfbdps=;
	b=+EenamWD0JXGxeHyi3yY4KQF/ODFdJdAVKvHkw2KdAsOSKSHP8gjJcIuRQela36ZRI8X4F
	9KDri9Xh0mcLZ5CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v7.2-rc2-rt1
Message-ID: <20260709133636.26mUnPEb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v7.2-rc2-rt1 patch set. 

Changes since v7.1.1-rt2

  - Update to v7.2-rc2

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v7.2-rc2-rt1

The RT patch against v7.2-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.2/older/patch-7.2-rc2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.2/older/patches-7.2-rc2-rt1.tar.xz

Sebastian
