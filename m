Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE441A912;
	Wed, 15 Jul 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784135906; cv=none; b=ghGqZCREiIcVp0HJA+AYIP7c97eFqY6X0AEHKQIJZTPMjwU29XFn0W6fqjwZWqrnJkFDTOsxdTGOd4Dc5V5PEuqL5Ia0CUieejYf1jW7lVR0+ddGVUVbCJXsh1KdztFg9YJH8bERSy1rBrea00JR/N/nHz5kGwS1RgNXbYk00ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784135906; c=relaxed/simple;
	bh=Y6YCGKF2DUsNUvejqIjzPZGdYAWhHQ186qovA6chMUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCVH86jDBH0cXceLk2/u3bU6RrcJQF1H3bFA7Wh+MWOr/IefBHX0OCM0Czsx3y/WJ/+kFiymWfaSCsSw1lITmZIAk4XhHYLmCzyx+BKIuPQa84aF8lAoguVUVgAbsTTJFF0yWsZ8aRhzQ0r7i1z+U+D20Ylfwp/c3zDdplUyBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D14F1F000E9;
	Wed, 15 Jul 2026 17:18:22 +0000 (UTC)
Date: Wed, 15 Jul 2026 12:18:21 -0500
From: Clark Williams <clark.williams@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <alfA3ZaM1kmFaicG@demetrius>
References: <20260709143108.UYeCUUcd@linutronix.de>
 <2026070922-kilowatt-matador-5e1c@gregkh>
 <20260709152214.rH1O_8SM@linutronix.de>
 <748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
 <20260710115145.32729a7c@gandalf.local.home>
 <ae96c274f166301aba762d97caccddf176ad7968.camel@siemens.com>
 <20260714110718.E5qV5-Hf@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714110718.E5qV5-Hf@linutronix.de>

On Tue, Jul 14, 2026 at 01:07:18PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-10 18:01:20 [+0200], Florian Bezdeka wrote:
> > Depends on what you consider a valid update scenario. Updating from 6.1-
> > rt with sysfs available to something like 6.18 (no sysfs anymore) will
> > still break - as long as you do not (force) update userspace in
> > lockstep.
> 
> v6.1-RT to v6-18 no-rt will not provide the file. Also will not provide
> ARM, PowerPC or 8250-nbcon support. So it is not just that single thing
> that you "lose" if you don't apply the RT patch. It is just what you
> notice because you don't use the other things.
> 
> > I learned meanwhile that our detection moved to uname meanwhile, so this
> > is not a problem for us anymore.
> 
> Okay. So you yelled loudly that you need it, now not anymore.
> 
> So can we state that this it does not provide anything of value, is not
> considered needed and can be dropped?
> 
> Clark, what is the status on your end?
> 

I still carry it in v6.1-rt and v6.6-rt and don't really see a reason
not to. I don't believe it's a security risk since a write to
/sys/kernel/realtime gets ignored; it's just there to say that this is a
PREEMPT_RT kernel. 

So, I'm ambivalent on the keep or drop question. I'll go ahead and clean
up what I'm carrying in v6.1-rt and v6.6-rt and if we decide to keep it
I'll send you the updated changes. 

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
