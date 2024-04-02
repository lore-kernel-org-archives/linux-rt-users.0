Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F712BF21
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068909; cv=none; b=YGzOLvYea5ZAYses+5d1NOzVvOMdn8QK6FiXEtdxfrgLiAwfoAC3C9MHMusCNfSP00Juc4B6KsKyIyKb+mAa9VUSJE4/9yxgPs/gdvXCp+NzgFj4t5rr8XBIk95GTQsUIeWtefklOZu4c0WgtaWsxF78g0sc6OHi9iJG/qcSZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068909; c=relaxed/simple;
	bh=sy//8AzQyDn7hpikXT08rA6W50nDe7758+QRxItvENY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmFNeXJckPxShIrz/Ishh7boxd/Ots3MMOwXBIdQrAD23+tGj7dyvDwDbhTIozCuJ6z6lb6bLhOpU6yTpXALet3sXxSQBUodx6BV6/Dg6OjsggvggUw5N6UnpHYYSwINB80gizD5ESd1Yqeeq6vDPF35Vwes5mTIXMrqj/1jcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=dr9qSat/; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="dr9qSat/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TzGel1d5/3zM13/eBv/v0aGYA7vzFzugOcxT+MvXcFc=; b=dr9qSat/+OPDj+xfh9dNqvfFmm
	mBSOCp+UtT7gUv3/L+Ie8KBsQlb7EQfnFCSYZGIpFaWmVTkQbsY0QKHQbvozB3TDoAbrM6qE+Oc9c
	OIClssCUix6Ckz2UDWITMp9gcGhWDA0KcYU7z2KekJUdKpuUovyTm2uS8UpCYkCR/A7hQXCz2C4DD
	+XtAzZ0jjVjFBPWXoxXwRwlKajk9cPzw1DBgB8WPFenBxkuoBqOhqb+0yD0ut6rfYWPXSEyiF7EF9
	vzUfzMlCmN0yanrZ8g/lKYKBgOuBOb9pIFKhC3Hi2WrQ3Evq1HnN3H4naAZVtSpwsWg4CEeQ1nDdH
	AxbiIRiQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rrfKZ-000A7B-Do; Tue, 02 Apr 2024 16:41:43 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rrfKY-000ETW-2z;
	Tue, 02 Apr 2024 16:41:42 +0200
From: Esben Haabendal <esben@geanix.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,  Steven Rostedt <rostedt@goodmis.org>,
  Sergey Senozhatsky <senozhatsky@chromium.org>,
  linux-rt-users@vger.kernel.org,  Martin =?utf-8?Q?Hundeb=C3=B8ll?=
 <martin@geanix.com>
Subject: Re: [PATCH 1/2] printk: export pr_flush()
In-Reply-To: <87wmpfq4p1.fsf@jogness.linutronix.de> (John Ogness's message of
	"Tue, 02 Apr 2024 15:29:06 +0206")
References: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
	<874jckqcxu.fsf@jogness.linutronix.de> <87jzlgf1w2.fsf@geanix.com>
	<87wmpfq4p1.fsf@jogness.linutronix.de>
Date: Tue, 02 Apr 2024 16:41:42 +0200
Message-ID: <87zfubesih.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27233/Tue Apr  2 10:26:21 2024)

John Ogness <john.ogness@linutronix.de> writes:

> On 2024-04-02, Esben Haabendal <esben@geanix.com> wrote:
>>> printk() tries to print directly from the calling context. Are you
>>> experiencing problems where you do not see the restarting message?
>>
>> Yes, that is exactly what we are seing.
>>
>> It is an i.MX8MP system, and console is attached to ttymxc1
>> (drivers/tty/serial/imx.c).
>>
>> Booting up, and simply executing "reboot" command. Without these two
>> patches, the "reboot: Restarting system" message is not written to
>> ttymxc1 console. With the patches, it is.
>
> This console driver is using the legacy console interface. For
> PREEMPT_RT, legacy consoles run exclusively as a thread and thus may not
> have a chance to flush messages before a shutdown/reboot. The correct
> solution is to port the driver to the new nbcon console interface.

I see. The `if (IS_ENABLED(CONFIG_PREEMPT_RT))` in console_unlock() is
preventing the console_lock/console_unlock dance to do what I need.

Are there any other examples other than 8250 for how to port a driver to
nbcon?

What is the plans for porting all of this to mainline?  Should all
drivers be ported first, or will a solution to prevent this type of
regression be implemented at some later time?

/Esben
