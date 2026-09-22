Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C62493D36;
	Tue, 22 Sep 2026 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060824; cv=none; b=Phx/MGb4DrloPRUANzJbwC4CDh/ZGelV05lIxl6gzGQ/UlRCSLzsccqZgszHGOUZt77Bha4kWW5sg+vFAwxTigkopHi3Cnw6hvdUUrg86HB48Mm7eTp9IanbJqq1aqQEFuSNP92buQKsZPEJLSDFM8SeX4ETu6ihVPAyIu8+b5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060824; c=relaxed/simple;
	bh=jQ4HWTBGYx2A3QBaj2+Wv/e3wW1lad7jGmjD3JwoWo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7lgBpBK5tJ+HjBKVibQBDW8tdB3E1uFaWiBfB8xeklgKHSwRgaxQ7TFXGCSEu0nCZrroEmWwF95exw1BhAFHntcM17JCS1EQKFTkuHW4IkTclNRS40zV17E/BJCAr8N1xamDj9moemTdMcx/fTvciTVc8ushG/BWuWWvfPkoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UDKFTSFd; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UDKFTSFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jQ
	4HWTBGYx2A3QBaj2+Wv/e3wW1lad7jGmjD3JwoWo0=; b=UDKFTSFdd3cyOATzVD
	TXHjqDxQ0pi6zTTXhqONxVCpri0zhNdf21bo0z7Jl+N0m7ZrBHGC/tga1qQD3f3j
	9FzJD7SGSFnXCtPynMehpjPy4xx8092edtvczEEHg7aTdsDGg2zzxWZ+qdGm4N0r
	2nAiuDPO1CpTjLmgBO/jgEdmE=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBXmHLzKLJqlwUIAw--.12528S2;
	Tue, 22 Sep 2026 15:06:27 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	quchaosheng000406@163.com
Subject: Re: [PATCH v2] sched/proxy: allow SCHED_PROXY_EXEC with PREEMPT_RT
Date: Tue, 22 Sep 2026 15:06:18 +0800
Message-ID: <20260922070618.70119-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921125740.vKjQ0Qtr@linutronix.de>
References: <20260921125740.vKjQ0Qtr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBXmHLzKLJqlwUIAw--.12528S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4fJFW7Cry5JF1UCF1ftFb_yoWfXrXE93
	ykJ3s7Aw4UCFnIy3WxJF4rX393tF1jkry7Z3s0qrZxW3s5ZFs5Ga1kGwnFkFWfKaySqwnx
	JrW3G34IvrySvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VU1UPE5UUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BONA2qyKPPp0QAA3C

Sebastian, Peter,

Both of you asked the same thing, so one answer for the thread: you are
right, there is no build failure today. The option cannot be turned on
next to PREEMPT_RT, and that dependency is exactly why nobody has hit the
errors I quoted. My patch is what would introduce the combination, not
what fixes it. Answering "the Kconfig says it is broken" was circular.

Peter put the objection better than I did: the feature is effectively
broken under PREEMPT_RT, and carrying a build option in that state buys
nothing. I withdraw the patch.

The boot and stress testing I described was real, but it was testing a
combination that should not exist, which makes it worthless as an
argument. If proxy execution becomes meaningful on PREEMPT_RT it will be
after the RT mutex maintains blocked_on, and that change will have to
justify itself from that work.

Quchaosheng

