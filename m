Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9E2745E;
	Sat, 16 May 2026 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931138; cv=none; b=lO+CP0U99NJjw3UhfPxlo0XRDjpuQzln0CBxSxngjeciFbj2gbO+84IAHq15lfV+Je3b8GjkIBec3KW/nhAW3dGlZnSX0zzd54cqfN3iO7eIUyIcbNFfLJorW6o+iqqNmQGnTamfFqZQPU3Fuus7SzT345v8zFttgIW/JmZlboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931138; c=relaxed/simple;
	bh=vJwqNk+h4ujmX2CechXYBVqBqLwrgZifYfEVn35Gc9I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eV/Szd6LkoHzJ8KWVX1+jAsy7nszc5u7BtjKEFOgfZEsS9XxQN1UqtohK+CN8WbMhDRKS2VToxbppXCl49I4vHHebChPK2e+ToW1Sa4I/xFykuLlX5HZIlHQkPZoVS3Gk994k5WJ4xmNowk4TCWTdTq5L29hiM4micA1AvPkoEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=vC52cDSa; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="vC52cDSa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1778931133; x=1779535933; i=by@by-online.de;
	bh=OJh6/cI+lZTzNFVasuLqt7PQg67U1iG7ijyp/hCgfpc=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=vC52cDSaoepVrbh6kLqIXVWLcj9oIEg9Kn+HosiT/o7/Q6jp+fhDwAky5WrKBIw+
	 BuzQGNj2szaVwJRpGbYUYuZ/Nm3yyarAC+AvmmLpzJxYaEoKHaFHghpljfmAO2LvO
	 qOl+z793V1/mOSmNtPlK5ypdh5WgK55ffj0YUr1mi9uY/lRxra9jydL2mxvokqDNk
	 BUfcluTLZO/liG4eesOAPSPRIp6GrLplNcSF0tB9VtJMrz/1vACOV3R2bG6JsGsTc
	 rSEMnIoVOFhxLeWzKCRu210O1/Um/CHD6Qn/pTFB/EFpWki5R0rKPcmIGrayKZ+4C
	 AHVLdftU0U5gdOSryw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MRC7g-1wlDmD2n6i-00KZig; Sat, 16
 May 2026 13:32:13 +0200
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
In-Reply-To: <719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de>
Date: Sat, 16 May 2026 13:32:03 +0200
Cc: linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org,
 bigeasy@linutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FDC46CF-4F8F-4E85-9E59-B796C5BF1194@by-online.de>
References: <719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de>
To: Rodolfo Giometti <giometti@enneenne.com>,
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:f7HcIMeEU50ZBdOvCTxTmY8et4UwxS5LGRn7e1Ewgdi4QXKcdWC
 USjoQRZmy42gKf+YNxbwyb+BVnZI5Y8xsLVIu0FqHgGTO3PM/bVuvy/OHsKpQP0a8x2OtZu
 tA2ld5nt+tw5hklJ8mYHNy1sl/NO3CUykdL/AkY443ocSCP84cV3B0LK7EIGa4S2WniOlVY
 ITatA+GzqJHitUBNEH7hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9X0S3QczYbo=;7sAJzvZgzquTFH8LDwoHlL/YUGh
 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
 EaJtZSQ0yJ21SDDOomRRkvqpBI4uI=

Gentle ping on this series. v4 patches 1/3 and 3/3 carried Rodolfo's =
Acked-by; v5 addressed the remaining feedback on 2/3. Happy to rework =
anything or split the series if that helps it move forward.

Adding linux-rt-users@ and Sebastian on Cc in case there's interest from =
the PREEMPT_RT side.


> On 25. Apr 2026, at 19:18, Michael Byczkowski <by@by-online.de> wrote:
>=20
> Dear Rodolfo, Dear Andrew,
>=20
> This is v5 of the PPS PREEMPT_RT patchset, including your
> Acked-by for the  the fixe of the sleeping-in-atomic issue in
> patch 2/3 as well as the lost indentation
> now squashed in.
>=20
> Changes since v4b: - corrected typo, corrected email structure
>=20
> Changes since v4: - Patch 2/3: added Acked-by: Rodolfo Giometti
> <giometti@enneenne.com>
>=20
> Changes since v3: - Patch 2/3: fixed lost indentation on =
pps_kc_event()
> call (reported by Rodolfo Giometti <giometti@enneenne.com>)
>=20
> Changes since v2: - Patch 2/3: moved wake_up_interruptible_all() and=20=

> kill_fasync() out of raw_spinlock section to avoid sleeping-in-atomic =
on
> PREEMPT_RT (reported by Nikolaus Buchwitz)
>=20
> Changes since v2:
> - Patch 2/3: moved wake_up_interruptible_all() and kill_fasync() out
> of raw_spinlock section to avoid sleeping-in-atomic on PREEMPT_RT
> (reported by Nikolaus Buchwitz <nb@buchwitz.com>)
>=20
> Andrew Morton pointed me your way as PPS maintainer. I'm running a
> precision NTP time server on a Raspberry Pi 5 with a PREEMPT_RT kernel
> and a u-blox ZED-F9P GPS receiver providing PPS via GPIO.
>=20
> I found three issues in the PPS subsystem that cause unnecessary =
jitter
> under PREEMPT_RT, while being fully backward-compatible with non-RT
> kernels:
>=20
> 1. pps-gpio: The IRQ handler is force-threaded on PREEMPT_RT, so the
> PPS timestamp is captured after scheduling delay rather than at
> interrupt entry. Fix: split into a hardirq primary handler (captures
> timestamp only) and a threaded handler (processes the event).
>=20
> 2. pps_device.lock: spinlock_t becomes a sleeping mutex on PREEMPT_RT,
> allowing pps_event() to be preempted mid-update. Fix: convert to
> raw_spinlock_t and move sleeping calls out of the critical section.
>=20
> 3. pps_kc_hardpps_lock: Same issue as (2), in the kernel consumer path
> that calls hardpps(). Fix: convert to DEFINE_RAW_SPINLOCK.
>=20
> All three patches are tested on a Raspberry Pi 5 running a 7.0.0-rc6
> PREEMPT_RT kernel. On non-RT kernels there is zero behavioral change.
>=20
> Signed-off-by: Michael Byczkowski <by@by-online.de>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> Tested-by: Michael Byczkowski <by@by-online.de>
>=20
> by (3):
> pps: pps-gpio: split IRQ handler into hardirq and threaded parts
> pps: convert pps_device lock to raw_spinlock for PREEMPT_RT
> pps: convert pps_kc_hardpps_lock to raw_spinlock for PREEMPT_RT
>=20
> drivers/pps/clients/pps-gpio.c | 37 +++++++++++++++++++++++-----------
> drivers/pps/kapi.c             | 18 ++++++++++-------
> drivers/pps/kc.c               | 22 ++++++++++----------
> drivers/pps/pps.c              | 16 +++++++--------
> include/linux/pps_kernel.h     |  2 +-
> 5 files changed, 56 insertions(+), 39 deletions(-)
>=20
> --=20
> 2.47.3

