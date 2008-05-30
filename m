From: Clark Williams <williams@redhat.com>
Subject: Re: Breaking out of pthread_mutex_lock
Date: Fri, 30 May 2008 10:24:04 -0500
Message-ID: <48401C14.703@redhat.com>
References: <1212104515.14713.96.camel@Aeon>	 <20080529164650.4d1be605@extreme> <1212159433.14713.104.camel@Aeon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stephen Hemminger <shemminger@vyatta.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48896 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbYE3Pa3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 May 2008 11:30:29 -0400
In-Reply-To: <1212159433.14713.104.camel@Aeon>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Darren Hart wrote:
> On Thu, 2008-05-29 at 16:46 -0700, Stephen Hemminger wrote:
>> On Thu, 29 May 2008 23:41:55 +0000
>> Darren Hart <dvhltc@us.ibm.com> wrote:
>>
>>> I find I need to be able to break out of the blocked state while waiting
>>> to acquire a pthread_mutex.  I'm using PI mutexes and want to continue
>>> to do so.  As I understand it, I can't use a signal to break out of the
>>> lock as the man pages states:
>>>
>>> "If a signal is delivered to a thread waiting for a mutex,  upon  return
>>> from  the  signal handler the thread shall resume waiting for the mutex
>>> as if it was not interrupted."
>>>
>>> and that pthread_mutex_lock will not return EINTR.  I had considered
>>> using cond variables, but I don't think they will provide the same PI
>>> behavior (since the threads are not blocked on the mutex while awaiting
>>> the pthread_cond_signal - right?).
>>>
>>> I'm sure I'm not the first to want to do this, does anyone know of a
>>> common best practice for accomplishing such a thing?
>>>
>> setjmp/longjmp?
> 
> Stephen,
> 
> Hrmm... I confess to not having made use of them before.  I read up a
> bit, and don't see right off how they would help in this situation.  I
> assume you're suggesting the longjmp be used in a signal handler while
> the thread is blocked on the mutex - where would it jump to, and how
> would I ensure the integrity of the pthread_mutex structure (which
> thinks my thread is waiting for it) ?
> 

I don't see any way to recover from longjmp'ing out of a pthread_mutex_lock(). Maybe
using robust futexes and killing the thread that was blocked?

I think it would be better to re-designed the code to use pthread_mutex_trylock()
instead, so it doesn't block. That way you don't have a mutex in some wacky state.

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhAHBQACgkQHyuj/+TTEp3dVgCeI8tNnbSDOLThVrUqjWcM9xPA
mVgAnjR2D4RxIBXAjC+S2jtCdTaB+1AD
=rmf4
-----END PGP SIGNATURE-----
