Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54E265608
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Mar 2025 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867357; cv=none; b=ozHHEzgybwi7f81BIt04tETzkwzCbLRPNnqiC0KgbGUlqeUnzcQjCm5Ukn0ZHylO/vpa3UHm4APAOfs9Zvg22yFY4E4XqxwV3kyvjSlLU3EavCZ+fp16rh8oMGImy6kYDp83chgveLxr0+j4TrQp0ADXk6qo6/BXcD0aXUzkYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867357; c=relaxed/simple;
	bh=N5+MI8+P1Z7agtjVMqDU/65hm2opzs/f4fNrPoHENio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDJlLblqo9x4O4076ScC/cSwetCBMZa6cfWR6MKppXRj5G9p3kxoE96SVCxN1eSWW4gLfBY2/6fj+7q8mY59/tM3dNXJd5hPjiNDvINQIHaYp2ZwrrQbyZksEc8Z3kfb/36ym91tmggT/V0XIxhfKKMtwtD+qR05nhtUjgCYm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JV7SbbWF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CZjdKl5W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JV7SbbWF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CZjdKl5W"
Date: Thu, 13 Mar 2025 13:02:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741867354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAtg4MMcaW6PEkyQyvVycIeJqTaU/ztViWpp+0KZny0=;
	b=JV7SbbWFoVRifOadyr3UrnGYV/ADejf6M15wfzOXMc0LEw5zQVJC3lR1xJiWZ9Bw/sMD31
	iQIeMZvlwgbyl4J/xD6yNacyJMquySOCP4TI83M/Sbm5Rolx0+/WlNCykASNAWhmOkAfMI
	KLW081cnLPg0/8zCNTBP8jzsICDYhinerbEu6nnbm2pjsQO4Gq9UUeog95a0IAIBBDyMKs
	6z6cwDt4UKIDYM90DMDoOFbRULaH1UqKz8iUTDyiw3IMWnQ02R+ch+dT6Jw0P9WwfR0M3e
	oHddMBkw+hS4W2hp+cxvihRh7qaVzHVaXwP+AqC/dKcGatjWJCJQFhNFgn58Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741867354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAtg4MMcaW6PEkyQyvVycIeJqTaU/ztViWpp+0KZny0=;
	b=CZjdKl5W1a37nUirZ0rMipZORATwOo3JQt3GFeSt6v6Qs60RGL035f7nc0OP7YB17DqroJ
	ozXmWFGLPAFuy3BQ==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: NET_RX softirq work in ktimers
Message-ID: <20250313120233.gWZEwPPu@linutronix.de>
References: <30a9c98bc11b40de720e1f7462302243f7c8ffb7.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30a9c98bc11b40de720e1f7462302243f7c8ffb7.camel@siemens.com>

On 2025-03-10 16:07:03 [+0000], MOESSBAUER, Felix wrote:
> Hi,
> 
> on a 6.1.90-rt30 system we occasionally see NET_RX softirq work being
> done in the ktimers thread. This could be related to running ksoftirqd
> at a RT priority, but this by itself should not be problematic as PI
> boosting can result in the same priority.
> 
> Is this already a known issue?
> Does it only result in delayed timer handling, or is it also
> problematic from a functional PoV?

I wouldn't be concerned about delayed timer handling because most of the
things there can be delayed. Anything series should receive a wakeup
right away. It could result in delayed networking if timers go nuts.

> I quickly checked the linux-next tree, but did not find any fixing
> commit.
> 
> Extract from an irq trace:
> 
> ktimers/1-29 [001] ...s.12 ... softirq_entry: vec=3 [action=NET_RX]
> ktimers/4-53 [004] ...s.12 ... softirq_entry: vec=3 [action=NET_RX]
> ktimers/4-53 [004] ...s.12 ... softirq_entry: vec=3 [action=NET_RX]

ktimers runs at a RT priority so that ksoftirqd, with all its things,
doesn't have to. Which is odd because that one usually shouldn't run.

Usually, if the networking interrupt is scheduled, it should boost
ktimers to completion and then add NET_RX. This then should not be
picked up by ktimers but only run within the threaded interrupt.

> Best regards,
> Felix
> 

Sebastian
