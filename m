Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E7731AF10
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Sep 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356867; cv=none; b=c6veGy6Is3AOIuMW3hThkFflhchY4qGrTyMe6w9fE4EPrN8SupCg5/kS4krZbQ/4Yu++8lp6JniUyPkQFautQ4SJpVxJntqgTQcXachJVDc0lV6oNmO7VC+TvqBK5dlOZ9My8bY/EHbvladCFFqqhdO7D0/2gH11eP/jN4aShNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356867; c=relaxed/simple;
	bh=hdhFiUtLf4lkLl9ywbpTfvuOGi29y/QIZgFgBLnIxzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOJRwCRrJlAskgJbSCx94jBX9f4BMM05gJWt70JRDAVDYjQjN0htQUHTLKQYp2jxVi7M9pQZRuI/dfO9eI/afb7W8XtDvptfXuYAvhMsxCZL7IdT2a7Lf1eLs74orHZlW0gn+cV4e6b/B8o+EpVuZlaVwd82GgZ8/+Ty+44kaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=a9/Hhqsr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="a9/Hhqsr"
Received: from [IPV6:2a01:e34:ec24:52e0:8187:dc5f:9ce0:e84c] (unknown [IPv6:2a01:e34:ec24:52e0:8187:dc5f:9ce0:e84c])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 1D51C20039C;
	Mon,  8 Sep 2025 20:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757356863;
	bh=hdhFiUtLf4lkLl9ywbpTfvuOGi29y/QIZgFgBLnIxzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a9/Hhqsr+Jk+dDtYNqpC1/I21reG7elE00LOinKv9TsmLG6xAXgoLTJ6pEzX3LY+7
	 RW027Ux9F/2uaAY6kVA65PCOlc0OV8Giuc2kmbKdpGXv8/jreWpA+FyOKwAS9pU3m3
	 oz04/PO3098m9lv/1Ubv+TaJ06RKVKp5E5wSPtQTMP6kQSu8rZS1fB6PCu0lZBxYR/
	 Ru2Fpa2VsTK745NVXlV1BYodVBx2Pt5yi4x60iNH6hlfkuaYqqDBTMgn0w5BdrSJfn
	 gnPtCG3piJaw17XD0zf8cnnFLsC8+4WPV6AsrFqHYvfzOa6dMuCaA8WhBUl5gNDB3L
	 wMfLTAom2PASQ==
Message-ID: <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
Date: Mon, 8 Sep 2025 20:40:50 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Large(ish) variance induced by SCHED_FIFO
To: Daniel Wagner <dwagner@suse.de>
Cc: John Ogness <john.ogness@linutronix.de>,
 Leon Woestenberg <leon@sidebranch.com>, linux-rt-users@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
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
 <d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2025 18:02, Daniel Wagner wrote:

> On Mon, Sep 08, 2025 at 05:42:58PM +0200, Marc Gonzalez wrote:
>
>> I've run out of ideas to identify other sources of variance.
>> (I ran everything in single user mode with nothing else running.)
>> Perhaps with perf I could identify the source of stalls or bubbles?
>>
>> Hoping someone can point me in the right direction.
> 
> There are few guides out there, explaining the common pitfalls. I
> suppose you have already found them. Just in case you missed Frederic's
> excellent blog on CPU isolation:
> 
> https://www.suse.com/c/cpu-isolation-introduction-part-1/

Thanks for this great link!

Is nohz_full=X a superset of isolcpus=X or are they orthogonal?

(I see that /usr/sbin/irqbalance is running on my system.)

Regards

