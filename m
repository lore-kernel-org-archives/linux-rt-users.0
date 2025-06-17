Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.31.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF212DBF4C;
	Tue, 17 Jun 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.31.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168689; cv=none; b=DU4/1ydnu9/iurEc+tIQ3xqfsBptesHjyD2DiZfbBr2wn+SEsESTlQ0C5MmfnLslOlCMFO1/Jgi4xgbV5kPLCNUFIKBMoi2JhCxoApAKiggbDHP9rhYihXfBE8ylmxa1Oeq5O4LUBdtEL0u4cKQcXT02nZmLDsLNrFApsGIak2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168689; c=relaxed/simple;
	bh=CFtLsOFLFGIiCRFnTt2iOFk29p0WHpWhEjfgeStGpS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoRy0fZMCZhhGghYeXmecJvroI+tvfhVY7FlGBRccHU0kuRewE0f4gACle4ICqbV3eM+c1gUU2Uc15FBeSc7iHTQ1b+QIln8YA5se5yE7Jb/ZIMlfB9mZNIZ9Xqok5HDMEo4zu94WuUGSGT7WVWaLxBAMERuqHyH6sxH8c2aWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de; spf=pass smtp.mailfrom=eltropuls.de; arc=none smtp.client-ip=80.67.31.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eltropuls.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eltropuls.de
Received: from [87.79.10.98] (helo=mail.eltropuls.de)
	by smtprelay05.ispgateway.de with esmtpa (Exim 4.98)
	(envelope-from <marc.straemke@eltropuls.de>)
	id 1uRT9q-000000003tS-0ACJ;
	Tue, 17 Jun 2025 12:03:10 +0200
Received: from [172.16.0.75] (unknown [172.16.0.75])
	by mail.eltropuls.de (Postfix) with ESMTPSA id C99CAFFC71;
	Tue, 17 Jun 2025 12:03:31 +0200 (CEST)
Message-ID: <b7179ac8-c64b-44dd-b25a-62b34eb49c24@eltropuls.de>
Date: Tue, 17 Jun 2025 12:03:31 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel?
 IGB
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
 <20250617092814.vqKdu23w@linutronix.de>
 <bb74b5b6-bc23-4aa4-83df-449dc7c9006b@eltropuls.de>
 <20250617100013.1o5lsPLq@linutronix.de>
Content-Language: de-DE, en-US
From: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>
In-Reply-To: <20250617100013.1o5lsPLq@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: Y2F0Y2hhbGxfbWFpbEBlbHRyb3B1bHMuZXU=

Hi Sebastian,

On 17.06.25 12:00, Sebastian Andrzej Siewior wrote:
> Even if CPU1 would handle CPU0's timers then it would wake cyclictest on
> CPU0 but that thread would have to wake until CPU0 is done with the PCI
> bus. CPU1 knows nothing about it.

Okay then the latency I see on the other CPU must be from a PCI access 
done by the second CPU which stall on the same shared bus.


Anyway: Thanks for your help Sebastian! I can probably live well with 
these spikes in latency. I was more concerned that there is a deeper 
issue with my config and the response time could be unbounded.


Marc

