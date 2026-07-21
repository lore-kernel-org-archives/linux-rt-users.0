Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD429366548
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Jul 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640618; cv=none; b=VfkzzPj4d9lhxwkBWypSuaZNFVKFoRsoDeYZkWiuXk9fHZXiXeU41gg+HsYvkNVNytPtecY9udUN5WGgUNmSp5QCrKApQdG9n6dSh2SfWcneTFgL9WFh2WOcvJl9urZLnzWYVFdUqf/qD1/Za9IZSF8vYCpTY5Bb9FiP7oeE8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640618; c=relaxed/simple;
	bh=TGPeFPqfu3MMiAGBvpHW/Tkf+M5e2KHsuMoS3yOD83U=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=HCLd9ov/fBbxcdYfUx5tiWkqTRTmH2AJf7b6a3jSdk1aIXlil1UvkOhAViqvMW+2nPd5zgR4d/7lZEAZzE8AVmwF8VO6d9OnUK52EVQbQri1R/8meLIfHXPdf/sa1TZGBYViwd9kNjOFP383shy2//YChT5Qu4ZU5Nj2S2j+rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=CuLm725O; arc=none smtp.client-ip=185.70.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="CuLm725O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org;
	s=protonmail; t=1784640606; x=1784899806;
	bh=LqQ+DTrPXRdNMYhdS4CEpsCkCP2EoYkyFsyxrbbhJl4=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CuLm725Oc9oE4RqPD4yxCE6J/S72vrwEuRKB1n2ZC/865BJdZrquVwuFqXXUSGIFO
	 7gyWZhsuHWD4baexirby3MpkxCD7sCTskUKEi4ptnSCsSB44NbctsBvbTHBgxpRXQ0
	 yBQvx69JvebsyzixdV53SWE15RWH/fg3L4DuL5oGD2S6JVo07KJVwbB7ceIN2njyV/
	 LMkII6W+hHrxKyu4MvVC/So9zgNBbmUQVeJxsM3ktDC09aj0GGXkc5UM6DyprYwYEj
	 VmevmyCbm90PW5uBo1eJQZzLP1X/ey5LcOXPk5lulslj246meU26fXhEMDHfoUX3RG
	 Zj2K68Xa/G02w==
Date: Tue, 21 Jul 2026 13:30:01 +0000
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <williams@redhat.com>
From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] v6.12.96-rt19
Message-ID: <e5d0edb9-03d9-4356-911a-a5779c1986bc@monom.org>
Feedback-ID: 209527651:user:proton
X-Pm-Message-ID: 41964f5e84cbf393907700e52c330ba6db9e0827
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello RT-list!

I'm pleased to announce the 6.12.96-rt19 stable release.

This updates to the latest stable release. Since the latest stable=20
backports a
number of ARM patches that touch the RT code, this is not a straightforward
update. I tried various update strategies, and doing the rebase and=20
replacing
one patch resulted in the cleanest diff, making it the least likely to=20
introduce
regressions in this area.

The main change in the stable-rt tree is the removal of

 =20
patches/ARM__enable_irq_in_translation_section_permission_fault_handlers.pa=
tch

which is replaced by

   59e4f3b45b96a ("ARM: ensure interrupts are enabled in __do_user_fault()"=
)

The remaining changes are small context updates to the existing patches.

Last time I reported latency spikes in my test lab. Lukas Beckmann (thanks!=
)
tracked down the root cause:

 =20
https://lore.kernel.org/regressions/4e31e3b5-fa69-4c4c-a5e9-dea7a8452ee7@ma=
ilbox.org/

All of the deadline scheduler fixes have since been merged into the=20
stable tree,
so this RT release picks them up as well.

You can get this release via the git tree at:

   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

   branch: v6.12-rt-patches
   Head SHA1: f615822de142655b0cb1b94c4e6a0043b1ffac3d

Or to build 6.12.96-rt19 directly, the following patches should be applied:

   https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

   https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.96.xz

 =20
https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.9=
6-rt19.patch.xz

Signing key fingerprint:

   5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

    git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

