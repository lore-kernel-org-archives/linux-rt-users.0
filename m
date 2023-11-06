Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71BAD35;
	Mon,  6 Nov 2023 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y6Hb0MUX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O6MzddOj"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F2D49;
	Mon,  6 Nov 2023 01:09:27 -0800 (PST)
Date: Mon, 6 Nov 2023 10:09:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1699261766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2N6vJfqBq6qhs7eNQmT5PjZBJpKmPU/uOG+3V2MjLw=;
	b=y6Hb0MUX1PleRzOmY2ZlEwKPuVBMyodZ2WiNugTaAO4QqllpwMv15fTE8Nslq+XKEgV+kH
	KAXcUE631PfcdxPtr8TMKfzCfngmITYCpnt9E5HKjJy65my44vMj2PPlpNLU5ZCvWNp156
	4NZwfiuPykSGot+/HOHRU6Um8Q2z4xVK3bNtzqS3C5azjJcHWrjNs0cOFDwj94fd0FJpHH
	wzq1C0YL+pJjkyk6GBS1g5P8fZSe4W61g6tdsHjNQfwIAxra5TsX6Cxj58koKHdgqwDLP5
	Tz5H1AG3idLXmNXYeScxbHV+Iv93gU1e9qyOYPmo/ii17wBIGAyOm74Q81u+cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1699261766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2N6vJfqBq6qhs7eNQmT5PjZBJpKmPU/uOG+3V2MjLw=;
	b=O6MzddOjl/KhrR+5X5v0pQg6zgPMWo/kFSnpPqzU5ET3QyCzMIDBaFICzbkLMl9//WwOSQ
	8vzo76WZQMPa4gDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Li, Meng" <Meng.Li@windriver.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: RE: RE: USB: add check to detect host controller hardware removal
Message-ID: <20231106090924.3qeWpk98@linutronix.de>
References: <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
 <20231103154624.WEWPMHTp@linutronix.de>
 <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
 <PH0PR11MB5191B5D71DBD450210E2BEDFF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20231106082829.iBvQ9hCY@linutronix.de>
 <PH0PR11MB519187340D0C1AD3F05DC74CF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR11MB519187340D0C1AD3F05DC74CF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>

On 2023-11-06 08:54:50 [+0000], Li, Meng wrote:

> This is not my original issue that I encountered.
> I agree that we should remove the device from sys interface firstly,
> and then do hot-plug action.
> My original issue was the calltrace on RT kernel if I remove the
> device from sys interface.
> # echo 1 > /sys/bus/pci/devices/0001:01:00.0/remove
> xhci_hcd 0001:01:00.0: remove, state 1
> usb usb2: USB disconnect, device number 1
> usb 2-4: USB disconnect, device number 2
> xhci_hcd 0001:01:00.0: USB bus 2 deregistered
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 765, name: sh

Right.

> and then I checked the commit log to get which commit introduced this issue.
> I found out the commit is 
> commit c548795abe0d3520b74e18f23ca0a0d72deddab9
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Wed Jun 9 17:34:27 2010 -0400
> 
>     USB: add check to detect host controller hardware removal
> 
> And then, Alan Stern told me the background of this issue. so, I
> started to do hotplug operation on my board to see what symptom on my
> nxp-ls1043/6 board.
> And then there were lots of discussion followed.

Okay. I somehow mapped it that you try to add this to xhci.
The suggested replacement should cover it. Better if we could get rid of
it ;)

> Thanks,
> Limeng

Sebastian
