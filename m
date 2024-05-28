Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758C17167F;
	Tue, 28 May 2024 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909078; cv=none; b=o+8Hv43Ync2EXjzDxwnHb7JelJ0BYIUNKL3W5LT2TDF5qX1iB2C9WgPm/pgMWO+BGNzfBGKTYO4wBnU89s7qaVt7VpARG2pT9WirBeMavcN79bnox1EWgmw67ZQM3OnKrlQCorv+/Tx8xYi1U/bi9Gl63OjhRwv0AN5S8hbK6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909078; c=relaxed/simple;
	bh=2MwryXS5DUCUlYI0P7wmmi6zhh9zR1IfbjFE/J6YL70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l40UpH+X76X/7m8r5Fw5mAWz0z/QWv27hbvG4fJ2IBd9nX/qMhnL2BsMRya/dhSBIbQ1VuAqHPlxYzwBlVE8rxPTqJ7O4fiuDWNAuRJDfqHZLE/Z2QcITCIfypDOLDhjOT4BgGxBkFFvHLDpS+3FmfvnH8gGi169VuXCZEQi8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4oLIZTPy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lgAFt8/d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4oLIZTPy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lgAFt8/d"
Date: Tue, 28 May 2024 17:11:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716909075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5+q2UDSKOGJCMS0+rKaAga5k3MaaB0k6nYqw8puocvQ=;
	b=4oLIZTPy6HfQdRwOb9iZITA6fvKFl8oeJ+ZU0/GUSI9y8QAXBZZy/Mj7xXf/6FKVA7em3i
	QHPrGlPZ4rJ7osKNNr7CdHZ4FdsRP2f9FteP6x5yy1PLUaKk+v2Tpt5WYOzvEFGM7A3kK1
	i73tbd4nZp4tjHQiL4mM/L+DQQS2M3yXdXiRJu+SOSAG+6CeL/V19hM3f9D2cwbgl/uzvt
	vbasMGhGYGmXIpbaiiSj3tk240sXRLMdvz6n3vlktXEE34mO8LCyoNCJWjhR61wHcADy0J
	m7Uy0otzkEl6I+eV6Q7/5R4x1cz6SoSU87x+MtK9OuW03jdTTCl/rNQU80XJWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716909075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5+q2UDSKOGJCMS0+rKaAga5k3MaaB0k6nYqw8puocvQ=;
	b=lgAFt8/dgxRa/DbgxRG4e7l2O3DAx9Qf3zt9sqkwd9Wdju8LwuyyhC0Gqwk9Aef5uSIgI3
	CZ5UglW5kR6Qp7Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.10-rc1-rt1
Message-ID: <20240528151114.oRD6WQKe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.10-rc1-rt1 patch set. 

Changes since v6.9-rt5:

  - Update to v6.10-rc1

Known issues
    None.

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.10-rc1-rt1

The RT patch against v6.10-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patch-6.10-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patches-6.10-rc1-rt1.tar.xz

Sebastian
