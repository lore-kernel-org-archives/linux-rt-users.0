Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF143134BF;
	Mon,  6 Nov 2023 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aFhDGKNj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQ6a0VGC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3919010C6;
	Mon,  6 Nov 2023 00:27:16 -0800 (PST)
Date: Mon, 6 Nov 2023 09:27:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1699259233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RaRit34QigfAN6g1ok2Kh0sQJTih4++oBpWcoF/3X7s=;
	b=aFhDGKNjomzYu8thqpDzhPSV9a7fC/ieq+RQldztq8olokBxD8ZnX0IKqrEiM7tuXIH9/o
	PF1ZXuOqLxd8EXgPk7tvSeFq6poRinag0BtTyeRC2zZyYfIi+xnW12Lp7paie3vvOrFdhG
	PxojcDRBWK8gjGahGyhK5apovtbhCHIVVpKMWgUJGdtPez4gtiHzNoN7QWNG7kiEjnlfJ1
	Q0D04YnnaElmshWTjEOfS2aRvBdXXCz+ARDfQ2nxqxD53SChi01T0Pe2JYKJ5GkI+nzZsp
	wsubw1Q367KuByq+I7dvf9mWaU49w+0dWVjzzoSkbI0KMe9ZHgzapdR45W09xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1699259233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RaRit34QigfAN6g1ok2Kh0sQJTih4++oBpWcoF/3X7s=;
	b=UQ6a0VGCHMUkCqLiEwExT9FNgarRugUzwdfjFhDe8393e5eISs02lUh3Lv++ymRXQBAYZF
	Rm4bIoXIAzM6FBCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Li, Meng" <Meng.Li@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <20231106082710.eTb2__57@linutronix.de>
References: <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
 <20231103154624.WEWPMHTp@linutronix.de>
 <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>

On 2023-11-03 16:42:18 [-0400], Alan Stern wrote:
> > I see. Don't over complicate or "correct" things here. What should work
> > is that the removal callback can be called at any time and things
> > continue work. That means it will purge all queues, cancel all requests,
> > timers, whatever and free all resources associated with the driver/
> > device.
> 
> The driver _does_ work under those circumstances -- provided the
> hardware is still present and accessible.

In that case I don't see a problem.

> > If it comes to PCI-hotplug you have to have a so called PCI-hotplug
> > slot. This "slot" will let the OS know if the hardware has been removed
> > or added. If you don't have such a thing you have to maintain the state
> > yourself by using the "remove" and "rescan" sysfs files of the PCI slot.
> > 
> > I'm not aware of any requirement for a PCI-driver to check if its device
> > has been removed.
> 
> That's the problem: The driver doesn't really support PCI-hotplug.
> The code that Meng Li wants to change was sort of a half-baked way to
> add such support.

This sounds half-baked. Just remove the device from sysfs and then
physically plug the card. It is going to end in mess if every driver
gets some "hotplug" support.

> Alan Stern

Sebastian
