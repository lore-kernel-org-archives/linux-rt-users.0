Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8A3054D4
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Sep 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351060; cv=none; b=VWTpELmKaVMUkaIKlerrMVUrcwNDJuQi6k6A0ApNAjJZztImzShfSKKK5mi3VWhDpZkDE2b5xMHMMmeuSiJlwGU/SuIz5DWzXV86gieG0YdOoRfTEIVMftPygKAMlxKbhN+25ZZncr45TcL7hJOjushVS2GI1BdFsPxHZbQN1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351060; c=relaxed/simple;
	bh=mtQ/ET4FZejv2fgP9oU9L4fC1DWKkDcZJifIHTy/jcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6Xt/UVKNRmr4vipHO4okQVcVXyUgxZNRaKmahFITEzVU8u+f+6bnTaN1E5xItVg0D1Vtw+BtrGPaq38T2y5q/gE3eyv/0xoyZ4QG7g4UCtkcXMtzJfe//k6ffW2rvdEaraMW07PTu92ttJjE5iW+CTpXgl6D6h88M5Xsx+FHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=XiKNEr4w; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="XiKNEr4w"
Received: from [IPV6:2a01:e34:ec24:52e0:8e2d:1dec:8874:3e59] (unknown [IPv6:2a01:e34:ec24:52e0:8e2d:1dec:8874:3e59])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id B6DA620039E;
	Mon,  8 Sep 2025 19:03:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757351050;
	bh=mtQ/ET4FZejv2fgP9oU9L4fC1DWKkDcZJifIHTy/jcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XiKNEr4wtx043kApA+VE2DanA8Q+desO3SwU21g9IUfMqiIoNocavpEaujsuMByee
	 2p9OxkQVF/s1mpT8uuVy9pkdJwUmL9nBvUJFzTPra2/unVoipaqeC12ZPgmez2xM3X
	 0KsjvnpIGWK2lSKUXI5h8DHREk7cZ8waL6GwatgoIsdZuxm3zlekLsGsEn+hXBFWkS
	 avRCzSrY3APe0+WoSMc5bmtT7K/R3ZAVqEjt0MewS/OrdXLWJujA5KPQ0vMVshoHh0
	 LgCkDcaBrLWHYn3mCt5pYDHs58Xg04urkeKFJZobGbfjZj4642YFNRGgbkwF2MRULc
	 81fjeh/mHaWqw==
Message-ID: <7e23f985-e6f2-44b4-a7f3-60d2c8cb76a6@free.fr>
Date: Mon, 8 Sep 2025 19:03:54 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: Large(ish) variance induced by SCHED_FIFO
To: Rui Sousa <rui.sousa@nxp.com>, John Ogness <john.ogness@linutronix.de>,
 Leon Woestenberg <leon@sidebranch.com>, Daniel Wagner <dwagner@suse.de>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Daniel Wagner <daniel.wagner@suse.com>, Clark Williams
 <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
 <84ldmsevcm.fsf@jogness.linutronix.de>
 <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
 <84ldmp8ewv.fsf@jogness.linutronix.de>
 <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
 <AS1PR04MB95012A6D68FC8F5D446E3E56E80CA@AS1PR04MB9501.eurprd04.prod.outlook.com>
Content-Language: fr, en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <AS1PR04MB95012A6D68FC8F5D446E3E56E80CA@AS1PR04MB9501.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2025 18:52, Rui Sousa wrote:

> Just replace your last setup script line with:
> echo -1 > /proc/sys/kernel/sched_rt_runtime_us

Launch script consists of:

echo     -1 > /proc/sys/kernel/sched_rt_runtime_us
# RUN RT BENCHMARK
echo 950000 > /proc/sys/kernel/sched_rt_runtime_us


https://www.kernel.org/doc/html/latest/scheduler/sched-rt-group.html

"A run time of -1 specifies runtime == period, ie. no limit."

1) Disable RT throttling
2) Run RT benchmark
3) Enable RT throttling

> I believe you are seeing regular tasks being scheduled
> in the middle of the benchmark measurement.

I don't think so.

RT throttling is disabled.
The benchmark runs as SCHED_FIFO 99.
Nothing can interrupt it, except interrupts :)

Am checking Daniel's suggestion.

Regards

