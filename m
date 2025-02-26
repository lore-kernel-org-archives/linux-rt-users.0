Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA921E5B85
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Feb 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561477; cv=none; b=ru0f+pRJsnfv1H8IMnVXtHv7oWrIFJxMoL6dch+JQKhKYq9gExwJWDM6lShpgL9JiDgsKGK1tHSbto1AcZENwzCOlkPIrY/FNy+ATrRUzgA5jlg8S096UWwZglNUW6sxyMFLQGSkA2+ATpgtKLcDRv+5I7sjChIMtoBEVWJffds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561477; c=relaxed/simple;
	bh=tIkWIH4H63EtuTXaIv2rojv2Rpm6ygDSr92qVs6DP5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvDNrOYTaIUiLmFvk6IjDdbj3Xhqg4lhF2S2hHaxcvOkyMkbqgMg964J8nyj/xXX/XePgFYY7u1Lkqk//ZZeqLRWilyFUDMuiJgz36Q6FGzIg64wyfUXQ7gZ1REs5didd5UGhg06BjSp0bI+AMRfQjbheaB6qGE3Rdj3XaB6xL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MLfl9Jhv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZVIqUMyy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MLfl9Jhv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZVIqUMyy"
Date: Wed, 26 Feb 2025 10:17:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740561474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAY7s3Py2zdV0fIbBnU8iAwnMWt29rUYTaq4TKJ83mE=;
	b=MLfl9JhvVWLtrwPeiQd57pRIHeCpTLGFY9jQ3yiNpwgl3Dld0MkGZ6TKFaLqBWNZIc2V9I
	uqWjLfHrCmnS/GqlfKtWK67/358Ce2m0FxeNRXZ44HlRYScnrB5EhfRabVWqD7Mp7k46XM
	9kY/qJp86jwlFTpKy4DpozR35JEp3VL+AQcihKBwvwXYc36LrrWWRevkfFVWnY1pZHHCcj
	rvVTQStLLTFpB+yIUJBvCDEaXfsIbum+daJCMBBLMZJDcpUeu5Ostyfh8YVskxT57TAFve
	RTYddduhPSA5yscudKZ/gBs4fCENf0pCdVbqP/UiMFP+lg8FGTB6TRkppwNkNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740561474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAY7s3Py2zdV0fIbBnU8iAwnMWt29rUYTaq4TKJ83mE=;
	b=ZVIqUMyylyNzaekAm4WlJA/2UhbwY1I1YZW+X42ibfviJ38n/F1zjLW8akKG/9/S9jYLLG
	tfdk4h1keRA1HDAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Ziegler, Andreas" <ziegler.andreas@siemens.com>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Subject: Re: 6.1-rt: NOHZ tick-stop error: local softirq work is pending
Message-ID: <20250226091752.jCsLqq66@linutronix.de>
References: <73c50e2fb53ba8cc2f1538abccc42e98fa63159b.camel@siemens.com>
 <20250224115557.AIFtijeu@linutronix.de>
 <d31ddc467399b53c3f0687db63cb64a3a7c77ca5.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d31ddc467399b53c3f0687db63cb64a3a7c77ca5.camel@siemens.com>

On 2025-02-25 16:16:25 [+0100], Florian Bezdeka wrote:
> > which version is this? I think is is an imported issue. Is v6.1.119-rt45
> > also affected?
> 
> This is a typo, right? You mean it is an important issue, no?

No, the version is correct. And I meant "imported" as in we got it from
the stable queue.

> We can see that on
> 
> - v6.1.90-rt (Debian -rt kernel)
> - v6.1.120-rt (Debian -rt kernel)
> - v6.1.119-rt45 (So yes, this is also affected)
> - v6.1.120-rt47

But if this is visible on v6.1.90-rt then it is not originating from
what I assumed.

> With PERIODIC you mean CONFIG_HZ_PERIODIC, right?
correct.

> We have CONFIG_NO_HZ_FULL=y set but do net set the nohz_full= cmdline
> parameter, so that we should get CONFIG_NO_HZ_IDLE behavior at the end.
> 
> I realized today that the warning is somehow related to our RT tuning.
> Enabling NAPI threading makes the warning go away, even if NAPI threads
> are tuned the same way as ksoftirqd.
NAPI threads? You have RPS enabled by any chance?
Would commit
    dad6b97702639 ("net: Allow to use SMP threads for backlog NAPI.")
    80d2eefcb4c84 ("net: Use backlog-NAPI to clean up the defer_list.")

help?

> I will have to look into that in more depth.
> 
> Thanks for your input Sebastian.

You are welcome.

Sebastian
