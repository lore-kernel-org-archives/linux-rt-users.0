Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC4274670;
	Tue, 26 May 2026 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820507; cv=none; b=d+eMtSyW4kfLf13ZM5618GLt8SnrtHqoN4z/955NryyoxRCTODxDip6S3qYp+6pZjdwMW8nUXQ7q2cpTmEi0IYM3SOPYL1RDusd9uryt+THpqrZSMpRcTR+l8Khfh8uVHl3wGdslk0TXaVjSJjYcI10BGM4TEZc9HiLMgixzy7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820507; c=relaxed/simple;
	bh=iiiV+fs19yA6Nv6KifYfjqKGvUvlWe1g1i0NcsISje0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XSiLiT1qEt0uCyDShM3xrm6D8wRRf09ySNbIPdFZqnVz6AiWMoVz7xcHCYFZLKUGgHe19RtuXmYRmuHhn8MOL63j4GygSlWo+KtLmerCnm8llyL9JS1UY+fWWMb/R6GSvfD4nqO6fvxh0S9JuZn6RCUx0CF9Sbm9FCDRPksMMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=khHcy+Dl; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="khHcy+Dl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1779820503; x=1780425303; i=by@by-online.de;
	bh=NG9sQWaUfxGH48Z/RlOUH99Z+5K3/v5lvFvzN0bV3OE=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=khHcy+DlcKzEc6qG8WhR202nnklLBS68XP0z7izyY5WeKXFAUGiqDszUVX1WKCch
	 0cPXdNiOpFBuElfD29uBxy4Rnnae9IXKuVdlAKarTSnMiCzN+QQVg2LIJDkxTqawb
	 ByoiwO1Qg93oTAUS/k4bv+sSMc2S8q2LE/YCggGgBA0fh9vRdXpF6ZfdK0YMyvHMY
	 qNwNBe4Urb/6Q6x5nGVfJrqydxYLQDb/uXUWE7sqi3jzmg4ZTWlusW2ctsGs+3yrW
	 IO/mvb9wQgRxe8xForfxzbqlNnn9uhOoUAYZo/l7lYvK/+vrNA3tysMdoNn44OKIw
	 Q6GZu/ioGaqxGdENlg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MBDzc-1wcMUC4Bbi-007MA3; Tue, 26
 May 2026 20:35:03 +0200
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
In-Reply-To: <FA183459-2F8F-42AF-A800-A82B7741DB0C@by-online.de>
Date: Tue, 26 May 2026 20:34:51 +0200
Cc: Rodolfo Giometti <giometti@enneenne.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D9DA0B8-E31A-4934-B5A4-E31C2DF34C42@by-online.de>
References: <719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de>
 <5FDC46CF-4F8F-4E85-9E59-B796C5BF1194@by-online.de>
 <20260522141310.4gjpozvo@linutronix.de>
 <FA183459-2F8F-42AF-A800-A82B7741DB0C@by-online.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:5Y1PcirukJqWVBtQFekbHJEz+jiF5G22YJ6YtZEF5+lnsS38hZF
 VIPmvbDbQo39hET+UB6jIAm/ErqRcWypCOattY12KX3i9kEkm+OJNnM/yPKACDlIymAJ/WU
 9lFUHaRBdjI0+7uDMB9yjwOktzQpB3ffKgzFvGXOPo/ZuQhvxGLNBCPRToDiZdA8WdHpLve
 oFqH/i1MKCoNRgs4NEd1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nfJnZDIPfYA=;awVSUUluSoGIwfhV7wDlvk9iYjX
 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
 A+cZeihHYRaxIh36MybPMJAUuxlZc=

Hi Sebastian,

Quick update: v7 is on the way, addressing your v5 feedback plus
a separate bug Calvin Owens found in v6 during testing with
CONFIG_DEBUG_ATOMIC_SLEEP.

The new bug: pps_event() in kapi.c was holding pps->lock (now
raw_spinlock_t) across wake_up_interruptible_all() and
kill_fasync(), both of which internally take regular spinlock_t
locks that become rt_mutexes on PREEMPT_RT. This is the same
illegal-nesting pattern Nikolaus Buchwitz caught for the pps_kc
path between v2 and v3 -- I should have audited pps_event() for
the same issue back then and didn't. Patch 3/3 in v7 moves the
unlock above the wakeup calls.

Your v5 feedback is fully addressed:

  1/3: commit message reworded to describe the split structurally
       first, then the PREEMPT_RT benefit.

  2/3: pps_kc_hardpps_lock conversion, now ordered before the
       pps_device.lock conversion as you noted. While here, also
       refactored pps_kc_bind() and pps_kc_remove() to use
       guard(raw_spinlock_irq), eliminating the awkward bracket
       placement you flagged.

  3/3: pps_device.lock conversion, now with Calvin's wake-up
       reordering. Rodolfo's Acked-by is dropped on this patch
       since the change is substantive; hoping he'll re-ack.

Calvin is relaying v7 the same way he relayed v6.

Thanks again for the review,
Michael



> On 23. May 2026, at 19:58, Michael Byczkowski <by@by-online.de> wrote:
>=20
> Hi Sebastian,
>=20
> Thanks very much for the review.
>=20
> On 22 May 2026, at 16:13, Sebastian Andrzej Siewior wrote:
>> Was there a follow-up to the series?
>=20
> Yes: v6 is on the way. Calvin Owens kindly offered to relay it for
> me (Apple Mail has been corrupting my patches in transit; I'm
> addressing that separately), so the v6 series will arrive from him
> shortly.
>=20
> A summary of how I've addressed your v5 comments:
>=20
> 1/3 (pps-gpio handler split): commit message reworded. The new
>   message describes the split structurally first -- primary hardirq
>   handler that captures the timestamp, threaded handler that
>   processes the event -- and then describes the PREEMPT_RT benefit
>   second (no more scheduling delay between IRQ entry and timestamp
>   capture). The patch itself is unchanged.
>=20
> 2/3 (pps_kc_hardpps_lock -> raw_spinlock_t): I'd appreciate a quick
>   clarification here. You wrote that pps_kc_hardpps_lock "is
>   spinlock_t in my tree". My patch is against mainline at
>   0d9363a764d9 ("Input: xpad - add support for BETOP BTP-KP50B/C
>   controller's wireless mode"), where it is still DEFINE_SPINLOCK.
>   Could you point me at the branch you were looking at, so I can
>   check whether v6 needs to rebase on top of an existing conversion
>   in your tree?
>=20
>   Separately: I've also taken your suggestion and refactored
>   pps_kc_bind() (and pps_kc_remove() while I was in the file) to use
>   guard(raw_spinlock_irq). That eliminates the four duplicated unlock
>   call sites in pps_kc_bind() and removes the ambiguous bracket
>   nesting. Thank you for that pointer.
>=20
> 3/3 (pps_device.lock -> raw_spinlock_t): reordered so this comes
>   after the kc_hardpps conversion (which now becomes patch 2/3 in
>   v6), as you noted -- the previous ordering would briefly produce
>   a raw_spinlock holding a sleeping spinlock on PREEMPT_RT. Thank
>   you for catching that.
>=20
> Also: thank you for auditing pps_gpio_echo() on my behalf, much
> appreciated.
>=20
> Best regards,
> Michael
>=20

