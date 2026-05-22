Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817AE333727;
	Fri, 22 May 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465415; cv=none; b=W0t7JH/W/2W1aOygvo19WYgGmnQIwptg2CT3gnj0917T776WEiugO3C+5o/KnWMeCmyH9acAKszU6h/d9FzZqbwwJcEy+I3W+ttP79TAEBxuUX24zUhjj10W29mT7p1nt0CInBZ6PBa9aVa/jvMWPWbkL1STFObFuOpNXIhvm78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465415; c=relaxed/simple;
	bh=s+Ja4aK6H61CD8dZAyuEvSXkEu9X/Iclo35YVyLmqFk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cl9MR4Cf59Djf3CbY6BOWW+9enol4jhkGu+cKFQQ5EvsI/KadyGGIr6wm1ZwlIuI2lyK+OIC8TLBDfj/dqewKnNe/CQC+n+Q36uFfjqLXeLnljVUtvpC15OSeaVmmpdN8/Tv/2LMnlAnBuySRCsEGelnP9EhHa0Jpi1lXRDgmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=XyTmc4yU; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="XyTmc4yU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1779465404; x=1780070204; i=by@by-online.de;
	bh=5L/bv1OhZaIerLkDqg6r16M6kPTwFthPmhTU4v8xdt8=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=XyTmc4yUiV99TH8vjg4p3pnFaz8oJpf8uOR6oiQfvBDWeZ2SL0JwTvFITJVnFyuY
	 02SR2ytigP9eD37pcDyWsybfwM7R9D6u5rS+mBWRVomewmZySiQ3Eu0TciQ3YAk90
	 hCTOjdhSMMFjIv/USwQbFn40sXkstbrZPezBMf/tK71kLOgsJ49laf5UWIzgQm1L1
	 vDr/3JgRvDiVBWFFHMgCRM8kxOyzjejf44aXSjWtGE/QakjB5GKG5gSRSEEdpWMbO
	 FxsKHT70fMKyzNEWZQSb0GBZmuiaB+O4iVaNwNe+mWE7vZLnT5NkQuMs6wcwlyBtS
	 PTxiruopuaBJBqzXYA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MpUMc-1x7QLg0mKa-00m48u; Fri, 22
 May 2026 17:56:44 +0200
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v5 0/3] pps: improve PREEMPT_RT performance
From: Michael Byczkowski <by@by-online.de>
In-Reply-To: <agyNd1SsQlmaL3mh@mozart.vkv.me>
Date: Fri, 22 May 2026 17:56:33 +0200
Cc: Rodolfo Giometti <giometti@enneenne.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org,
 bigeasy@linutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3184A2D-5222-4B7F-9CC0-6788087CA76F@by-online.de>
References: <719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de>
 <5FDC46CF-4F8F-4E85-9E59-B796C5BF1194@by-online.de>
 <agyNd1SsQlmaL3mh@mozart.vkv.me>
To: Calvin Owens <calvin@wbinvd.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:DAlDLZ07S4m8Yu5VPaDyAeWxVH3KPToZBSAu+lTXiMfVfIaqafv
 20vB/qW5tgIJH82HbmVDGODFFV+8CGCmNMLcixJmZ+hfbYVeXptR7q5EwD/LZ+x3ilzDwBU
 DfcwhquvCQQMUnqH6H+cicgK2vyHj+mvJgNddqPtD0WtSMY5QYVRDfhxebcQM7iJeyo3vN8
 uknKbQuwLa1l3hYnnSCAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fWRGPTq3fxI=;9xIs+7exgfTcsy+4JSq2Sh05R+H
 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
 Zui621HKI9Sm0h5AZUy3fi3iH5u/I=

Dear Calvin,

Thanks for picking this up, and yes, I=E2=80=99m actually a bit =
overwhelmed, so your help is much appreciated! And my apologies for the =
delay, I was traveling.

The clean v5 series is at:
https://github.com/by/linux-PPS/tree/pps-rt-v5-clean

