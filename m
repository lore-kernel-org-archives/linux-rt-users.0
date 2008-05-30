From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Breaking out of pthread_mutex_lock
Date: Fri, 30 May 2008 14:57:13 +0000
Message-ID: <1212159433.14713.104.camel@Aeon>
References: <1212104515.14713.96.camel@Aeon>
	 <20080529164650.4d1be605@extreme>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Stephen Hemminger <shemminger@vyatta.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34606 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbYE3O5k (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 May 2008 10:57:40 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4UEvc3C022407
	for <linux-rt-users@vger.kernel.org>; Fri, 30 May 2008 10:57:38 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m4UEvCrt094724
	for <linux-rt-users@vger.kernel.org>; Fri, 30 May 2008 10:57:12 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m4UEvC94013886
	for <linux-rt-users@vger.kernel.org>; Fri, 30 May 2008 10:57:12 -0400
In-Reply-To: <20080529164650.4d1be605@extreme>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2008-05-29 at 16:46 -0700, Stephen Hemminger wrote:
> On Thu, 29 May 2008 23:41:55 +0000
> Darren Hart <dvhltc@us.ibm.com> wrote:
> 
> > I find I need to be able to break out of the blocked state while waiting
> > to acquire a pthread_mutex.  I'm using PI mutexes and want to continue
> > to do so.  As I understand it, I can't use a signal to break out of the
> > lock as the man pages states:
> > 
> > "If a signal is delivered to a thread waiting for a mutex,  upon  return
> > from  the  signal handler the thread shall resume waiting for the mutex
> > as if it was not interrupted."
> > 
> > and that pthread_mutex_lock will not return EINTR.  I had considered
> > using cond variables, but I don't think they will provide the same PI
> > behavior (since the threads are not blocked on the mutex while awaiting
> > the pthread_cond_signal - right?).
> > 
> > I'm sure I'm not the first to want to do this, does anyone know of a
> > common best practice for accomplishing such a thing?
> > 
> 
> setjmp/longjmp?

Stephen,

Hrmm... I confess to not having made use of them before.  I read up a
bit, and don't see right off how they would help in this situation.  I
assume you're suggesting the longjmp be used in a signal handler while
the thread is blocked on the mutex - where would it jump to, and how
would I ensure the integrity of the pthread_mutex structure (which
thinks my thread is waiting for it) ?

-- 
Darren Hart
Real-Time Linux Team
IBM Linux Technology Center

