Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965E31E85E;
	Sat, 16 May 2026 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778955722; cv=none; b=s970axRUdDU5PtbWwJe9WQMXumdAngR3ntyAkqrUcBLXhrwYOD5gYd3qsTdM74LykVGN2ouGN88pWl2DT67VfvxnNPPcWSmaLClbHYM2OrNGmYlEDiJgBO5oQNpnsvE/vPhczaWUdJnIj5hwY0wVI0REUzlFdJWB1qw92nGtTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778955722; c=relaxed/simple;
	bh=fzXfV5gAmhJGdfewVZxSYNo7REcm5ceNH1Bddomxt20=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D4SdasfsyzGzco0U5zLCE3Yz6ykl0Fz1s/2Kp5T8Y59xc/VyLIQbF4hwU9sccoL46aXqF5jDkx8Xx3Y6yhW5h7xgD22Vl2I6PON9ZjpLZTJCn/ixAGlFuZsmQHabEljUqOcYwIm6dLSPuN2vqfU2f8lzfAcjmfn9qI4sm4kEK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=s8hpa9L9; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s8hpa9L9"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gHspj6Rt6z9vMQ;
	Sat, 16 May 2026 20:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778955710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xdH9ckA5rh24zalIKYm+XMbPAk0c034nqRbaGEbD7M=;
	b=s8hpa9L9qoSqz5//0oyCMRNlNueouBFM7hVw/qo+TBdk1EDqGL4fDyrPi3cRBTYGkeQBFe
	+Vsjm05tiVfpVao1ctPQGtrWVlPO0Qhxqeb4OKhmoPoHetudbL9QD8xnkmkVARvJGpKPcm
	V1rwujohM/9oekn3JbhHXLSh7Op29Fs3pae7ffSBQAOOq0v0QhhxxtDw2j/ZWEyzpiifQW
	e+NJEYljE4CnOA/yHVqQ+V0rgkZpoGRzhm2Db7RDi9z91HAW/PZzWKnKXjTJuhRsy+hB5+
	S5RORKt0HkFfxNgQr5X3Y7hWn8AaE+hIBpNSwxMVKb1qZzBn6bzYmiiDWFos8w==
Message-ID: <69c53493-aed5-4f50-9777-10e06c403edd@mailbox.org>
Date: Sat, 16 May 2026 20:21:43 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [ANNOUNCE] v6.12.89-rt18
To: Daniel Wagner <wagi@monom.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>
References: <fe181873-9a38-4b4b-aa9a-3a45b28dd769@nitrogen.local>
Content-Language: en-US
From: Lukas Beckmann <lbckmnn@mailbox.org>
In-Reply-To: <fe181873-9a38-4b4b-aa9a-3a45b28dd769@nitrogen.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: td8u4hkne8siukxand1wcc17nadsbrfc
X-MBO-RS-ID: e233e0cc2197140a8aa


On 5/16/26 18:58, Daniel Wagner wrote:
 > Hello RT-list!
 >
 > I'm pleased to announce the 6.12.89-rt18 stable release. This is just an
 > update to the latest stable release. No RT specific changes.
 >
 > During my testing, I saw some spikes on my x86 box, but so far I haven't
 > been able to identify the issue. I recently updated the entire lab, so
 > it could simply be a misconfiguration or something similar. Since there
 > were a number of high-profile CVE fixes in the stable release, I didn't
 > want to hold off this release, especially since there are no RT changes
 > at all that could cause a regression.
 >
 > You can get this release via the git tree at:
 >
 >  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
 >
 >   branch: v6.12-rt-patches
 >   Head SHA1: da81d744fde93759451b625bdcaf1c4eb7a3b18f
 >
 > Or to build 6.12.89-rt18 directly, the following patches should be 
applied:
 >
 >  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz
 >
 >   https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.89.xz
 >
 > 
  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.89-rt18.patch.xz
 >
 > Signing key fingerprint:
 >
 >   5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C
 >
 > All keys used for the above files and repositories can be found on the
 > following git repository:
 >
 >    git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
 >
 > Enjoy!
 > Daniel
 >

Hello,
The spikes that you see are probably related to this regression:

https://lore.kernel.org/regressions/4e31e3b5-fa69-4c4c-a5e9-dea7a8452ee7@mailbox.org/

Lukas
