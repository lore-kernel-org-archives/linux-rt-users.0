Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0343446B9;
	Sat, 23 May 2026 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779559148; cv=none; b=POVkvthUbicZDK7uT3sWbUpsRE1gy7+IyeGUAxSRC6Ak/RsxBJcV879RX5A1y2iaTd8kI219iBYrPFU+7TZY0FV2B+h640QC7D5bXYJ8xsIPjVW1RTMBSZtfvrgbVyWrbSZzJI2NEE9T1hdIlQufRPHBZw3h5d0XS2L4jE+g3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779559148; c=relaxed/simple;
	bh=LyfJPTKh46084l/f3wihQzW/P9Es3GA8dSxuqu44+wM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rmRnABZUd9ixVDPoki9k4AztkFu/ZwNbQ64gmgOUzp/qjAPNfw3kY4+V3Qocy1IKBNrWzU/dVnFOiJw1fF73vqoX7Rjxwu1fUIufP/RWILASKObZZOMvtPCHPM9MYpZC0dcZ1TfdGT84EwGN9Zodi83Tp24ZRwviMVifWdOfmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=bz6TeiQc; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="bz6TeiQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1779559136; x=1780163936; i=by@by-online.de;
	bh=sxvNDjNSTTdOLSqaKmR3q3mYG9rfvKp2Ffd6/g0SPFM=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=bz6TeiQcLbU1ev4iz4dqzdEs2hc/pMdxKf6siDIkP4gENei50pHD7/Ytpy5M0LM0
	 7tl0vwdA6sdXp+VDA4Oi8KpNYyD+uSVCdyG/sRnkvJ2NzPA/mq0wB7EHND3oCNNDe
	 WZk8j/ER89lktwBZwiEzDXgNEThg5HyJBt0Cunq5SpzHQscpxXqJqgvY+YJZWqZgz
	 WYG084hI/Ebcjr41zeBr9EvAklcNxtc/CUvr5isN0oTq7QSW+VfCqk65oYAEfT4l6
	 0I05a2tpwLh71/KO4YvY0z+uv4/2yMI0rxQIRNqhL0gQD23jX3+W1+BsCiLfa+Goq
	 QVugVhh/Ra25db+R/Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MdNHa-1wzuKG3Isy-00ncUx; Sat, 23
 May 2026 19:58:56 +0200
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v5 0/3] pps: improve PREEMPT_RT performance
From: Michael Byczkowski <by@by-online.de>
In-Reply-To: <20260522141310.4gjpozvo@linutronix.de>
Date: Sat, 23 May 2026 19:58:46 +0200
Cc: Rodolfo Giometti <giometti@enneenne.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FA183459-2F8F-42AF-A800-A82B7741DB0C@by-online.de>
References: <719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de>
 <5FDC46CF-4F8F-4E85-9E59-B796C5BF1194@by-online.de>
 <20260522141310.4gjpozvo@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:pP6TClEOjrX/iUoy7zio4LeGKj9p+slJuT1sFF8+76e9XFKF5Wa
 VCuMuB+QA2W//CGXakxxL3oNEH3plecVidRubmZkwGEiKTr/zkIlVWno1mIJFGMpWKd0IHP
 JAFifXA4M7BhAyOMw1/V1M21UK9yXyZ2SX83ZORqb0XNjGRYEwN8joLV5tg91jjkLllmjiL
 Fvgc/Vh35Po9EbouinWtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J6pq0NVfkCI=;FHWU0VBIPRaQlL7SlqBRVkkXtjM
 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
 AzTHz0pxn4FnmReJX2/fzn3YFm5CI=

Hi Sebastian,

Thanks very much for the review.

On 22 May 2026, at 16:13, Sebastian Andrzej Siewior wrote:
> Was there a follow-up to the series?

Yes: v6 is on the way. Calvin Owens kindly offered to relay it for
me (Apple Mail has been corrupting my patches in transit; I'm
addressing that separately), so the v6 series will arrive from him
shortly.

A summary of how I've addressed your v5 comments:

1/3 (pps-gpio handler split): commit message reworded. The new
   message describes the split structurally first -- primary hardirq
   handler that captures the timestamp, threaded handler that
   processes the event -- and then describes the PREEMPT_RT benefit
   second (no more scheduling delay between IRQ entry and timestamp
   capture). The patch itself is unchanged.

2/3 (pps_kc_hardpps_lock -> raw_spinlock_t): I'd appreciate a quick
   clarification here. You wrote that pps_kc_hardpps_lock "is
   spinlock_t in my tree". My patch is against mainline at
   0d9363a764d9 ("Input: xpad - add support for BETOP BTP-KP50B/C
   controller's wireless mode"), where it is still DEFINE_SPINLOCK.
   Could you point me at the branch you were looking at, so I can
   check whether v6 needs to rebase on top of an existing conversion
   in your tree?

   Separately: I've also taken your suggestion and refactored
   pps_kc_bind() (and pps_kc_remove() while I was in the file) to use
   guard(raw_spinlock_irq). That eliminates the four duplicated unlock
   call sites in pps_kc_bind() and removes the ambiguous bracket
   nesting. Thank you for that pointer.

3/3 (pps_device.lock -> raw_spinlock_t): reordered so this comes
   after the kc_hardpps conversion (which now becomes patch 2/3 in
   v6), as you noted -- the previous ordering would briefly produce
   a raw_spinlock holding a sleeping spinlock on PREEMPT_RT. Thank
   you for catching that.

Also: thank you for auditing pps_gpio_echo() on my behalf, much
appreciated.

Best regards,
	Michael

