From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rt-tests][PATCH] align thread wakeup times
Date: Fri, 04 Oct 2013 17:01:12 +0200
Message-ID: <524ED838.2060500@linutronix.de>
References: <20130909072948.GA1967@opentech.at> <20131004132207.GF19953@linutronix.de> <20131004133325.GB26223@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org,
	C.Emde@osadl.org, tglx@linutronix.de, andi@opentech.at
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54470 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab3JDPBS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 11:01:18 -0400
In-Reply-To: <20131004133325.GB26223@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/04/2013 03:33 PM, Nicholas Mc Guire wrote:
>> I would rather fix current behaviour instead introducing yet another
>> option. By using -d0 I assume that all threads wakeup at the same time.
> 
> Nop they do not -d0 just says that they all use
> the same period rather than some offset with multiple threads (e.g. -S)
> 
>> According to your patch this does not happen due to the thread creating
>> / starting overhead.
>> Is there is a reason to keep this "faulty" behavior? If not I would vote
>> to make this what you suggest the default.
>>
> 
> its not faulty behavior - its a different case
> in fact we need both.
> 
> same period + "random" start time
> same period + synced start time
> 
> it makes a difference on some boxes that is significant.

So you say with -d0, where d is documented as "distance of thread
intervals in us", I should not expect that all threads share the exact
same wakeup time (because their distance is 0)?

> thx!
> hofrat
> 

Sebastian
