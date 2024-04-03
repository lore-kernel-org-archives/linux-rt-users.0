Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44E73174
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Apr 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137570; cv=none; b=d9ODLKM+lwASdtphHubZ1/2RE5MTp7SyDqlBNPo8bI7iKt7r+bPZBl3S01nTj3XxRFs2HKcLYDnopyVpwY76+c2kKe5dNMhoK/yJByaBA67mfSq6co/50CREC6bvN8EnxLTmLKuG4Sm10Jx/DD7IzZ3Q558R35oF/IBwiaCPOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137570; c=relaxed/simple;
	bh=jt/g/yQXaB8wj15nxy0XcRU4wYx2m0BrZ/I5tKyWGDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AIPemTzJd9vzmUSkieucYf9Cjb7uaqDgS+Fx5MCwbL11Mg7tuzO4Ff/L9+Lk7ozcoPvw5wbi7sOGh8Moku7SwGjXLIr5o17pgS8Utb2tJqWIii+fkwh0OedqPI6aEf7yZzS6QtPaevlozbn6FGkbtdXKqFR5bF3GXa0Gw7DQkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=lTximA5V; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="lTximA5V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8+HQrrYkM+4pNJKvO1rt3zMTElCGBRPiNlMIqtEm+CU=; b=lTximA5VB/uA9w9zENP809poTN
	L/ivvk4tstSDMHhtUNVBGIW+1u+LE1y62n91mB5s+IlUzot71wJz9T0Azfwj1qG1446IHuGfhWlqo
	mRH4+oHjptyb/yLm5KTuYX0O12wUOR/qSgII8QuFH3115GsQXtQM2HSQPhkqDaeR7C4tiFcf2CrqT
	GcPKpr/5wlnukROAPj8bD9hdTeJ5U7RYO/IqVJzAlYXmzsnJjMha477s3bggv59SVnkNNACyEbPI2
	sO2tfwQmUeg85O0EUPPxLguO7Dv9//ip7mxVt2ut4zddlAUoa1pMZGc9K2DcpXZ5fEVuXmc45ccVf
	Od7CF3cA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rrxBs-000CVF-LB; Wed, 03 Apr 2024 11:45:56 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rrxBs-00H4y5-0u;
	Wed, 03 Apr 2024 11:45:56 +0200
From: Esben Haabendal <esben@geanix.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,  Steven Rostedt <rostedt@goodmis.org>,
  Sergey Senozhatsky <senozhatsky@chromium.org>,
  linux-rt-users@vger.kernel.org,  Martin =?utf-8?Q?Hundeb=C3=B8ll?=
 <martin@geanix.com>
Subject: Re: [PATCH 1/2] printk: export pr_flush()
In-Reply-To: <87o7arpza0.fsf@jogness.linutronix.de> (John Ogness's message of
	"Tue, 02 Apr 2024 17:26:07 +0206")
References: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
	<874jckqcxu.fsf@jogness.linutronix.de> <87jzlgf1w2.fsf@geanix.com>
	<87wmpfq4p1.fsf@jogness.linutronix.de> <87zfubesih.fsf@geanix.com>
	<87o7arpza0.fsf@jogness.linutronix.de>
Date: Wed, 03 Apr 2024 11:45:55 +0200
Message-ID: <87v84yye24.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27234/Wed Apr  3 10:25:27 2024)

John Ogness <john.ogness@linutronix.de> writes:

> On 2024-04-02, Esben Haabendal <esben@geanix.com> wrote:
>> Are there any other examples other than 8250 for how to port a driver to
>> nbcon?
>
> No. 8250 is the first example. And even this example is changing a bit
> with each new RT version as the underlying APIs and semantics have been
> changing.
>
>> What is the plans for porting all of this to mainline?  Should all
>> drivers be ported first, or will a solution to prevent this type of
>> regression be implemented at some later time?
>
> First off, I want to mention that this behavior is only with the
> PREEMPT_RT preemption model. And it has been this way for a long
> time. The behavior of legacy consoles for other preemption models is the
> same as mainline now. So from a mainline perspective, I would not
> consider it a regression.

Got it. I think the last version where I know that this problem was not
seen with PREEMPT_RT was 4.19. And yes, that is a long time ago :)

> It is hard to say how this will actually play out though. We are
> bringing the printk/console rework to mainline piece by piece. Until now
> every piece has needed significant modifications in order to be accepted
> mainline. (This is the main reason the 8250 driver keeps needing
> changes.)
>
> The updated 8250 driver will be the last piece to go mainline. Only then
> would all the APIs, semantics, and documentation be official. Hopefully
> it is quite similar to what we have in the PREEMPT_RT tree now.
>
> I hope that once the printk/console rework is complete, there will be a
> big push to port over the other serial drivers. Most of them are just
> copy/paste of each other, which should simplify the porting. And since
> the new nbcon consoles provide real advantages, there will also be
> incentive to take on the porting effort.
>
> Finally, if someone wanted to try porting another driver for PREEMPT_RT
> (for example, the imx serial console), I would certainly be interested
> in reviewing and integrating the patches for the PREEMPT_RT tree.

Sounds good. I have looked at porting imx uart driver to nbcon, and have
something working now. It does smell quite a lot of copy-paste
behaviour, but I will send it as an RFC for you to see when I have
tested it a bit more.

The write_thread and write_atomic functions share quite a lot of code,
carrying half of the copy-paste smell.
The other half is the inner loop of the write_thread function, which is
almost identical in 8250 and imx drivers.

I guess there is room to refactor this to avoid this amount of
copy-paste before starting mass-porting.

/Esben
