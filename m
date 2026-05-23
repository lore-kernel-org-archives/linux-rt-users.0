Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8E26F476;
	Sat, 23 May 2026 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779559398; cv=none; b=kKt+2YebtqoP7QMlplENPxX1eD4cSCx1mFsP7tQiU0phvTK9w9wu0LJhwKv/DIIrisQwBH7brXG7QaZPjn9pKPEqFrmQ/+bvcf3Cr8P04cLXkz7krZGuP3i5C9r3s9xU87RwUpnOJVPoEPkk/9L08mlbc0ejiHMu4YLTHk3I8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779559398; c=relaxed/simple;
	bh=qKfaE1KTgCxvrKfctICgNKI2hG36DjjauoqAA9E4/IM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CkO4youglRyh9/71xPCmgBjGB+SuXJbluKPUzeeuhUcW+euj4UQTOwVF4ZcGtI3aDGeeZhFN/XGs8dzOHC16C5ieTYG9T1ysbsGsLqT793lkl3BCX7bUjqEcTahIwWkRPZ+AN25VqJECI6PO3eR5YVOaKuqoOvbwjN61jRh6rNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=Sq+4MEOX; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="Sq+4MEOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1779559389; x=1780164189; i=by@by-online.de;
	bh=5BSDzXWL3qivmScNopmOrKG/X9C7h8i91ZylUieJjig=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=Sq+4MEOX1zD55fTNFqYkLeZwTFclA++Fkq1qhnF8vJ0b+fVhejWojexTz0Ny97rl
	 r2w5tN5ZOB585gW4X0jQGtK3QPNkvpBT6vqINxvHb1ALsX9XElo2AG458HUZ68mNn
	 d+/2IfeuHr/Q5X0z3vhaJU8aZUGsXhzooMqRmQqVBJOl5czUyvV/Waddcsaa7q0pE
	 lUwyTD6bccUoUeDPNrnNcbgCQr7jd1YL8vt7ZWohx0xWzXWJFMIucVxNFaTJcQqqw
	 cX0gFHiukAwMt2HMLmK7P+odnjKxnP8Uyes+yGSGk7EyngaPt8O4nNDcOKTWxEJwR
	 8/BI92QiSiLco5xsfQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MZTa2-1woPdq1VjS-00O9hU; Sat, 23
 May 2026 19:57:32 +0200
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
In-Reply-To: <A3184A2D-5222-4B7F-9CC0-6788087CA76F@by-online.de>
Date: Sat, 23 May 2026 19:57:21 +0200
Cc: Rodolfo Giometti <giometti@enneenne.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org,
 bigeasy@linutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <22B41198-799A-4BE7-9F72-EFDB03B02DC8@by-online.de>
References: <719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de>
 <5FDC46CF-4F8F-4E85-9E59-B796C5BF1194@by-online.de>
 <agyNd1SsQlmaL3mh@mozart.vkv.me>
 <A3184A2D-5222-4B7F-9CC0-6788087CA76F@by-online.de>
To: Calvin Owens <calvin@wbinvd.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:64b34EoH5uq13gMtQb8NGq247opcL1m3ZP8W1gbUMvrBN3mk9LZ
 Kt3S5O/EWvEFnsT3OmGN1aDwA3NJgFwU9JZ8ClprcaCy1x/m/aIbcTa55/bBnH095m2/8d/
 5GPD+bnV9UnLMROuf04u+x6wyPakJip59iOhzwrx3wxmMBByxXajb567uByAtRJxnrJosn6
 PVqt/k/616aNv8kTDJaDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NujoNEpmqKE=;fAXHgKmmopJRQC6k4ZUsh3ZSXXl
 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
 Bylu8EhbchiqA2NnMnT4JrVzVipbE=

Hi Calvin,

Thank you again for offering to relay the series. v6 is ready,
addressing all of Sebastian's review feedback on v5.

