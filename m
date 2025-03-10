Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623F1805A
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Mar 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606295; cv=none; b=eMDQcKQHwrbJ8FmyNZm95SdTAM1ktxEkMNUcmTbDIhhG1amZ2GhMPxzXh5NQW2rXBOAF793wAVmn9Os5h99t9q00Guj8p2DBzAXS2Nz7we1xciVfcougqXpd13JWcPPS5gCY+EngTUuR/B7fYVH8eN60wZ0Ai7F2JPl6eN5eaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606295; c=relaxed/simple;
	bh=PmUJco581eI84QWVAENDTeGlBhPo2oHBhob0vs32eJo=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=is0ipQ4sfmTMo/JfE0kaGE39JBDRIkP2rXlzf45YETyeUsLbNlV5xmFsVWyxzeBdfXx/vSgqZIpRMNvWZLlmXRI4zsJseBZMxUdMpF9Ffy50dU35I1OpjHcMSL2Z+iDASiEUAIywafwTxK8RfXWWRTyzroxWBYF7SG3AlDjLTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KQIK4H7S; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KQIK4H7S"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250310113122a8ef1b46a1511a159b
        for <linux-rt-users@vger.kernel.org>;
        Mon, 10 Mar 2025 12:31:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Sl4cTxmC0cH4u29M3rasbJ1MhRSnXaRK9pTj+m4LCUs=;
 b=KQIK4H7SIV/qElolQ1yatSIoMo7hXgRdS9AGbSSNknu+lRWtYHdjSP9We0TtZ9p1UTJjyg
 XkbzuHF+UhKb0GaP3wma85LH8ovgj9K0jsLoU7HCa30J8B3ustj2WlW/pLn4aK2bRx3Fodu8
 AkAidIOTe5ZGQE+aoFh81ZBsSCtBKWVlOzE+nKeQ5DMphpCPGdzDxC+O7a3x9sk4EdGWEs/0
 sRqbgCopWI0/Qw0jvpxyESz+FKilIAIxT4NgAya353ZlB0Uj/t6eRZkESLE1hdoKYgPfHwar
 4CtQjDJA5ai6qeuI78Sk23INA+FaB1eqmlwsi0LH63mFuvMBk+i9ibQw==;
Message-ID: <a3444741784adda2b9ff462ca5d92d343ef700ba.camel@siemens.com>
Subject: 6.12: i915 not allowed in combination with RT
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: linux-rt-users@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Quirin Gylstorff
	 <quirin.gylstorff@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 10 Mar 2025 12:31:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

the following commit (taken from 6.6-rt branch) resides in all stable-
rt branches but is not part of mainline 6.12 and above, which makes it
impossible to use i915 in combination with PREEMPT_RT enabled.

Is that by intention? Are there any known issues that makes it
necessary to disable i915 in combination with RT in current releases?

Best regards,
Florian

commit f532acfe5c63d53756c86e3d3fb1a51b02d29762
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon Feb 21 17:59:14 2022 +0100

    Revert "drm/i915: Depend on !PREEMPT_RT."
   =20
    Once the known issues are addressed, it should be safe to enable the
    driver.
   =20
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 3efce05d7b57..392d51703096 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -3,7 +3,6 @@ config DRM_I915
	tristate "Intel 8xx/9xx/G3x/G4x/HD Graphics"
	depends on DRM
	depends on X86 && PCI
-	depends on !PREEMPT_RT
	select INTEL_GTT if X86
	select INTERVAL_TREE
	# we need shmfs for the swappable backing store, and in particular
