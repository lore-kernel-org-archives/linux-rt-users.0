From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rt-tests][PATCH] align thread wakeup times
Date: Fri, 04 Oct 2013 18:35:29 +0200
Message-ID: <524EEE51.7000107@linutronix.de>
References: <20130909072948.GA1967@opentech.at> <20131004132207.GF19953@linutronix.de> <20131004133325.GB26223@opentech.at> <524ED838.2060500@linutronix.de> <20131004162139.GD9752@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org,
	C.Emde@osadl.org, tglx@linutronix.de, andi@opentech.at
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55062 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab3JDQff (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 12:35:35 -0400
In-Reply-To: <20131004162139.GD9752@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/04/2013 06:21 PM, Nicholas Mc Guire wrote:
> no why should you - you might want
>  
> -i 100 -d 50 -A 20
> 
> T1 0     100     200     300
> T2  20         170
> T3   40              240
> T4    60                   310
> 
> Which is quite a lot different than just stating
> 
> that i_1=100 i_2=150, etc... but initial distance "undefined" or random
> 
> so in the sense of schedulability tests these are really two seperate
> parameters and thus should be configurable independently.
> 
> That the current documentation might give the impression that they are
> in sync is a bug in the documentation not in the -d implementation.

Now, I get it. Okay, so this makes sense.

> hofrat
>  
> 

Sebastian
