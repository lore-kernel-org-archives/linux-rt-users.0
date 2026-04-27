Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791182F3C26;
	Mon, 27 Apr 2026 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283565; cv=none; b=Pmy+lXQPcaq2dVmt4EjkSspeO1xGAvfSeouhyrKZzCkSQNykI8fpNFD2PJP43YjD2MUJFoa7q9vzLNTllK38y2wSLU42t8tdrt60/+WuNsdap1DaW9tYMxhBOvfPPWZ7O+H69N0Ne7yPOeaR5RQ0jXMLUv0lsQxnxQZT7+x6qdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283565; c=relaxed/simple;
	bh=juGReLISwsSDnUcJHI63vvfV0dckTjTGF6GaQNRDxD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X2ZDbQaYPvI2XGlKmuEADPW81JVvutgceIZNHM6ritymxujVpf6Ej4cJ9rG79h6N/iKkuLJFvE3ciJgiykStPPv8x3Qb2AzpQnD6AQFOLncx838Z+x5ucExmEN4BB/F6xLRs51TaZjZoZbqZSBq5IsBKIV9/dxCTqNdIHWuqsp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r4VUfByb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HcCnPxCV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4VUfByb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HcCnPxCV"
Date: Mon, 27 Apr 2026 11:52:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777283554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=kKSTvHEmvGUMnjux87QxH0lxdaYcAD/N4I3xb44sztY=;
	b=r4VUfByb8/jYLy9ZQ/wWaWVLeiQAV1fMGatVVzZhRu0sDidgdOWImY0uojtvgarqk/yj9o
	VJGVhljfGAVFW7yQ71eDHbGTzmS5upzkuqX9cmFDhdzGJoSRrq6xNGO9SzkYhxZbv4eep0
	tTmC+VlKqUSu2ad5DUygWgEKJVHVfWge7Tmf6qkmrq9Jpq4NrVDx4bLbYMektUUemdHAwa
	Z58ggMntL70H+cMWUEK8p/3upsp+IgRN2Jmch+YMshDart9queMYutH3GxhbYQdu/SdpRV
	3CDe8nJoS/TGp4v3oOcH5p2e5q3ovy98Df1aoMONFoD2jLAwpw+Xx08nzuKkwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777283554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=kKSTvHEmvGUMnjux87QxH0lxdaYcAD/N4I3xb44sztY=;
	b=HcCnPxCVq3R6VhOCifCU7ehngufQrgtCsGY4Lb/Nd+hnMoZJHzN0SXVgWdUynEdQyEPkpW
	ADsm8aQkSdrl+8CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v7.1-rc1-rt1
Message-ID: <20260427095233.W3oOiwbB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v7.1-rc1-rt1 patch set. 

Changes since v7.0.1-rt2:

  - The ARM patches are gone. Everything required is part of v7.1-rc1.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v7.1-rc1-rt1

The RT patch against v7.1-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.1/older/patch-7.1-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.1/older/patches-7.1-rc1-rt1.tar.xz

Sebastian
