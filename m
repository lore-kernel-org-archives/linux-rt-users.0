Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5C42464D
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206946; cv=none; b=gAI/Mk+DfloUcB/RRvh+TLm9ONyJZAfrYA5kigvkZz12f/nopfUtFf/Kvm3sUIxBuLwtgjDfg881kH3rUO8Fm4F//wPQ/ktcdzqTRBSQHA8y+BCx72bwLQMzOjXCaMORcndMeoBN0x86iMwzEZu/WaEp0T8p2jMB9fP0YdRQmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206946; c=relaxed/simple;
	bh=Ze6s8VdThzGMKrBXTB45qXX1AQcVO7v31NBdMfIgdBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC3yZ+Kciw4n6f1DB2XpirYsVdQ2vRgM09Rhqjdz+9/ifvHWSECyZqsU7PVMzmcmUrldtZ+E+odzAyapnO7Vi/NVhwJV7QUacdU8ieFy0ZTEM2BNVusLCWPZ61cogV+puaIdLdHLhqwuwoHbyclVKcegx8jA15fPFmLsSQwH1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vh9bdtuO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+EEOa4y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vh9bdtuO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+EEOa4y"
Date: Thu, 16 Jul 2026 15:02:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784206937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48Pb7U8ibySN14Dj/pl8Cx7cjOEGZ2zMu05jsQsKM+A=;
	b=Vh9bdtuOLHGEhBdj2vTV+zUgTW8lsBBiYBtFhDAqU6WmqjFsM9FJ3ll4/Hjum27/4hZjgW
	im24923HJ8eWWpmxPkUFT90hXa5o1pv4Tba+gdzqOCE28u4QOmA0wkKnUweeF2La39puiJ
	1xbNi67K51+lFx1W8rOmsEmYgreN4K7THCW9MNIHjBT82zzp5NRSJlgFqC4FibzRlzHnX3
	thh82/5hCCbnkJrSArks511bkxO5Rn4wyo8Bt14/cVKZvrtpG5+FQ7mmvRIfvRBLMwI0PJ
	vpHLq01FR7oMQX3iTSH3eoY8l8OM2bzlGH/bZ2PoC2MLi0CBbULB26MeCOZ9jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784206937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48Pb7U8ibySN14Dj/pl8Cx7cjOEGZ2zMu05jsQsKM+A=;
	b=R+EEOa4yQxPebApQUs9azfnyy8vnXDcibchXjEzehysrQ2PEhWVmqrsya2d5bY2NuDelAq
	KsS+mJazDrpFFdCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clark.williams@gmail.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Clark Williams <williams@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260716130216.dTmk8kCQ@linutronix.de>
References: <20260709143108.UYeCUUcd@linutronix.de>
 <2026070922-kilowatt-matador-5e1c@gregkh>
 <20260709152214.rH1O_8SM@linutronix.de>
 <748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
 <20260710115145.32729a7c@gandalf.local.home>
 <ae96c274f166301aba762d97caccddf176ad7968.camel@siemens.com>
 <20260714110718.E5qV5-Hf@linutronix.de>
 <alfA3ZaM1kmFaicG@demetrius>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alfA3ZaM1kmFaicG@demetrius>

On 2026-07-15 12:18:21 [-0500], Clark Williams wrote:
> > Clark, what is the status on your end?
> > 
> 
> I still carry it in v6.1-rt and v6.6-rt and don't really see a reason
> not to. I don't believe it's a security risk since a write to
> /sys/kernel/realtime gets ignored; it's just there to say that this is a
> PREEMPT_RT kernel. 
> 
> So, I'm ambivalent on the keep or drop question. I'll go ahead and clean
> up what I'm carrying in v6.1-rt and v6.6-rt and if we decide to keep it
> I'll send you the updated changes. 

I'm not suggesting to drop it from existing stable trees. It is just, if
there is no wider audience asking for it and reasoning why, I will drop
it from my queue and not submit it upstream. I just don't want do it
quietly.

In
	https://lore.kernel.org/all/ak_GDsJS6kVoUM2f@lysander/

you mentioned that it was needed in the past. If that requirement is
gone and everyone can live without it, I see no reason to pursue it ;)

> Clark
> 

Sebastian
