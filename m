Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF147ACE7
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Oct 2026 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906756; cv=none; b=qmH+Q/7yu8K9qTDHMhsPuPDs3OS3p9fDzf45X1zk1zDp0FzSveAs0zoAG0ohBEb5cs14puR4DOGX6acFqcAIoUi1PjNcQKR8AVn+pEOckRuYU3lKzDTKELoxZU5AuHO0T8UMfRICozHj9+KXo5P3S5UFiAcD5CgSCWkfa7Gb1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906756; c=relaxed/simple;
	bh=KIAE6GJTJzUkqYcG/AlsgYZv88uNj1Poolof2hdvLSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ1g4cUYzM/hl40JzFCOPmt09yUikTVwQdJHQLLvgPSvoqR4yDatqbHXF7Hfkp2I6oKLEPe5hO+5vB+p6sIHiwbWQMjrLcOmmk6+07SXiFYAxrWdCv1hhQFpJnf5tX1UlbUmp7G0O0DPhZn10iL3Qm7s+O7C6MojxhoYjPYxN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JdetdMIN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GoGTK/B1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JdetdMIN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GoGTK/B1"
Date: Tue, 13 Oct 2026 17:52:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791906753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++hmKV+Or9/eKCk7n7d1Z1QMz/w+wG+aGRSs5746ZWM=;
	b=JdetdMIN3SKnnQXY9wxCQl0x3IogxY+6jtDuAvzSwz+CdjEo9Cz53UU6tzGrjONNCwQCgh
	yrOdTTQlglwvnv0/VK/c0xg1OmWAMhJzQr4c6hskhJtTGcH08GDRDITEbNIulKWwXCdciU
	YsaiKwal1H3Qo18ERSwHdvywEAn5xZ/R3+AMe3tABPro855LEZYSy2vQe/BwZqYRxrc0CJ
	xaFldiwyHXKbLKtEsLibDTkQxb0qsAm13+TpmJo+WsGT5voHIzmhYI3gVpKq6onCD/+Hnw
	K4lOA3krwcjeCas85n52NqhiBH5vckbGVn+49QjXpexkPQgMtnVM3brv4B7E+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791906753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++hmKV+Or9/eKCk7n7d1Z1QMz/w+wG+aGRSs5746ZWM=;
	b=GoGTK/B1e+ymkvo/lKKCTgPdxopT6pH+S86LI0VsXZWYmiv3WB3Z0vVBGnXe6agD+OlsUe
	jeXWWiprymuFkbDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Naulls, Peter" <PeterNaulls@eaton.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Btrfs PREEMPT_RT transaction-waiter livelock:
 experimental mitigation in kernel 6.6.78
Message-ID: <20261013155232.OWc0f2R9@linutronix.de>
References: <PH0PR17MB4277167A37B20340B231443FBB922@PH0PR17MB4277.namprd17.prod.outlook.com>
 <20261013144119.-2EEqlL-@linutronix.de>
 <PH0PR17MB427717FB56C49D194444AB6BBB9E2@PH0PR17MB4277.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR17MB427717FB56C49D194444AB6BBB9E2@PH0PR17MB4277.namprd17.prod.outlook.com>

On 2026-10-13 15:29:39 [+0000], Naulls, Peter wrote:
> With apologies for Outlook formatting, it's not my first choice. 
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> > This sort of sounds like the state is TRANS_STATE_SUPER_COMMITTED but is
> > not making progress after that. Are there any tasks involved that run at
> > realtime priority and would block other tasks from making progress?
> 
> I won't say it's impossible, but it's not likely. We have a monolithic app which is disabled for this test. There 
> may be other subsystems writing to the log. To the best of my knowledge though, there's been no adjustment
> of priorities (we are experimenting with this, but it's inside the app and wasn't turned on for this test)  vs default 
> Linux setup - it is Yocto using a largely standard setup. 

in that case ps should report just SCHED_OTHER for most applications and
SCHED_FIFO for the threaded interrupts and a few others.
The tasks that are running during the test-case should be all
SCHED_OTHER.

> > Could you try if you can reproduce this with v7.3-rc7? This one does not
> > require any additional patches.
> > I'm not sure if this report would help the btrfs folks to recognize if
> > this is a solved problem or where the issue might be.
> 
> Trying a later kernel is not impossible, but it somewhat time
> consuming, I will have to strip a number of things from the build, 
> and Yocto doesn't make this particularly straightforward, and might
> even compromise the test. We will update the kernel 
> in due course, but you'll understand I'd prefer not to commit this
> time without some degree of confirmation here.  As things
> stand right now, it may be that we just run without RT, but it would
> be good to at least verify this, and have a record for 
> other people. 

Right. You could try just the bare-kernel and yocto's .config without
anything else. And then just replace the kernel (and modules) on the
target. If this procedure can reproduce the bug on the latest kernel
then it is still around. Otherwise it is either fixed or something
changed and it does not reproduce anymore.

> As for brtfs, yes that was my next follow up, I had been just about to
> do that before your reply. 

I'm not a btrfs guy myself so I kind tell if this gives people enough
clues to as what is going on.

> Regards. 

Sebastian