Three commits on top of torvalds 0d9363a764d9 (around v7.0-rc6):
pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded =
handler pps: convert pps_device.lock to raw_spinlock_t pps: kc: convert =
pps_kc_hardpps_lock to raw_spinlock_t

Your suspicion about Apple Mail was correct: I diffed the GitHub branch =
against the lore mbox and the sent version has quoted-printable damage =
which would explain why nobody could git am it cleanly. The GitHub =
branch is the ground truth.

Let me know how you'd like to proceed.
Lore thread for context: =
https://lore.kernel.org/lkml/719A31CE-CA58-45C3-A013-1BFE81F724C5@by-onlin=
e.de/

Thanks and best regards,
	Michael


> On 19. May 2026, at 18:19, Calvin Owens <calvin@wbinvd.org> wrote:
>=20
> On Saturday 05/16 at 13:32 +0200, Michael Byczkowski wrote:
>>> On 25. Apr 2026, at 19:18, Michael Byczkowski <by@by-online.de> =
wrote:
>>>=20
>>> I found three issues in the PPS subsystem that cause unnecessary =
jitter
>>> under PREEMPT_RT, while being fully backward-compatible with non-RT
>>> kernels:
>>>=20
>>> 1. pps-gpio: The IRQ handler is force-threaded on PREEMPT_RT, so the
>>> PPS timestamp is captured after scheduling delay rather than at
>>> interrupt entry. Fix: split into a hardirq primary handler (captures
>>> timestamp only) and a threaded handler (processes the event).
>>>=20
>>> 2. pps_device.lock: spinlock_t becomes a sleeping mutex on =
PREEMPT_RT,
>>> allowing pps_event() to be preempted mid-update. Fix: convert to
>>> raw_spinlock_t and move sleeping calls out of the critical section.
>>>=20
>>> 3. pps_kc_hardpps_lock: Same issue as (2), in the kernel consumer =
path
>>> that calls hardpps(). Fix: convert to DEFINE_RAW_SPINLOCK.
>>>=20
>>> All three patches are tested on a Raspberry Pi 5 running a 7.0.0-rc6
>>> PREEMPT_RT kernel. On non-RT kernels there is zero behavioral =
change.
>>>=20
>>> Signed-off-by: Michael Byczkowski <by@by-online.de>
>>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>> Tested-by: Michael Byczkowski <by@by-online.de>
>>>=20
>>> by (3):
>>> pps: pps-gpio: split IRQ handler into hardirq and threaded parts
>>> pps: convert pps_device lock to raw_spinlock for PREEMPT_RT
>>> pps: convert pps_kc_hardpps_lock to raw_spinlock for PREEMPT_RT
>>>=20
>>> drivers/pps/clients/pps-gpio.c | 37 =
+++++++++++++++++++++++-----------
>>> drivers/pps/kapi.c             | 18 ++++++++++-------
>>> drivers/pps/kc.c               | 22 ++++++++++----------
>>> drivers/pps/pps.c              | 16 +++++++--------
>>> include/linux/pps_kernel.h     |  2 +-
>>> 5 files changed, 56 insertions(+), 39 deletions(-)
>>>=20
>>> --=20
>>> 2.47.3
>>=20
>> Gentle ping on this series. v4 patches 1/3 and 3/3 carried Rodolfo's
>> Acked-by; v5 addressed the remaining feedback on 2/3. Happy to rework
>> anything or split the series if that helps it move forward.
>=20
> Unfortunately apple mail is corrupting your patches :/
>=20
> Greg KH usually applies patches for drivers/pps/, but I didn't add him
> here yet because the patches don't apply.
>=20
> If you can point me at a git branch for v5, I'd be happy to re-send =
the
> patches myself with your authorship. This is all useful for me and I'd
> like to help :)
>=20
> If you do it yourself, just make sure to add Greg to the Cc: list.
>=20
> Cheers,
> Calvin
>=20
>> Adding linux-rt-users@ and Sebastian on Cc in case there's interest =
from the
>> PREEMPT_RT side.

