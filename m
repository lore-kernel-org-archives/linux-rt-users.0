Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249043B4BC;
	Fri, 10 Jul 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699525; cv=none; b=oIXTklmqbO61HApHEFCZLuxjfWQukoX0hQldxIhMU1IVM7nrT90ERecQPwbB0jmyr+C2iEh4zoh9umoIoptCTbi0iyrkImMPWGIU9RKsTYtXx4fC7IyQ47kmczUNvhjAaOvYPaC/FmI7Q5YPwCMPKGLK9CqPfLt92Kx8QmQUpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699525; c=relaxed/simple;
	bh=rPJpoETGkG/MvZTRHUX7l2t9BB3nMCbvxTPR54TighI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVA+V4DCYVpgqx8PhM+baqInTpLLjZkC4637YtIqg2/dK1AJ8aQBMvYjPY6Lg2CxWRspujj01s83ush4DVQQC8xpNBDZFjIF3scJmoA56CQKZkMZ5GdA9E3jgPeczGXQAyDUCdoK2TjzpP8pyHRcwWMuyY/G+Xl/0k8jpYCPsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZfZRKgcu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZfZRKgcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B899A1F000E9;
	Fri, 10 Jul 2026 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783699516;
	bh=/tvLFowctqq9owjKlKrlDlpQvpAhO46vDylrbgxG4dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZfZRKgcuxyC7C6rubRqcw2w7Ut9UkCFLwzDMFusOo4BRlB4B27AhEGef+7KrruBkU
	 tUBU5EdQFREq5HL7O1wIXEkuGft3SsEU5cukiBF3sVAqSj0MNEQJL6GbvMD4FeUdPX
	 YCXvXiW+quNHOhVX6/DBPv+C+B2fmkeCz70jAeIo=
Date: Fri, 10 Jul 2026 18:05:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Clark Williams <williams@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <2026071052-backstage-skype-f22d@gregkh>
References: <20260709143108.UYeCUUcd@linutronix.de>
 <2026070922-kilowatt-matador-5e1c@gregkh>
 <20260709152214.rH1O_8SM@linutronix.de>
 <748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
 <20260710115145.32729a7c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710115145.32729a7c@gandalf.local.home>

On Fri, Jul 10, 2026 at 11:51:45AM -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2026 09:23:16 +0200
> Florian Bezdeka <florian.bezdeka@siemens.com> wrote:
> 
> > uname might qualify, yes, but keep in mind that this sysfs based API is
> > already used, so a removal might break applications. Yes, userspace can
> > be fixed / adjusted, but it remains bad style, no?
> 
> Then at most it will likely just stay in the -rt patch set. As it was never
> mainlined, it's not breaking any user space that uses only the mainline
> kernel.

I never said I wouldn't take it, just that if I would, it has to be
cleaned up...
