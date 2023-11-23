Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nO+7OrY8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXRMzurp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338B5199C;
	Thu, 23 Nov 2023 07:48:25 -0800 (PST)
Date: Thu, 23 Nov 2023 16:48:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1700754504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GGBNiHGzoiIME5WzDOjeU6yIMJyG9M6+3L0+44mBOOU=;
	b=nO+7OrY80am5M+YonKBgPmJZQEJpc+4FTIvn5KVhIZuOeejBhGHdeD+qF3ntVlY61tr8pt
	eNEPDnaaj+ktU3lL09cGYnVGF9iVetY3lY60YiPtE8XtZQM94BclOMP6uqSiFyuADGX4uO
	UF+L1al4+e38Hpmu0I7OVl+j3yX4YjyuYh0R/PUge/ejCIWuzIAuRQn1hTsSYrVLwAEZVq
	5tArHtzBpGzgnhA/Ls599STBQxQk0aBeBp7tAw/4dqdFz8SFR5G/0N60oiE6uCBGPXrpqK
	Dac7v5XMq9B2glZyJK5RUtPlkl+vX7sUVk+vhyT1W7kM477AjQF9qiJ0am+/wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1700754504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GGBNiHGzoiIME5WzDOjeU6yIMJyG9M6+3L0+44mBOOU=;
	b=ZXRMzurpnA7AjhGzxIOD+YKqZv/pEXZfPC7OoJeYJFTPDn/34lcWPpt55IWIIM4+u90R34
	8zmbprgPqBczvBAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.7-rc2-rt1
Message-ID: <20231123154822.7Tk-NOd9@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.7-rc2-rt1 patch set. 

Changes since v6.6-rt15

  - Update to v6.7-rc2.

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.6-rt15 is can be found here:
 
     https://git.kernel.org/rt/linux-rt-devel/d/v6.7-rc2-rt1/v6.6-rt15

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.7-rc2-rt1

The RT patch against v6.7-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.7/older/patch-6.7-rc2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.7/older/patches-6.7-rc2-rt1.tar.xz

Sebastian
