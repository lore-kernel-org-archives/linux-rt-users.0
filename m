Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196F1624C2
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738856202; cv=none; b=gBhYPq99bF/mbuP/evKfJNqERoffkMns13lVL/YMIRbBVRSrsCn3wkyeptjrDBpf5Ca18ODVrLh6sdGIWOYKJwo1KvwsqRftwehhaUWLtZdU8Y6Ay/+rqexlRDo0cP75qGoKaIy+wyp6BqJzBMKxDizMzXXWGPMHnNXPAw2b2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738856202; c=relaxed/simple;
	bh=Cu7UZnzweGc1lYIfj+OWv63Bi349SCllESW1sVjTZ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m50qChseBnhL10WYgN7nN5E5eJc0Wwwl9Hu09AKluw7aCcHISeubcWOVLb13zfOzL8pHoEmKuH+Sq0+EYCi9iWflaU/1KN1KkwESSoAN8Zni3m0pa+vzCUqK64gwVx2FH07oBubiSwrPndsQ0ykfuAy80Qhf64gX5gWHMB5nw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4FZU2bn0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVWsBYIw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4FZU2bn0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVWsBYIw"
Date: Thu, 6 Feb 2025 16:36:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738856199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0czCh7+YE1JNI11QYYvP+x31sRcnPRc0g3in+5kNVs=;
	b=4FZU2bn0Xs8R3ePJGrkPyCzp0R5Z8L/wjPxeXcRpv0oRScbk5E2U2DwZZv0KVNIs/rFvTw
	gJ43IjlIjmi7VKyfdhT+SCXiNmfWSdGzNagzhwldHeP+aLjYHW34ZDWNKXoY8vHN0TEcrg
	1d8YOwnIEz6IpdyByNO6W4qRvt5I3JtDHDb+ze0LRRcUsRzWBOxtXBhrrWT3oed4SAox9u
	X2h1qXigXXuQmurMAD5SB1aYyFOitEpEeg3U6H40fjOaKK614fjtl/o06nsWCxMWg0I7gr
	tcdMIKFleT9fWOattSCf4Ls8bhRKT7uM2TpGHUcclPibvl4xHnAF4UgTUhTGiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738856199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0czCh7+YE1JNI11QYYvP+x31sRcnPRc0g3in+5kNVs=;
	b=dVWsBYIwt75GOmeddSwwoiwzLbi+fV49uLzn6SEsjwz/czwdkmFEBTp48VjnNosWtfgFHf
	wmw/68V2kOqlHeCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Rafael Folco <rfolco@redhat.com>
Cc: williams@redhat.com, jkacur@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] Change min/max to float numbers
Message-ID: <20250206153638.vagnFWGA@linutronix.de>
References: <3a9f0f10-2e7a-4eb6-b094-e5492b43505f@redhat.com>
 <20250206120056.oE88fgG6@linutronix.de>
 <2cb9215a-61d8-4b97-af66-6ef4194f3e04@redhat.com>
 <20250206150947.GYesymE5@linutronix.de>
 <01ce78a4-0780-4af0-a9ca-6f654934ec9e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01ce78a4-0780-4af0-a9ca-6f654934ec9e@redhat.com>

On 2025-02-06 12:24:42 [-0300], Rafael Folco wrote:
> > so core 3 has min 33ns and max 129ns while 1us on average?
> Yes, because avg rounds up.
> There are some other potential fixes coming like:
> - stop rounding up avg
> - splitting bucket 001 (us) which is bigger (0 - 1.99999)
> - adding the max bucket to the end (do not limit to 32us)
> 
> ... but these are out of scope for this change. 

I'm not totally against floating point numbers here but you should add
the bullet numbers to your patch description. Also you might lose
precision over time if you deal with floating point.

However what you just showed me looks like the statistics part is
working right. I mean max lower than average. At least it is above min.

> Folco

Sebastian
