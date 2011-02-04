From: Victor henri <nadaeck@hotmail.com>
Subject: RE: disk thread problem when using RT kernel
Date: Fri, 4 Feb 2011 20:18:08 +0100
Message-ID: <SNT110-W188DD31DA3E18CF9E5F4D1A8E60@phx.gbl>
References: <SNT110-W34A9D54FBCD3910233EA5A8E60@phx.gbl>,<4D4C47FC.2080100@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s25.snt0.hotmail.com ([65.55.90.36]:55686 "EHLO
	snt0-omc1-s25.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751802Ab1BDTSJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Feb 2011 14:18:09 -0500
In-Reply-To: <4D4C47FC.2080100@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Hello Carsten


> Date: Fri, 4 Feb 2011 19:39:56 +0100
> From: C.Emde@osadl.org
> To: nadaeck@hotmail.com
> Subject: Re: disk thread problem when using RT kernel
>
> Victor,
>
> > [..] When I got soft lock (it happen very quickly), I typed
> > AltGr/PrintScr/L, */M and */T, but only */L gave me something on the
> > screen; so i got a file called /var/log/messages; i'll allow myself
> > to send it to your mail directly
> Yes, this would have been ok.
>
> I had a quick look at your kernel messages. Are you sure that you are
> using a real-time kernel?

Yew I've I have booted on on the rt kernel; when I type : uname -r, i get :  2.6.33.7.2-rt30 (on the tested laptop)

>
> I did a
> # grep "Linux version" messages.txt
> and all I could see was the SMP flag but no PREEMPT and no RT flag. So
> your problem is likely not RT-related.
>
> In addition, I found
> # grep Tainted messages.txt
> which gave a lot of "Tainted: P".
>
> Please refer to Documentation/oops-tracing.txt in the kernel tree
> (towards the end of the file). As you can see, "P" means that a
> proprietary module was loaded. Please understand that the community
> cannot assist you. You may try to contact the vendor for support or use
> a community driver and check whether the problem persists.

I've checked : indeed  only the 2.6.35-generic appears, whichis the kernel of the pc that i'm using to watch the laptop under testing (and yes i have proprietary driver on it); in other terms, i didn't manage to have a working connection with the pc under testing; i'll  search to have it working and then post it the log message , after i have verified that the right kernel appears in the file, if you agree of course; i'm sorry for the trouble; all of this is brand new to me.

>
> -Carsten.

thank you for your kind help

Victor
 		 	   		  