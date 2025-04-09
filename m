Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393D25E828;
	Wed,  9 Apr 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207045; cv=none; b=d+4uQ9fkpFZiW2V/wxAReJuG9ZUUNgVR24mmUMXvIUQLPw3G6f1t0/9mbyERFvp/1UpUzANrR5BUgFZaDVeCGCSYZtmhawyq6eBXp+/8r0o8n910M/IWlW0+33W8ejo1uqhxsHz0TTrGrWTZ0YEMFATOOpXc785ocNLs42Rxn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207045; c=relaxed/simple;
	bh=cI6yZmEDgsJiuO5rI6UO9nMNwe9SimhETEWYtdH/wf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxazJbDEWXRz2VIJllBQy93uTO4ZHKQRX/YSkkteE32eZOcoeBkn/9A4s32tIb2Q0a7mM/arI6aiO0PVP0pRZ5WbMKCeMyAdH9KyDoVZKVdzJKWhnG0DjDzhVwSKEr0IVUSsdHxO9bK8krQ9kjfsXdQkkBTpl0Ax9g8RmmL60v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fU85CR+H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqS7DjIS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fU85CR+H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqS7DjIS"
Date: Wed, 9 Apr 2025 15:57:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744207041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZFOy/4zmqmg+X++WvSb/i6CdEz5XBR4GrfBEd4fF0w=;
	b=fU85CR+HIzC45s+B/f2sgRT8tpHSZEp2fduwdWpFCeuwh5HMR/HPMd4KWh3jxRIDOzjCc3
	cSDPPq+qlcmACp2ZorVUO1pPq0PiJeFi6GBWvvecSwRJOLVg5M+3UDnC+k3LPxPsvXUq6q
	9lcstb1i2Dsp9MuG9tWTiaZ6LEBcp5jXQIk0Veah1Q9KG6dkWO7lCRdwax9sbMyrrE5dTD
	px2Y9FZvRjJWaTAq0aGqqooKOjfNnlhhVtBK3yycUgvnpxnbRWyplzDAdnLSlNz5jC8hO5
	x+b8DKFw7HEaG2ueVgdh/vjOVRg0YeNxXgKeS4oiMrJSa+wvyNahGawtc15rJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744207041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZFOy/4zmqmg+X++WvSb/i6CdEz5XBR4GrfBEd4fF0w=;
	b=RqS7DjISqyfIKjtt/rugzVfmvhoeDsxk/iPv0CT9J6/bqXrKFGidA8tH3pcipMqWr19GAm
	6v6/VlMZKwr/BzAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
Message-ID: <20250409135720.YuroItHp@linutronix.de>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <20250409132149.rFrzBCrP@linutronix.de>
 <be4fa21d-0b96-45de-ac5e-bdb54bee335e@siemens.com>
 <905b3cca-e9ab-4844-bbe2-aa9a8c78e047@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <905b3cca-e9ab-4844-bbe2-aa9a8c78e047@siemens.com>

On 2025-04-09 15:52:19 [+0200], Jan Kiszka wrote:
> On second glance, Frederic's patch would probably also avoid the issue
> we are seeing as it should bring PI to the CFS-throttled read-lock
> holder (which is now a write-lock holder).
> 
> But given how old that proposal is, I assume the performance impact was
> even for the RT kernel too much, wasn't it?

I don't remember any numbers and how bad things would get just the fear
of it. But I guess this is workload related in terms how much does the
RW lock improve the situation. RT then will multiple the CPU and reader
resources to the point where it does not scale and present you the
lockups.

> Jan

Sebastian
