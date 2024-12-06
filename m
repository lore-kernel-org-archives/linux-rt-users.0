Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC71154BEA;
	Fri,  6 Dec 2024 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500026; cv=none; b=IKD7H3ZrJ//tiEg5aqupNwxJ0movJW5KbW+tjIXaq74dk6ZqAyGXehmunKDpQOS7ZlYblBYxJBFTXqsLrZECWbY3e4VBrL3cgmTWKQqhOQTfoDKCPugBip4B/vj+lDVN3dZIGISfLJqo2pAEJ9SEp6XSoHgPn3dB/amMjJ1lI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500026; c=relaxed/simple;
	bh=K/maEQLHx5xJFz29GlNJRloqFZ+HzL1xkfIvERWefDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vu02VwXFu9Sgp9v7M01PTilL6OJxuW7Vzk9rgZxsa7CqmQ9TUQ4kB+PyByKDg737+4neY/o7CaBJb+SZSB6ibWaenRCWe0twM8E+/kzLaVAdH3CE8u7MSnh1WadiV4dyAkBjjORPYTHQebtWDDTVfd+cx21204mb3aCu6yzeewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wuaubhIh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OEVuwUz9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wuaubhIh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OEVuwUz9"
Date: Fri, 6 Dec 2024 16:47:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733500023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RjgjuBm5GBllIQyYDLxe9sOmMipkSxhqRQM9Pvgx/K8=;
	b=wuaubhIhMeA+NzQl8LwfPTnFWy6AJ2UkWcAu0Rd4B2G0UCi9xQ0IU9/d1OhVx3DW3HZvpq
	c2wWkBGBsdosiEMG8xygI8Buto/nmEhdffbhnpPrCj1KN9dHIAt4Bwh4m1RB6Je9tOFnpG
	2pdW8D2q7NkshGrh3DNgr8xwlqFa5cKr4ZpcCXhzSlRgFRP42EnnID5BsnTgpX61IDFh8I
	I8IBu3ydaLrHT0ZfiJUSR2SSVooEnHV9TyS7Pc7L74SYPwjaIeL/YKfAmv/8NIAOY5xnNa
	NO8bimqb8+kG/5hSgqkklUE55qX/J9CDK/2QOYOplXQN1tG4I0EGEWzZ3FOoiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733500023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RjgjuBm5GBllIQyYDLxe9sOmMipkSxhqRQM9Pvgx/K8=;
	b=OEVuwUz9lvhHQyG3Jk0cIqZgKA4Z4d+HLScGamF+4Quf5QTOybLSlAvoilk9i4EPeGvcZQ
	Sf5qFHAxEv+7XBCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.13-rc1-rt1
Message-ID: <20241206154701.8XBv1qNE@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.13-rc1-rt1 patch set. 

Changes since v6.12-rc4-rt6

  - Update to 6.13-rc1

  - Down to 24 patches (including three new). The v6.12-rc4-rt6 release
    had 42.

Known issues
    None.

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.13-rc1-rt1

The RT patch against v6.13-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.13/older/patch-6.13-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.13/older/patches-6.13-rc1-rt1.tar.xz

Sebastian
