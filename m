From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: Breaking out of pthread_mutex_lock
Date: Thu, 29 May 2008 16:46:50 -0700
Message-ID: <20080529164650.4d1be605@extreme>
References: <1212104515.14713.96.camel@Aeon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.vyatta.com ([216.93.170.194]:46156 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822AbYE2Xq5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 May 2008 19:46:57 -0400
In-Reply-To: <1212104515.14713.96.camel@Aeon>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 29 May 2008 23:41:55 +0000
Darren Hart <dvhltc@us.ibm.com> wrote:

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

setjmp/longjmp?
