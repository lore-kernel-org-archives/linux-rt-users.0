Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFED28150E;
	Thu, 10 Apr 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293954; cv=none; b=TuA+5+Rc3NS1vsjTObjrXYcxJnF90g30/joIvp2UZJmhTbZJnDKCQNHZ6R7p97LBs00EKS44QqG0cNM6tG08G/FHP/nw2oHi+KgROQvJnzHKFwN55RYzn7o2QlSBnc+F45AbusyJmr1en1DmqkPa6WmILvn8hD8LUde2Qeu+GE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293954; c=relaxed/simple;
	bh=Q8tv9O31GtdPGuIMavSF1RE+zNha/hwlVqw7M5m+VaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DnCGhCzTYyo187gE4RhJW3+IqQQLH8j6Cl/BMC8bdkcJueCsWHjMzg+r9/5xJS2ZsDNqMVr/UPhkaYWVGvaD4kt9ie8YW6M1IRuxPXcmDZh05l5b37RpNlLM8RUYqZ6tkHp86KEmqUQfDql3PmehaJ20XIJ61FvZkbvAd97g2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u8um0DjW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UK8z7RCp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u8um0DjW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UK8z7RCp"
Date: Thu, 10 Apr 2025 16:05:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744293950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0slAvCbWMW+1ajZRHxOjYlSGE58r6Y1Vndtl8pEheAk=;
	b=u8um0DjWKYgducM7ySKGjkg4O3Hwxg8dufsCsuBeO+FVaeavH2ToirZs5YIdxZRdCbBQBP
	tBnhuUp0xn/Q06bZy0T/cdxiLvOXLsuBshoX+WVfuLXfzg5Ll0Wcm4bWykL7MHot6tr1/D
	UVy/Hmo14Sez6yZ99VanwBncIqyx0DO6Uw8v5fKkgD2C3L/IA2pYHYk0V+kgdlBcbPNn9N
	d5XrDK+HQ42TWn0UDZGo3/4+OLi+yBd2IRo4Um63p/Cjer8bVOUBh/1CHOsbqzhiDKaeBR
	1mv5hzWGIykyasrJkiuH7jkXkkluKbNEHU4AvT5uZDJAyR5keVQRQDkZKcXtDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744293950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0slAvCbWMW+1ajZRHxOjYlSGE58r6Y1Vndtl8pEheAk=;
	b=UK8z7RCpWjQ9hEvvhTypbOzwV0hw1aGVTHJQhgC1te77v3bAFCc+TzLO72QS2RGDGzsjQY
	jL7bu6YFsUWBcqAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.15-rc1-rt1
Message-ID: <20250410140548.pUC4CQva@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.15-rc1-rt1 patch set. 

Changes since v6.14-rt3:

  - Rebase to v6.15-rc1

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.15-rc1-rt1

The RT patch against v6.15-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.15/older/patch-6.15-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.15/older/patches-6.15-rc1-rt1.tar.xz

Sebastian
