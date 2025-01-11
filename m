Received: from 16.mo561.mail-out.ovh.net (16.mo561.mail-out.ovh.net [188.165.56.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D361B6544
	for <linux-rt-users@vger.kernel.org>; Sat, 11 Jan 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.56.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627615; cv=none; b=W2et8GdNANk2Luhloop0yvVk2lRGB2Co9JRwAqkPekF8fLJ0a4PMueEgE+zcjFHWNJTImpol/DFpRdEhjY4aGnI7AtAmHfKCPG7ky9KE5J0PFUQfHj+i7TCAQY5UdF2vZ42rzcy95EflW6/vNfCJp6ejzq6QZoXDrx+N91lF/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627615; c=relaxed/simple;
	bh=6q6bl0NPtNIOS/mPjS/BFesbjUs6/5FgRsu/4+p6FvE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=tIzydWyRFxlVyh2K4elTjXMaW2TSwmkmSoAYvaNZGhzTPZcnxdN+khtFKyFO+InKDPeo1BaHLLsPn+JEGIv6CAsbZTs57Y7DE7X2HCRhREyt+ZyYcOBHnpHi3xh8yHMco+nK9sWGGe5t6ep+AdLrElgmptRjVcmmRBPFDg5qm/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaudron-nautique.fr; spf=pass smtp.mailfrom=chaudron-nautique.fr; dkim=pass (2048-bit key) header.d=chaudron-nautique.fr header.i=@chaudron-nautique.fr header.b=iVBeMEho; arc=none smtp.client-ip=188.165.56.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaudron-nautique.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaudron-nautique.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaudron-nautique.fr header.i=@chaudron-nautique.fr header.b="iVBeMEho"
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.9.135])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4YVpFR3LPFz1RtY
	for <linux-rt-users@vger.kernel.org>; Sat, 11 Jan 2025 19:17:47 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-q4rhw (unknown [10.110.96.84])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 376D51FD42
	for <linux-rt-users@vger.kernel.org>; Sat, 11 Jan 2025 19:17:47 +0000 (UTC)
Received: from chaudron-nautique.fr ([37.59.142.111])
	by ghost-submission-5b5ff79f4f-q4rhw with ESMTPSA
	id POFQA9vDgmf5Sw4A/SUKmQ
	(envelope-from <vanvan@chaudron-nautique.fr>)
	for <linux-rt-users@vger.kernel.org>; Sat, 11 Jan 2025 19:17:47 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-111S0054f7d4b6d-345e-42e8-a8f1-4851d2a33a05,
                    510E52AC6DABEA1FD68B4F42488EC675CFEBCB53) smtp.auth=vanvan@chaudron-nautique.fr
X-OVh-ClientIp:82.64.108.188
Message-ID: <62b8238e-c70a-40fc-bee5-11b56df2a288@chaudron-nautique.fr>
Date: Sat, 11 Jan 2025 20:17:05 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Le Chaudron Nautique <vanvan@chaudron-nautique.fr>
Subject: data shared between RT and non-RT programs
To: linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14112873858378681244
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudehtddguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfhffuvfgtgfesthekredttddvjeenucfhrhhomhepnfgvucevhhgruhgurhhonhcupfgruhhtihhquhgvuceovhgrnhhvrghnsegthhgruhgurhhonhdqnhgruhhtihhquhgvrdhfrheqnecuggftrfgrthhtvghrnhepieelgfeujedvkeeihedukeejudevleelhfdvvdfgiefgkeduieeujeetvdffudegnecukfhppeduvdejrddtrddtrddupdekvddrieegrddutdekrddukeekpdefjedrheelrddugedvrdduuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehvrghnvhgrnhestghhrghuughrohhnqdhnrghuthhiqhhuvgdrfhhrpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqrhhtqdhushgvrhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedumgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=wsRxEVt/jztPi+Pu7UUF8qXoTEh4gB9eqbScfGBhk0E=;
 c=relaxed/relaxed; d=chaudron-nautique.fr; h=From;
 s=ovhmo4169961-selector1; t=1736623067; v=1;
 b=iVBeMEho7KI7hndhLgbMmlo993uQtmYHBTkoHxsHefCKwNBuad19TlnjXkAq0Kej+mwZxNJr
 Mbqv39LpULiVgejloRZfOKoSuUTUPtN1vt/vWfu+6dJv/TaFXvy0yCV/C03srooJYgT/xcJFpjP
 mbijRsaEoQ2NO+IJSJO+SZpFR9aMltqKDLWTm/fOYbFgoLhkNIrSll/XVfVy+0o1QHwXH93kSEi
 IePR4U9bATnczg7ZQqrU3E0huaY4FgaUIHUQYfI4difp5vp/lB+7d7a4jQ88QwCy4rTIzU79Rxy
 w6dMl0t0HBYCscBmQQzKU4obAkcGrZcYjqC7Mriopldhg==

Hello,

I'm setting up a system on a raspberry Pi where 2 isolated cpus are each 
dedicated to monitoring an encoder (and compare the current values to 
the tresholds "enc_target_1" and "enc_target_2"). These tresholds will 
be written at a stage where nothing moves, thus I have no RT constraints 
while writing them.

The two other "housekeeping" cpus  will also run some programs : 
external communication, setting of enc_target_x values, launching of the 
RT-sequence on the dedicated cpus and display of the value of the 
encoder "enc_current_value" (for information only, no time constraint)

What would be the more efficient/safe way to communicate the current 
encoder value to the no-RT cpus ?

If the speed of the encoder is near the limits of the RT-cpus, reading 
the "enc_current_value" from the non-RT cpus won't be possible ?

I thought to have the RT cpus write a variable not too often (every 
0,5s, or every 50 steps on the encoder) to leave enough time for the 
non-RT to read it (the non-RT reading being preempted by the RT writing 
if it is too slow ?).

Is it correct ? Or is there a more "standardized" or more efficient way 
to do it ?

Thanks,

Mathieu

-- 

