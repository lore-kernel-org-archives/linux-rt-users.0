Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC31A290;
	Thu, 19 Oct 2023 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zqyQKa+h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="deFXazVl"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6272A106;
	Thu, 19 Oct 2023 05:49:57 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:49:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697719795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tx35thUvqMkK7RHBH8M3GVge98yzc+pk+ttfy4Zgmkw=;
	b=zqyQKa+h4OcuenaIWllClEgyKlD/u+Bs0lZY8bEGBCyIppf59CSFHEWZynQLTPfmMMzrlb
	UHaX8ULkqziPUwegH8eYPT/RYFqwk4CWZsUN8ZNaoVfqFGsUW4y59yTy+2+gOm1U/KMsCa
	ysweUALFp/dhdiomxzdTMO0KCRp5n6dl5cT224wpHuSFbA6xPFFs+39FZagbROLo4IfkJp
	7POyoqh7awqQjt4zy0O45fIhLP5fm9TzD6v5LnM7thlupglQmn7iZfg2i/gqW5lPnxsxQ5
	T9CkV2oQqYvhvz5upB1Ewa6eKrjI1fInzyu1f+J/Yd66DfLDVAPnec2znsV22g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697719795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tx35thUvqMkK7RHBH8M3GVge98yzc+pk+ttfy4Zgmkw=;
	b=deFXazVlXF2HVfp+C/1uVG7R9pXlWRfOna1q6rGdH/dHxatH4HibxqxkTAQWJYbejBBQqP
	24ZoQpFfq8MjFsBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	"Li, Meng" <Meng.Li@windriver.com>, Ingo Molnar <mingo@redhat.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <20231019124953.kxpuDCgt@linutronix.de>
References: <PH0PR11MB5191464B2F01511D2ADECB3BF1D2A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
 <20231016125624.1096766a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231016125624.1096766a@gandalf.local.home>

On 2023-10-16 12:56:24 [-0400], Steven Rostedt wrote:
> On Fri, 13 Oct 2023 13:17:52 -0400
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> Because in RT, spin_lock()s are actually mutexes.
> 
> In RT, interrupt handlers do not even run with interrupts disabled (they
> run as threads), so the assumption that they run with interrupts disabled
> on RT is incorrect. One hack would simply be:
> 
> 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> 		local_irq_disable();
> 	usb_hcd_irq(0, hcd);
> 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> 		local_irq_enable();
> 
> But that's rather ugly. We use to have that as a wrapper of just:
> 
> 	local_irq_disable_nort();
> 
> but I don't know if we removed that or not.
> 
> Sebastian?

Got removed once it had zero users. It was hated because it was used
usually used as a quick solution to hide problems underneath.

> -- Steve

Sebastian
