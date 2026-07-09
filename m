Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA733546E3;
	Thu,  9 Jul 2026 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608384; cv=none; b=NafsqEM8YfEeW1vNUvIqkWohDV9m/w5k95oXrcc4D//SXjVIUuYjLKDNF5AZVm4mJk4q2ExhbgIrG+pTPATC8lGsSTCOuva6f9fTyRhzDFqpCJ8V92SSi8fqkSL1oPEdCq89FNcrcYnZKdcjZsSL9xVsNIcx6T5Y2/gRuausNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608384; c=relaxed/simple;
	bh=eJ+h6/lXpJCk4eI/exWo4sp0JP8DgG9coEpBlM8IjJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0QAiMZWk7jyI11NWMY6D0GdlrFzUqnSM5sgDRraGLoehct6Zpecthw2+3NLhPNIeWa/iUp1SfDEBFy4nGOCfJt5r5yEqmyZpl6L1lNH6K89S3vdLPGpZghJTknp/wh4NmXOgVz8ZEPvUIH6sIxZ7KAqWmBCZt0Eko0gmMq6Mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nULFwRNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nULFwRNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481EF1F000E9;
	Thu,  9 Jul 2026 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783608382;
	bh=Du6XqMSaeWA87grycj96VaPj3Jaq9JvDXeSGVPV59D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nULFwRNKnj1v8BcpS82+yTlUBkJDPTvKCqm0/GhKbEB0OsscH96h5kMd5O5ljIGlv
	 JeTr8YQMu8n+IGm6XjcxIQn+smDH1zecZdyVL4ALGffqkwJOtJRMiOyiCJqlMh3167
	 pB/ClWZS1chsCSICHY3/o08t21OEtB7x/Qb5N9AI=
Date: Thu, 9 Jul 2026 16:46:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Clark Williams <williams@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <2026070922-kilowatt-matador-5e1c@gregkh>
References: <20260709143108.UYeCUUcd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709143108.UYeCUUcd@linutronix.de>

On Thu, Jul 09, 2026 at 04:31:08PM +0200, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> The following patch sat in the RT queue for almost 15years now. I can't
> find its origin on the list.
> All it does is adding /sys/kernel/realtime once PREEMPT_RT is enabled
> and returns 1.
> 
> Is this something that is still wanted and considered useful?
> Is this something that can be expressed better by other means?
> 
> There was an in person discussion about this and it was suggested to add
> /sys/kernel/realtime as a folder and having individual realtime features
> as files. I don't remember a single feature that would quality for this
> today but who knows. This is all I remember so far.
> 
> Now. Discussion go!

At the very least, it's not ok as it's not documented in
Documentation/ABI/ :)

But really, why is this needed?  Userspace shouldn't care, right?

And checkpatch should complain about the sprintf(), should be
sysfs_emit().

thanks,

greg k-h
