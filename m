Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B508364949
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jul 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610539; cv=none; b=TYwRLMfXHouFAsoFFULTxykE1lhDqt+jYPbOJ7f9iinxYKrc3wKi7JBfSBJ8SrMO2YApjRUaSltOu//UfUSw2GcSLpxzBf3rlFgJDDAAten4ORGQ/2RL0YN+cfkGGh04A7MxBiSaQ/86Yi43qXEICiBKmtlQA7hYSmOy21peYTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610539; c=relaxed/simple;
	bh=Avu3zt/h9UsavX8wNzIe+JndjpBKa41frzVQAb2CyuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uANP33NCmQw+/V0q3bA2V2U0deYYOhLM4A22bZtb1pP0UG4QGwlNT34bJG7+TjNzmZHXiRMslnTWL/4QCrM/2IlZHL55yExjvglHjqf9nRVj7+McKhJKG7e3pcRpJP9G9hLxqos1KiwTh5dDyjUyOuBH01FCHg0XVgk2gkQy+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oPwbU1Jw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TAaYbcaP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oPwbU1Jw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TAaYbcaP"
Date: Thu, 9 Jul 2026 17:22:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783610535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9EG/H1uUjNxWze83yzXvpoT9YUdC0MLYvueN66PiCc=;
	b=oPwbU1JwJE/zxctw8ZZL/E7BuIdbmZkGZm+Re7/zV10hD7jgQBjrUopbI2e3VBU8c27Fqp
	IDfb39TWHkAOh2MC8fOmqLm2FPc93tG6/+H/5c4zaxTG6NaExOxghldb8Hbr7dC9BIMUhy
	ak7Z1CuMHpv87hTyC29niIoJ9jWIaajGwkk3CxDikNqWiapWgmZdaPoecubYlm6PM+ApMg
	KDWkiyyoRRM9SSs3hadlQ+jYmWcYVPmgKMktQvsVuqKw8xXXiS01iiuH6LGUIehwxjMBVC
	xtTc6jvzZUlVGO+ale2rfoAU1Ndb1wR4F5AhBQ2BbsXAi0NX+0qfg/3rlohVMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783610535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9EG/H1uUjNxWze83yzXvpoT9YUdC0MLYvueN66PiCc=;
	b=TAaYbcaPx8u50NYJjo6oSTRc7xtOoUa1kcgz3/GOr84PotxLzNtd+rYk7Qc8/BjeIHCvQa
	JeZx6fTZyAreVJAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Clark Williams <williams@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260709152214.rH1O_8SM@linutronix.de>
References: <20260709143108.UYeCUUcd@linutronix.de>
 <2026070922-kilowatt-matador-5e1c@gregkh>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026070922-kilowatt-matador-5e1c@gregkh>

On 2026-07-09 16:46:19 [+0200], Greg Kroah-Hartman wrote:
> On Thu, Jul 09, 2026 at 04:31:08PM +0200, Sebastian Andrzej Siewior wrote:
> > Hi,
> > 
> > The following patch sat in the RT queue for almost 15years now. I can't
> > find its origin on the list.
> > All it does is adding /sys/kernel/realtime once PREEMPT_RT is enabled
> > and returns 1.
> > 
> > Is this something that is still wanted and considered useful?
> > Is this something that can be expressed better by other means?
> > 
> > There was an in person discussion about this and it was suggested to add
> > /sys/kernel/realtime as a folder and having individual realtime features
> > as files. I don't remember a single feature that would quality for this
> > today but who knows. This is all I remember so far.
> > 
> > Now. Discussion go!
> 
> At the very least, it's not ok as it's not documented in
> Documentation/ABI/ :)

:)

> But really, why is this needed?  Userspace shouldn't care, right?

So there is Clark who needed it 15y ago for some udev rules. Maybe he
elaborate on that.

There is custom "software" that is designed for realtime environment and
if it is run on a regular kernel then it missed its timing requirements
and the software goes usually in a fail state and people start debugging
what has happen. If this happens often enough (booting a non-RT kernel)
they tend to add a check so that the software complains early enough
since checking the kernel is usually the last thing that is done.

This could work with the file (or folder) or by parsing uname output. I
know of at least two individuals that switched to uname because the
upstream RT does not have that file.

cyclictest (from rt-tests) is using this file but only while collecting
system information, nothing else.
	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/lib/rt-utils.c#n528

There is also sosreport
	https://github.com/sosreport/sos/blob/main/sos/report/plugins/kernelrt.py#L32

using for information collection purpose.
There is thermald
	https://github.com/intel/thermal_daemon/blob/master/src/thd_engine.cpp#L1065
but this looks like just information gathering. That check looks wrong
since there is a space instead of an underline in the check so this was
not tested on a RT kernel.

> And checkpatch should complain about the sprintf(), should be
> sysfs_emit().

Sure.

> thanks,
> 
> greg k-h

Sebastian
