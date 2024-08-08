Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859D51CD25
	for <linux-rt-users@vger.kernel.org>; Thu,  8 Aug 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102310; cv=none; b=OPQxCrRyPMjFBXRj2cwSPjqbkmgjMEf2eTtc9IFHk8gycgDDAsMHZ4RnnceLZjFe5oUUZPgpC/VIcdKQGBadWe9kgc8gobQDjrTEK5QvfFEnjWWV0+xqBOrM9/IqSKFJ+0PZY4urHGY72k1Mwjqo3FYmRGvh7mnsbdAATcgXKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102310; c=relaxed/simple;
	bh=1WeKBCVOZmrmpUl+I1u3M+H3eQq5rPgGqmqEKXmCTQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAtFlQGtKOfdKGoU9umv4etxe8x72EgLLjlO9lZ4LynvNOi5fm1zaUopEnbiZJtyzPfdzJXVA4G03KMpQh9QEokn/2ch86G9MYKNhzRvya3dQcXc0JIh28el/x7uS7slAEiyhDBGPuBRd5d+Y7HcX4U6TBC2HkvOdNYBIQTjVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hFTxwFsD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aKVBOitv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hFTxwFsD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aKVBOitv"
Date: Thu, 8 Aug 2024 09:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723102306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7/9D2uLH+nvBJMcso2NLMrRux4DLLwDF0gn+iwaOSc=;
	b=hFTxwFsDjYhnaiPVEJtpcUjfcixXPv0dy517TFoIRSk7K9NuICFnfkWRLIfy0B+Dg5z0a7
	TUMaz7leTPIJkp3HDRd4PuLbVaz1Ia3ezHeSuIOaWoD8wcmxf5uQYEVrAxvbADWnfB8mza
	5Lh7O6Ewx0IInhIWsPMjZjnNsrem14TEEHcOtIJJ7gIfwluWSU2s7cMSOVmH13+NEkl362
	EUxWcuU+xcXCxAVfngggG2Ef0H0IlSzb/BwzrRjW/4GUeDhD35wlxSHqfPLjm1thf5WJUQ
	H034Zdzpz7C8YS+gdPoA71VdgsijTXdkTya4S7ctDGatZwVh8miinUWM4QVyeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723102306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7/9D2uLH+nvBJMcso2NLMrRux4DLLwDF0gn+iwaOSc=;
	b=aKVBOitvUu9vOiRs/xvP/qgvoHVWGTZAMa973Jxj5nuuvdnukY59Lk6Vi6itW7ya9F6VRo
	Ik1DqoBtTccsX7Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Du Dengke <pinganddu90@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: cyclictest: lttng debug the reason why switch graphic window
 case cyclictest become high
Message-ID: <20240808073144.KbHsG-Xi@linutronix.de>
References: <CAKHP1dvNRstrd_JQK9J+83UPmv7GNRfODx9L_nmOO-JawKXvyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKHP1dvNRstrd_JQK9J+83UPmv7GNRfODx9L_nmOO-JawKXvyw@mail.gmail.com>

On 2024-07-18 14:38:05 [+0800], Du Dengke wrote:
> Hi all
Hi,

> The two compare show :  when switch graphic windows case
> sched_waking  209 to 922
> sched_wakeup 332 to 989
> rcu_utilization  205 to 2151
> sched_switch  279 to 1374
> increasing high.
> 
> Is my thinking right? If I am right, the cyclictest runing on core 3 ,
> which isolate form irq, userspace application, why above function
> affected?

I wouldn't expect that sched_waking/wakeup increased on the isolated
CPU3 unless something else was scheduled there.
The latency might have increased simply due to the shared cached, yes I
assume the cache is somehow shared on your system. Also you may get
better results if you lower interval from current "-i 1000" to 500, 250.

> Thanks
> dengke

Sebastian
