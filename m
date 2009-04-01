From: John Kacur <jkacur@gmail.com>
Subject: Re: Real-time kernel compile-fix for 32-bit when disabling
	CONFIG_PREEMPT_RT
Date: Wed, 1 Apr 2009 10:51:02 +0200
Message-ID: <520f0cf10904010151q27683014t389a16da59427d9b@mail.gmail.com>
References: <bhm9a-75O-9@gated-at.bofh.it>
	 <f9ba8adc-60a4-43ba-b609-22e80ed984e1@p6g2000pre.googlegroups.com>
	 <520f0cf10903310339r41263cdat961ab40dc2565d9f@mail.gmail.com>
	 <a7a71e0d0904010136h360bf771o39b21614f033011e@mail.gmail.com>
	 <a7a71e0d0904010138r1a0bf6f5wa07c9d6cc770d3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Geoffrey Chien <geoffchien@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:29277 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbZDAI4h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Apr 2009 04:56:37 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3602729qwh.37
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Apr 2009 01:56:34 -0700 (PDT)
In-Reply-To: <a7a71e0d0904010138r1a0bf6f5wa07c9d6cc770d3f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/4/1 Geoffrey Chien <geoffchien@gmail.com>:
> Sorry, I accidentally hit the "send" button, I haven't typed my question
> yet,
> Yes, it worked now, but I have to enable "multi-core schedular support", and
> in the "preemption mode(complete preemption real time), I also have to do
> -->[X]Complete Preemption (Real Time)
>
> After doing the two things above, it worked,
> well, I'm wondering, if I disable "Complete Preemption(Real Time), Is it
> gonna make any differences?

Could you please reply to all so the people on the linux-rt-users list
can see your questions. Someone may know an answer to your questions
better than I do. Also, you're supposed to post under the other text
not above it. (I just snipped it out)
There really is no point to the rt patch if you disable complete
preemption, however, I suppose you should be able to so because
someday the rt-developers would like this integrated into the
mainstream linux kernel. So, I would suggest to you, that if you can
find a config that doesn't compile for you, please send it to the
list, and someone will generate a patch to make sure that either that
combination compiles, or is impossible to select.

Thanks

-----SNIP-----