Branch:    https://github.com/by/linux-PPS/tree/pps-rt-v6
Tip SHA:   013781f19756a4c6ac9c91e83b3a74a52882b707
Base:      0d9363a764d9d601a05591f9695cea8b429e9be3
           ("Input: xpad - add support for BETOP BTP-KP50B/C
           controller's wireless mode")

To regenerate:

    git fetch https://github.com/by/linux-PPS.git pps-rt-v6
    git format-patch -3 \
        --cover-letter \
        --thread \
        --subject-prefix=3D"PATCH v6" \
        --base=3D0d9363a764d9d601a05591f9695cea8b429e9be3 \
        FETCH_HEAD

If easier, I have the four .patch files generated locally and can
attach them on request.

checkpatch.pl is clean on all three patches (0 errors, 0 warnings).

Suggested recipients (per scripts/get_maintainer.pl):

  To:  Rodolfo Giometti <giometti@enneenne.com>
       Greg Kroah-Hartman <gregkh@linuxfoundation.org>

  Cc:  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
       Clark Williams <clrkwllms@kernel.org>
       Steven Rostedt <rostedt@goodmis.org>
       Thomas Gleixner <tglx@linutronix.de>
       linux-kernel@vger.kernel.org
       linux-rt-devel@lists.linux.dev

Please add yourself with Signed-off-by as the relayer; the patches
preserve my authorship via the From: line inside each patch.

Cover letter content for the 0000 file:

----------------------------------------------------------------
Subject: [PATCH v6 0/3] pps: improve PREEMPT_RT performance

This is v6 of the PPS PREEMPT_RT patchset, addressing the review
feedback from Sebastian Andrzej Siewior on v5.

Changes since v5:
 - Reordered: the pps_kc_hardpps_lock conversion now precedes the
   pps_device.lock conversion. The previous order would have briefly
   produced a raw_spinlock holding a sleeping spinlock on PREEMPT_RT
   (Sebastian).
 - Patch 1/3: commit message reworded to describe the handler split
   structurally first, then its PREEMPT_RT benefit (Sebastian).
 - Patch 2/3: refactored pps_kc_bind() and pps_kc_remove() to use
   guard(raw_spinlock_irq) for scope-based lock release. Eliminates
   four duplicated unlock call sites in pps_kc_bind() and the
   ambiguous bracket structure that resulted from them (Sebastian).
 - Rodolfo's Acked-by on patch 2/3 is preserved from v5; the guard()
   refactor is purely stylistic and was suggested by Sebastian, but
   please re-ack or NAK if disagreement.

Changes since v4:
 - Patch 2/3: added Acked-by: Rodolfo Giometti <giometti@enneenne.com>

Changes since v3:
 - Patch 2/3: fixed lost indentation on pps_kc_event() call
   (reported by Rodolfo Giometti <giometti@enneenne.com>)

Changes since v2:
 - Patch 2/3: moved wake_up_interruptible_all() and kill_fasync() out
   of raw_spinlock section to avoid sleeping-in-atomic on PREEMPT_RT
   (reported by Nikolaus Buchwitz <nb@xxxxxxxxxxxx>)

This patchset addresses three sources of PPS jitter under PREEMPT_RT,
while being fully backward-compatible with non-RT kernels:

1. pps-gpio: The IRQ handler is force-threaded on PREEMPT_RT, so the
   PPS timestamp is captured after scheduling delay rather than at
   interrupt entry. Fix: split into a hardirq primary handler
   (captures timestamp only) and a threaded handler (processes the
   event).

2. pps_kc_hardpps_lock: spinlock_t becomes a sleeping mutex on
   PREEMPT_RT. Since pps_kc_event() calls hardpps() under this lock
   and hardpps() takes the raw_spinlock_t tk_core.lock, the nesting
   is invalid. Fix: convert to DEFINE_RAW_SPINLOCK.

3. pps_device.lock: same issue as (2), in the PPS event delivery
   path. Fix: convert to raw_spinlock_t and move sleeping calls out
   of the critical section.

All three patches are tested on a Raspberry Pi 5 running 7.0.1 and
7.1-rc PREEMPT_RT kernels. On non-RT kernels there is zero behavioral
change.
----------------------------------------------------------------

Thank you again. Let me know if you hit anything unexpected.

Best regards,
	Michael



> On 22. May 2026, at 17:56, Michael Byczkowski <by@by-online.de> wrote:
>=20
> Dear Calvin,
>=20
> Thanks for picking this up, and yes, I=E2=80=99m actually a bit =
overwhelmed, so your help is much appreciated! And my apologies for the =
delay, I was traveling.
>=20
> The clean v5 series is at:
> https://github.com/by/linux-PPS/tree/pps-rt-v5-clean
>=20
> Three commits on top of torvalds 0d9363a764d9 (around v7.0-rc6):
> pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded =
handler pps: convert pps_device.lock to raw_spinlock_t pps: kc: convert =
pps_kc_hardpps_lock to raw_spinlock_t
>=20
> Your suspicion about Apple Mail was correct: I diffed the GitHub =
branch against the lore mbox and the sent version has quoted-printable =
damage which would explain why nobody could git am it cleanly. The =
GitHub branch is the ground truth.
>=20
> Let me know how you'd like to proceed.
> Lore thread for context: =
https://lore.kernel.org/lkml/719A31CE-CA58-45C3-A013-1BFE81F724C5@by-onlin=
e.de/
>=20
> Thanks and best regards,
> Michael
>=20
>=20
>> On 19. May 2026, at 18:19, Calvin Owens <calvin@wbinvd.org> wrote:
>>=20
>> On Saturday 05/16 at 13:32 +0200, Michael Byczkowski wrote:
>>>> On 25. Apr 2026, at 19:18, Michael Byczkowski <by@by-online.de> =
wrote:
>>>>=20
>>>> I found three issues in the PPS subsystem that cause unnecessary =
jitter
>>>> under PREEMPT_RT, while being fully backward-compatible with non-RT
>>>> kernels:
>>>>=20
>>>> 1. pps-gpio: The IRQ handler is force-threaded on PREEMPT_RT, so =
the
>>>> PPS timestamp is captured after scheduling delay rather than at
>>>> interrupt entry. Fix: split into a hardirq primary handler =
(captures
>>>> timestamp only) and a threaded handler (processes the event).
>>>>=20
>>>> 2. pps_device.lock: spinlock_t becomes a sleeping mutex on =
PREEMPT_RT,
>>>> allowing pps_event() to be preempted mid-update. Fix: convert to
>>>> raw_spinlock_t and move sleeping calls out of the critical section.
>>>>=20
>>>> 3. pps_kc_hardpps_lock: Same issue as (2), in the kernel consumer =
path
>>>> that calls hardpps(). Fix: convert to DEFINE_RAW_SPINLOCK.
>>>>=20
>>>> All three patches are tested on a Raspberry Pi 5 running a =
7.0.0-rc6
>>>> PREEMPT_RT kernel. On non-RT kernels there is zero behavioral =
change.
>>>>=20
>>>> Signed-off-by: Michael Byczkowski <by@by-online.de>
>>>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>>> Tested-by: Michael Byczkowski <by@by-online.de>
>>>>=20
>>>> by (3):
>>>> pps: pps-gpio: split IRQ handler into hardirq and threaded parts
>>>> pps: convert pps_device lock to raw_spinlock for PREEMPT_RT
>>>> pps: convert pps_kc_hardpps_lock to raw_spinlock for PREEMPT_RT
>>>>=20
>>>> drivers/pps/clients/pps-gpio.c | 37 =
+++++++++++++++++++++++-----------
>>>> drivers/pps/kapi.c             | 18 ++++++++++-------
>>>> drivers/pps/kc.c               | 22 ++++++++++----------
>>>> drivers/pps/pps.c              | 16 +++++++--------
>>>> include/linux/pps_kernel.h     |  2 +-
>>>> 5 files changed, 56 insertions(+), 39 deletions(-)
>>>>=20
>>>> --=20
>>>> 2.47.3
>>>=20
>>> Gentle ping on this series. v4 patches 1/3 and 3/3 carried Rodolfo's
>>> Acked-by; v5 addressed the remaining feedback on 2/3. Happy to =
rework
>>> anything or split the series if that helps it move forward.
>>=20
>> Unfortunately apple mail is corrupting your patches :/
>>=20
>> Greg KH usually applies patches for drivers/pps/, but I didn't add =
him
>> here yet because the patches don't apply.
>>=20
>> If you can point me at a git branch for v5, I'd be happy to re-send =
the
>> patches myself with your authorship. This is all useful for me and =
I'd
>> like to help :)
>>=20
>> If you do it yourself, just make sure to add Greg to the Cc: list.
>>=20
>> Cheers,
>> Calvin
>>=20
>>> Adding linux-rt-users@ and Sebastian on Cc in case there's interest =
from the
>>> PREEMPT_RT side.
>=20

