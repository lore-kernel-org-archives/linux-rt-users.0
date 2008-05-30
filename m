From: Gilles Carry <Gilles.Carry@bull.net>
Subject: Re: Breaking out of pthread_mutex_lock
Date: Fri, 30 May 2008 10:58:24 +0200
Message-ID: <483FC1B0.30702@bull.net>
References: <1212104515.14713.96.camel@Aeon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:50890 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYE3I6v (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 May 2008 04:58:51 -0400
In-Reply-To: <1212104515.14713.96.camel@Aeon>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Darren,

In futex_lock_pi(futex.c) when ERESTARTNOINTR which make the syscall to 
be reexecuted whatever comes after the sighandler ends.

One trick you can try (I've not tested it!) is use 
pthread_timedlock(mutex, abstime) and in sighandler, set abstime values 
to cause timeout. Since futex_lock_pi reads the time struct at each 
call, it will exit on timeout at reexecution.
Worth trying.

Gilles.

Darren Hart wrote:
> I find I need to be able to break out of the blocked state while waiting
> to acquire a pthread_mutex.  I'm using PI mutexes and want to continue
> to do so.  As I understand it, I can't use a signal to break out of the
> lock as the man pages states:
> 
> "If a signal is delivered to a thread waiting for a mutex,  upon  return
> from  the  signal handler the thread shall resume waiting for the mutex
> as if it was not interrupted."
> 
> and that pthread_mutex_lock will not return EINTR.  I had considered
> using cond variables, but I don't think they will provide the same PI
> behavior (since the threads are not blocked on the mutex while awaiting
> the pthread_cond_signal - right?).
> 
> I'm sure I'm not the first to want to do this, does anyone know of a
> common best practice for accomplishing such a thing?
> 

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Gilles.Carry
Linux Project team
mailto: gilles.carry@bull.net
Phone: +33 (0)4 76 29 74 27
Addr.: BULL S.A.  1 rue de Provence, B.P. 208 38432 Echirolles Cedex
http://www.bull.com
http://www.bullopensource.org/
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
