Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8516086C;
	Tue, 25 Jun 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323050; cv=none; b=X+hWP0SoWo7xmmb1urbX9c3JSSosASJnY2OZ2f/2NOmO3OdE3diuKvVz4bmJUVAoLCI59os7aLRLrfOJtJClKAD1mYD5S9if6LvFrQeALPDRZSXHeZ7F6Gq5HqmasGrNUJEtea7pPRg1q0W9QJ0kNEOnoxyYwIkuDG1BW5m8wO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323050; c=relaxed/simple;
	bh=cuBcFHRR249NAwvx9irRcav/Eox9IdRxFIgKPF2mrB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F//WBrzO4sBqjQI8Ye9lCv895hxscY4D9KulnTskXMfgefHBB3wND2WlPjBYusv51dPeIr4DaJwAdYqqfgoxYoAJH3pK3XdartTzO6nsTp/f22GXJjoQa057W8KXWdPmaJpDxuZ7k16jr+tj4bdlcJs5DW797a4UKeDDjdqJuVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92519C32781;
	Tue, 25 Jun 2024 13:44:08 +0000 (UTC)
Date: Tue, 25 Jun 2024 09:44:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Song Chen <chensong_2000@189.cn>, Derek Barbosa <debarbos@redhat.com>,
 pmladek@suse.com, john.ogness@linutronix.de, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 williams@redhat.com, jlelli@redhat.com
Subject: Re: a question about how to debug this case in ftrace
Message-ID: <20240625094406.42acfacf@rorschach.local.home>
In-Reply-To: <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
	<6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
	<xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 08:20:15 -0500
Andrew Halaney <ahalaney@redhat.com> wrote:

> So I ended up doing a sequence like:
> 
>     tracing_off();
>     ftrace_dump(DUMP_ALL);

I've done that several times too.

> 
> in the softlockup code when it was detected. Ideally I wanted to look at
> the vmcore and look at the ftrace data in there (since debugging printk
> by using printk is a little confusing), but there was a makedumpfile bug
> I hit... so I went with the hacky route to prove to myself what was
> going on. I think since then that's been resolved. Hope that helps!

You may be interested in some work I'm doing that allows you to read
the ring buffer from a previous kernel after a crash.

https://lore.kernel.org/linux-trace-kernel/20240612231934.608252486@goodmis.org/

I also have a way to ask for any memory, that should be able to get the
same location most times, via a "reserve_mem=" kernel command line
parameter.

https://lore.kernel.org/linux-trace-kernel/20240613233415.734483785@goodmis.org/

They are both destined for the next merge window. After that, I have
one more patch that ties the two together, so that you can have a
kernel command line of:

 reserve_mem=12M:4096:trace trace_instance=bootmap@trace

and then when you boot up, you would have a trace instance that would
be mapped to that memory. If your machine doesn't clear memory after a
crash, you can read the data from the crash on the next boot.

-- Steve
