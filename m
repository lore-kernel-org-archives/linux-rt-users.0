From: Stanislav Meduna <stano@meduna.org>
Subject: Re: malloc/free and priority inheritance?
Date: Thu, 04 Apr 2013 17:09:44 +0200
Message-ID: <515D97B8.5030101@meduna.org>
References: <515B647C.3080505@meduna.org> <515D7943.5000401@meduna.org> <515D808C.8090808@meduna.org> <CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: libc-help <libc-help@sourceware.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:57905 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761998Ab3DDPJy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Apr 2013 11:09:54 -0400
In-Reply-To: <CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04.04.2013 15:37, Siddhesh Poyarekar wrote:

> The generic C code was updated to use PI in current master (I don't
> remember if the arm support bits were added, but they must have been
> by now), so you could cherry-pick and backport those bits for your
> distro if you want.

Oh.. thanks for pointing out.

One more question: what exactly does lll_lock do? Is it priority
inheritance aware? It is difficult to follow all the macros
and assembler code, but as far as I can tell this ends
with calling FUTEX_WAIT.

The first thing e.g. the __pthread_cond_broadcast (and most of the
other functions as well) does is to grab lll_lock. Is the following
scenario possible?

- a low priority thread does the broadcast and gets the lock
- a medium priority thread unrelated to this condition variable
  gets scheduled and preempts the low priority one right
  after returning from lll_lock
- a high priority thread gets scheduled and wants to do
  the broadcast on this variable too
- it finds the lock held and blocks. The medium priority thread
  gets scheduled again

Now we have a classical priority inversion.

>From all that I can read it is not mandatory that the
pthread_cond_broadcast or signal is being called with the mutex
held and I think there could be more variants of this anyway.

Thanks
-- 
                                          Stano

