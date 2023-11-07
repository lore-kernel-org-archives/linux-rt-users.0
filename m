Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620E947A;
	Tue,  7 Nov 2023 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ff1NJIfU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KpJ9Htw4"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD95124;
	Mon,  6 Nov 2023 22:17:26 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 28A733200A7E;
	Tue,  7 Nov 2023 01:17:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 07 Nov 2023 01:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699337841; x=1699424241; bh=iW
	pOWkNXoKYBVtNR8pc31dTRMJjKZhIZTzDhH+VOCtU=; b=ff1NJIfUlXMbk2qYNk
	qU8kBYJx6U3SxoMuQXe6LEgQkwhnDmkqs7g9Esm82dRG6OuYa7RE8md8kiPTiTdp
	UKpZDTNC6UlaOCzc1NshaAgCRDB6p2xNPsxKH3F8P1JhSTvtY9yvF3/mhorQBm0I
	2rLgKodpqPlKXC1/7zLCu8CvkWi9apMOnn4rC5SvLtTczqcLThUTmVKW3d33hPRX
	omKtBOlU4GkMnMjCWuJoH2pzSS8Dn2ZFmQMIhoyU1k8zL22f00ZBT0msEvBQahIB
	8qo638YTurdTXd2Bo71TBa1+gPWYGTBeuBaQxYD0ueuDgd8nUjYnyD3uV+HplFth
	xrZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699337841; x=1699424241; bh=iWpOWkNXoKYBV
	tNR8pc31dTRMJjKZhIZTzDhH+VOCtU=; b=KpJ9Htw4JMo5/MNczh0+oggoZWvEV
	I6Z9/54krtfvM4CZVmbiKvzZ3c5ZG+3JNJXAMjrTOS0dUL/IEk78s8hgQEmBJfuE
	pLm8BgNhlpkRlTmT+b4c7wg5lOoUmzql6/cp4UdWhD/75dG+XWnQ5uHCqgVLO9mG
	ATN3RuEi+7ijCd7oe6s8c8V+GITb3QH7LTx394xOhGB0YIuE7smDwtNoh0huF+R5
	X5SOmFHC9aC2ZURo7PO1ou7Tnx5ho6zI3va77qXCWEVrECW4nEPh6+55OodkWqlt
	A5jGQSHO6y6IuJWV3hR6RKEW52j3ihr/r8/XifrBcPGMfMisR7R14+idw==
X-ME-Sender: <xms:b9ZJZUAtu50MjgLLJOa1snm6cyer-Dxq0q5Mxa8JEcL4_SEDQo-Npw>
    <xme:b9ZJZWjgT9IZfc1CGkTG0r6454erYMvaU7LRRtHTO5ZFg1idrBFRG5nxhNi4osMKz
    6JiWZRlmsSVVQ>
X-ME-Received: <xmr:b9ZJZXlU4FZP0eajsYArJI7lUfYWnidgoDA067nkBypySkJ6mX7Y4Do_U_TjrXDQUq-FeFHiSspgz5iWVtqdLDUBAZW2qPDdHdl6Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduhedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:b9ZJZawZ2JuxRtvdL5kufPmjp8iVAllIq5gVGT2JYasDk8dsMKao_A>
    <xmx:b9ZJZZQ655Co81z1NdgEWQlnvE3X8WQ-b0upW03mcAqI4QblZn_T5Q>
    <xmx:b9ZJZVaFa0oZwb8803LrvjYXbfpifFrWMJN4rb2cpFntLtg5yPvZCw>
    <xmx:cdZJZYKs0X043u3XrtuIkcle1cMNnNKm19bbQFP0YnjnKrd4BX2ZAg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 01:17:19 -0500 (EST)
Date: Tue, 7 Nov 2023 07:17:14 +0100
From: Greg KH <greg@kroah.com>
To: "Li, Meng" <Meng.Li@windriver.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: RE: RE: USB: add check to detect host controller hardware removal
Message-ID: <2023110741-festival-reload-c9db@gregkh>
References: <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
 <20231103154624.WEWPMHTp@linutronix.de>
 <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
 <PH0PR11MB5191B5D71DBD450210E2BEDFF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20231106082829.iBvQ9hCY@linutronix.de>
 <PH0PR11MB519187340D0C1AD3F05DC74CF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20231106090924.3qeWpk98@linutronix.de>
 <PH0PR11MB51911F20E4AE1E1FD8D25FFCF1A9A@PH0PR11MB5191.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB51911F20E4AE1E1FD8D25FFCF1A9A@PH0PR11MB5191.namprd11.prod.outlook.com>

On Tue, Nov 07, 2023 at 03:08:13AM +0000, Li, Meng wrote:
> 
> 
> > -----Original Message-----
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Sent: Monday, November 6, 2023 5:09 PM
> > To: Li, Meng <Meng.Li@windriver.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>; Steven Rostedt
> > <rostedt@goodmis.org>; Ingo Molnar <mingo@redhat.com>; USB mailing list
> > <linux-usb@vger.kernel.org>; linux-rt-users <linux-rt-users@vger.kernel.org>
> > Subject: Re: RE: RE: USB: add check to detect host controller hardware
> > removal
> > 
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and
> > know the content is safe.
> > 
> > On 2023-11-06 08:54:50 [+0000], Li, Meng wrote:
> > 
> > > This is not my original issue that I encountered.
> > > I agree that we should remove the device from sys interface firstly,
> > > and then do hot-plug action.
> > > My original issue was the calltrace on RT kernel if I remove the
> > > device from sys interface.
> > > # echo 1 > /sys/bus/pci/devices/0001:01:00.0/remove
> > > xhci_hcd 0001:01:00.0: remove, state 1 usb usb2: USB disconnect,
> > > device number 1 usb 2-4: USB disconnect, device number 2 xhci_hcd
> > > 0001:01:00.0: USB bus 2 deregistered
> > > BUG: sleeping function called from invalid context at
> > > kernel/locking/spinlock_rt.c:46
> > > in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 765, name: sh
> > 
> > Right.
> > 
> > > and then I checked the commit log to get which commit introduced this
> > issue.
> > > I found out the commit is
> > > commit c548795abe0d3520b74e18f23ca0a0d72deddab9
> > > Author: Alan Stern <stern@rowland.harvard.edu>
> > > Date:   Wed Jun 9 17:34:27 2010 -0400
> > >
> > >     USB: add check to detect host controller hardware removal
> > >
> > > And then, Alan Stern told me the background of this issue. so, I
> > > started to do hotplug operation on my board to see what symptom on my
> > > nxp-ls1043/6 board.
> > > And then there were lots of discussion followed.
> > 
> > Okay. I somehow mapped it that you try to add this to xhci.
> > The suggested replacement should cover it. Better if we could get rid of it ;)
> > 
> 
> generic_handle_irq_safe(dev->irq) works find on my board, there is no calltrace anymore.
> Will you create a patch in later?

As you have tested this, please create it and submit it so that we know
exactly what changes are required and you get the proper credit for
doing this work.

thanks,

greg k-h
