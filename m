From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Process Hang in __read_seqcount_begin
Date: Fri, 26 Oct 2012 22:53:04 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210262252390.2756@ionos>
References: <CAN8Q1EdobyFuAvtajGRSqNsCG+XoPA+FkwN=2j_H126mmfEjTQ@mail.gmail.com> <1350925299.8609.978.camel@edumazet-glaptop> <CAN8Q1EeqmHMHD-VUgr7Wzv0Z_DAD1SrEniftg==L14d+hGwu+Q@mail.gmail.com> <CAN8Q1EcTRsHjCJD90q0bKRJFMvi7Vn8YRsyQTAHNtTFVuuNdWQ@mail.gmail.com>
 <CAN8Q1EeB2kC6A_YP9zdtp_qYHMG5FF7-Usjx7Rz5pv--bjhqkQ@mail.gmail.com> <1351053164.6537.95.camel@edumazet-glaptop> <CAN8Q1Ef9sCAG8-KNWXEeuRUcmFNcg93mMG=HRQw6i3UuGtJCVg@mail.gmail.com> <1351270087.30380.9.camel@edumazet-glaptop>
 <CAN8Q1Ed1J-jmO9LppcA=rFXPvxFkk-J9mMb2-NhDYyAQKO2jvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	netfilter@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <netfilter-owner@vger.kernel.org>
In-Reply-To: <CAN8Q1Ed1J-jmO9LppcA=rFXPvxFkk-J9mMb2-NhDYyAQKO2jvQ@mail.gmail.com>
Sender: netfilter-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 26 Oct 2012, Peter LaDow wrote:
> (I've added netfilter and linux-rt-users to try to pull in more help).
> 
> On Fri, Oct 26, 2012 at 9:48 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > Upstream kernel is fine, there is no race, as long as :
> >
> > local_bh_disable() disables BH and preemption.
> 
> Looking at the unpatched code in net/ipv4/netfilter/ip_tables.c, it
> doesn't appear that any of the code checks the return value for
> xt_write_receq_begin to determine if it is safe to write.  And neither
> does the newly patched code.  How did the mainline code prevent
> corruption of the tables it is updating?
> 
> Why isn't there something like:
> 
>   while ( (addend = xt_write_recseq_begin()) == 0 );
> 
> To make sure that only one person has write access to the tables?
> Better yet, why not use a seqlock_t instead?
> 
> > Apparently RT changes this, so RT needs to change the code.
> 
> The RT patch only touches local_bh_disable/enable, not the code in
> ip_tables.c.  Does the local_bh_disable/enable in the mainline code
> protect against multiple writers?
> 
> > cmpxchg() has strong guarantees (and is also slower than upstream code),
> > and seems a reasonable way to fix RT/iptables
> 
> I see this now.  And I agree that your patch would prevent corruption
> of the sequence counter.

Thanks for the reminder. I'll have a look.

       tglx
