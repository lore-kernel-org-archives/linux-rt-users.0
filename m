From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH RFC 3/9] RCU: Preemptible RCU
Date: Sun, 30 Sep 2007 16:02:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709301549160.19355@alien.or.mcafeemobile.com>
References: <20070910183004.GA3299@linux.vnet.ibm.com>
 <20070910183412.GC3819@linux.vnet.ibm.com> <20070923173807.GA292@tv-sign.ru>
 <20070924001509.GG11123@linux.vnet.ibm.com> <20070926151351.GA328@tv-sign.ru>
 <20070927154652.GE16652@linux.vnet.ibm.com> <20070928144714.GA397@tv-sign.ru>
 <20070928185759.GC9153@linux.vnet.ibm.com> <20070930163102.GA374@tv-sign.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>, dipankar@in.ibm.com,
	josht@linux.vnet.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	tglx@linutronix.de, a.p.zijlstra@chello.nl, bunk@kernel.org,
	ego@in.ibm.com, srostedt@redhat.com
To: Oleg Nesterov <oleg@tv-sign.ru>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754326AbXI3XCX@vger.kernel.org>
In-Reply-To: <20070930163102.GA374@tv-sign.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 30 Sep 2007, Oleg Nesterov wrote:

> Ah, but I asked the different question. We must see CPU 1's stores by
> definition, but what about CPU 0's stores (which could be seen by CPU 1)?
> 
> Let's take a "real life" example,
> 
>                 A = B = X = 0;
>                 P = Q = &A;
> 
> CPU_0           CPU_1           CPU_2
> 
> P = &B;         *P = 1;         if (X) {
>                 wmb();                  rmb();
>                 X = 1;                  BUG_ON(*P != 1 && *Q != 1);
>                                 }
> 
> So, is it possible that CPU_1 sees P == &B, but CPU_2 sees P == &A ?

That can't be. CPU_2 sees X=1, that happened after (or same time at most - 
from a cache inv. POV) to *P=1, that must have happened after P=&B (in 
order for *P to assign B). So P=&B happened, from a pure time POV, before 
the rmb(), and the rmb() should guarantee that CPU_2 sees P=&B too.



- Davide
