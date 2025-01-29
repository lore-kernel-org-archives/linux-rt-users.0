Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A61AD403;
	Wed, 29 Jan 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166224; cv=none; b=u4CZX+ouT3qeLGfOxxPWexTcK/7VMq3BzxK+9IAxCoZLfVqHFHYodvuyEaMq8K9JQUh/GfuCSZEbX4IBIl9j+amwDfRbq99Ox/Aon2951OMWrmTrZo31YgH0od87vUhpYXIvSASu8Iz8Ta5n+nM1JZCtf15gVimU+pq8omeA9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166224; c=relaxed/simple;
	bh=r6yuW3Sgr6u/n+twjtBfFoCBBewfWxrt1X3VjwBu4Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j18qnvhJH/cYd9c+/ZHn1qMTYrdze/3gir3NN6+fQvD31/Iio0Vw1NgJhfKmaRGVm6utBa4P4EEyXNoADazmPcYSfCnPuDK18INWqICX9IDrI2iSpxKTx3wR8yCunLynqH8m31VEsfrxoNAuloa4wDjs9ocA0dycvFHhUTOcke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wYaltYM0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eYUfSpY8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wYaltYM0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eYUfSpY8"
Date: Wed, 29 Jan 2025 16:56:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738166215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Htr9rbXf6QTrcN/tVRoU5scLZ8lfKkpO6IkO6sc9cOM=;
	b=wYaltYM0hwBihRyejKp5JfHwcFAISn1y2IynCZldLo2DX3EXRA06ZozF1SzxiYzxS+6TvU
	KcKWJ9cRlNnLWNwbkaA0xuVzwGqm/WU+ruGBLsIoTw5iYcYLhm0epir8ILetS06c4c7e18
	/+bSri2Tv6lNUvowX2USqfjy+7y4qMASUfFKC6jousHNvMo2L/va47rNf3PcgoTKjFsRxY
	kfGeS26br38YFcT+39Ds6KhxIutAssgX1SEGK5lFPwza4ZwYX11Z0v8fxSFb71APOCCmXX
	5NufTgXLRI8HaEihmNjHJUxs/H/SHtzq/u/07iA+EqQEwGqmVOMs3MACCNp+hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738166215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Htr9rbXf6QTrcN/tVRoU5scLZ8lfKkpO6IkO6sc9cOM=;
	b=eYUfSpY89YwLq3vMLy2lKko72hMXaa85JLSxFmeF/bicJV0Q8GpEdfdnA2DXfqwhFjBwZd
	gmNG4p1opNbkIjDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.13-rt5
Message-ID: <20250129155653.ft--mpP6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.13-rt5 patch set. 

Changes since v6.13-rt4:

  - The update of modules core clean series in previous release led to
    BPF trace breakage. This has been corrected.

Known issues
    None.

The delta patch against v6.13-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.13/incr/patch-6.13-rt4-rt5.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.13-rt5

The RT patch against v6.13 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.13/older/patch-6.13-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.13/older/patches-6.13-rt5.tar.xz

Sebastian
