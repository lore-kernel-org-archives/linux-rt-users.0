Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454031D75D
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Sep 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094045; cv=none; b=NPkDhHBmCg2hPv/L9oyjnP59FSQGq86ELR6DO1OpyaREA/e9DofSPZtNbQMHJFZf8M1M6X26RwqPyNEkBHeVpotGEhN1LoTVaIpNl8g5/D1SVZMvsUnjwNU0R0tQQ7YLIIGPXpi1UYTvNmSzEnV6U43GqcOMF08+xNMZ98D5ysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094045; c=relaxed/simple;
	bh=H6exaU1yGS8bVaaDcGsHMZy9+p38fxOmlfrD3dIADnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1tfeVf5vCo5if7h/1bRp9iGOrUf/4Vw/bnE12oOagwzeUlwvvRSIweFst819wTsisaijO6Hnz5iAIO6XGaeJ2WXM0okchWIe7qxDVfxeTVQ6VLeGvEQwyzFJlIyQoTKB1jV9sdfr5Zxr8caPBK7TGUYYPgdjBf6q2N+wcTybxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=NgIGExMQ; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="NgIGExMQ"
Received: from [IPV6:2a01:e34:ec24:52e0:fd42:a77b:1893:65cd] (unknown [IPv6:2a01:e34:ec24:52e0:fd42:a77b:1893:65cd])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 42B4419F59C;
	Fri,  5 Sep 2025 19:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757094035;
	bh=H6exaU1yGS8bVaaDcGsHMZy9+p38fxOmlfrD3dIADnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NgIGExMQLRZQF4TJtMD5CTiP/yzdGEBIIWvptFxUyoY9QxBZ3V74gQLEIK4qONX8J
	 nOTk9HPO3GYQvNJlX/QB+mobvXo07oJyL3XrAvIhZ7DN4MJkG55jikv8J1lP4BBoiJ
	 ZRuPOAOBL3Ur9k8uItmmPoJfddiythkfuRp7U02AoTLKA3cDcKx0THH2V3aZqCr/4t
	 Z4YhlnHqhwDcixpK4iY5QACozeTe7Z93zq4IFNr6FLVhl8mgnZTBFeWdkdpHWH4ula
	 tKmaspvfbRdw5tFFpyrywDj7fngH6+PRUi5MNyexNbil/amuyXbai7jG+kRFix2C20
	 iYe3qL0hKEYzw==
Message-ID: <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
Date: Fri, 5 Sep 2025 19:40:23 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Large(ish) variance induced by SCHED_FIFO
To: John Ogness <john.ogness@linutronix.de>, Daniel Wagner <dwagner@suse.de>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
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
Content-Language: fr, en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <84ldmsevcm.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2025 18:07, John Ogness wrote:

> On 2025-09-05, Marc Gonzalez wrote:
>
>> Could you provide some insight as to why CLOCK_MONOTONIC is preferable?
> 
> CLOCK_MONOTONIC is tracking in time units as defined by humans.
> CLOCK_MONOTONIC_RAW is tracking in time units defined by some hardware.

I'm not sure I understand what that implies.

Eventually, clock_gettime stores whatever it measured in struct timespec,
with tv_sec & tv_nsec, right?

Are you saying that if I have 2 identical timespecs,
one from CLOCK_MONOTONIC, one from CLOCK_MONOTONIC_RAW,
they might not measure the same time interval?

Are you perhaps saying that NTP can (ever so slightly) tweak
a clock to bring its frequency closer to "reality", but if
CLOCK_MONOTONIC_RAW ignores such tweaks, it might count time
slightly too fast or too slow?

Regards


