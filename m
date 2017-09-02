From: Mart van de Wege <mvdwege-O5WfVfzUwx8@public.gmane.org> (by way of Mart van de Wege
        <mvdwege-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>)
Subject: Re: Possible BT deadlock due to recursive read locking (Was: Re:
 kernel BUG at kernel/locking/rtmutex.c:1059)
Date: Sat, 2 Sep 2017 09:27:07 +0200
Message-ID: <20170902092707.1e8800bb@mail.com>
References: <86val4928u.fsf@gaheris.avalon.lan>
 <20170831145211.xlu6cvocqdkzevsl@linutronix.de>
 <20170901105107.753617a1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>,
        Johan Hedberg <johan.hedberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>,
        linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
        Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170901105107.753617a1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 1 Sep 2017 10:51:07 +0200
Mart van de Wege <mvdwege-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, 31 Aug 2017 16:52:12 +0200
> Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> 
> > On 2017-08-30 23:25:53 [+0200], Mart van de Wege wrote:  
> > > Hi,    
> > Hi,
> >   
> > > The issue persists up to v4.11.12-rt10    
> > Does
> > 	CONFIG_RWLOCK_RT_READER_BIASED=y
> > make it go away?
> >   
> Yes, that does make it go away. -rt8 now boots cleanly, and works
> fine. Building -rt10 now to be sure.
> 
Confirm that as of 4.11.12-rt11 the deadlock still goes away when
enabling CONFIG_RWLOCK_RT_READER_BIASED

Mart
