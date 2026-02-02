Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D3263C8C
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Feb 2026 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048999; cv=none; b=CcSf34rnn4jl7tQUhmJusMyrc0T9YAo0rZe45QmlldFuQ/5wve03PxGGXa49N1uFwYkgGMYf8LfTmjaJl6kMDPXXd/ZXuT1qYcFTi069jYEt7WqIe4MTKt1rD9fkp1T7x3CfSbOaIBHRKr/2V0jxZ6W/8kMftT5IV3sAP7btnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048999; c=relaxed/simple;
	bh=cAl3f0aIC9v2qun9IsXlxzNV4TaRm5M7ocZisXoxNuA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=CZJdlVPzRkvuuX5rebBS8UGMTaC3x5yFw2TRpDqAtDHz9unlPcfGZZRLdpqP8foPEPI8nWaKjY7iKnMqkBxgPCnP2CwWs1BedwTkGGQfcZebRuIBlEXkHAT1Bi5ak2dB/CDKtfILZyjum23tq4t0dQmq9JLkDG5hpILCgB3+5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ongy.net; spf=pass smtp.mailfrom=ongy.net; dkim=pass (2048-bit key) header.d=ongy.net header.i=@ongy.net header.b=tCUcEbNI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ix+dg6uG; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ongy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ongy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ongy.net header.i=@ongy.net header.b="tCUcEbNI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ix+dg6uG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE1D91400049;
	Mon,  2 Feb 2026 11:16:36 -0500 (EST)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-01.internal (MEProxy); Mon, 02 Feb 2026 11:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ongy.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1770048996; x=1770135396; bh=cA
	l3f0aIC9v2qun9IsXlxzNV4TaRm5M7ocZisXoxNuA=; b=tCUcEbNI2S7CxBdB3l
	eK5RUzvojN+Ns+YbC1+qKTrTtEWvCIRtFWn0UMt9/u8IBwLWHJ9oysgJqLDkGOFd
	8YYwacB7Pe6gT5sXnVAcuf3mUwmEP6HYzmbOo7fo2xRkvTywAmKm4nJhsEWBRiik
	wWhvMgiSqodkUbuzcZq/bJ9+0WYPQDyHZgoWzDKOqXkCdrILlbhGrOgqIjhug7Xe
	haqcwBasAwzt9qz6lzb6k0gwQcIOV2g/XxSHgbyKMuYglEZSMMUr4FNpevs9YPHU
	c7EE6/G+MGOZRGAQwuYbif0rCnr0jU55x0XjcooVShJyzB+uv5Lk4Nzx5K0EdwDI
	rvPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770048996; x=1770135396; bh=cAl3f0aIC9v2qun9IsXlxzNV4TaR
	m5M7ocZisXoxNuA=; b=Ix+dg6uGfV+CJSELdurCQQFAdhtuoc2nH+bCQ2QI6qEP
	ALBMN05s9yiRFk28yJTAbB+pXpaJF34G7be9WPOPSZgECuHpyq0YGGJzlW/A6RLe
	5p9di+7xYHwcNfuSyb8sUF2G9ednu0DJg3pdgQQA4okMkTfXzOsZ4IcQ0wPLJBx3
	jxdEKZOohw3rNch2qR+i4meyPTVc7o8+e9hX4YQGDsiDoRcL5LFAFAi3lTFJJ79q
	KFEV7P/ajL+QyzlEkgnQkKXz1ept5K7xYrpOf/TiopKt1qlHCKYYAhIagCxDeAQU
	uxv6ZaiCyASP5P/65GHk2WNaoJLiAxed3L2g9dVGrg==
X-ME-Sender: <xms:5M2AaZ1JtYIul4hJVodKGmq0VO55LIW7oTVPKgzkREBaP_w9W5FAZA>
    <xme:5M2Aaa45nmXmMeJexU9XKGnVadbiKetChkz8X_Kr-KdzFj4hluFOE-NeT7fjzDmkm
    ZKCmJtIesXPNWt13KuSx9lhUj2QJs4X5abLCVX1IoRARel3H9sIqa-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkufgtgfesthejredtre
    dttdenucfhrhhomhepfdforghrkhhushcuqfhnghihvghrthhhfdcuoehmrghrkhhushes
    ohhnghihrdhnvghtqeenucggtffrrghtthgvrhhnpeeliedtveetkeeitdfgueefheehud
    ekveekvdegleduueeuueekjeejkefhvdeltdenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grrhhkuhhssehonhhghidrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghstghhihgvmhgrnhhnsehinhhtrhhinhhsihgtrdgrih
    dprhgtphhtthhopehonhhghigvrhhthhesihhnthhrihhnshhitgdrrghipdhrtghpthht
    oheplhhinhhugidqrhhtqdhushgvrhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5M2AaUwJUu9BXMnaG_O8Lp9E0i1RXggeB5G9sXwg2ApQCZ49-IGU-g>
    <xmx:5M2AaQDBIv0cNoEMuOhkmfrjNy74GG5liDyOMnEj4D4ZH9l2qgXH_A>
    <xmx:5M2AaZaok1cmm-ELjxBLeYHYlT-V0l14ErPTwdSE28NiL7RMI5nYiw>
    <xmx:5M2AaQgNL3zF3sBGkjw-2A4aDEtaSixIcTb3msbxg6nMdtuGEaT0hw>
    <xmx:5M2AaWOvnM9CRtgXdyNR2m8f2Gv51Ez95MesVXiTAjiN4oUvgtJHv7ij>
Feedback-ID: i5201479a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B56E62CC0086; Mon,  2 Feb 2026 11:16:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAtwXl1ib9vc
Date: Mon, 02 Feb 2026 17:16:00 +0100
From: "Markus Ongyerth" <markus@ongy.net>
To: linux-rt-users@vger.kernel.org
Cc: ongyerth@intrinsic.ai, cschiemann@intrinsic.ai
Message-Id: <4b7478ba-e10e-4877-b2e6-63203ffa9094@app.fastmail.com>
Subject: Ist drm/i915: Depend on !PREEMPT_RT. still necessary?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

in https://patchwork.kernel.org/project/intel-gfx/patch/YgqmfKhwU5spS069@linutronix.de/#24761794 the i915 module was disabled for RT_PREEMPT kernels.
The associated discussion mentions that it shuld be save to revert this once more patches have made it in.
From what I can see, further patches did make it in. But the dependency is still there.

Was this an oversight or is it still unsafe to use i915 with RT_PREEMPT? If the latter, is there a patchset we could pull to make it safer? Or is there some place to read up on the dangers?

Thanks,
Markus
