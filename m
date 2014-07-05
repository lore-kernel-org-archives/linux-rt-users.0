From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Sat, 5 Jul 2014 22:36:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407052233230.22031@nanos>
References: <537CFECF.9070701@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Austin Schuh <austin@peloton-tech.com>, xfs@oss.sgi.com
To: John Blackwood <john.blackwood@ccur.com>
Return-path: <xfs-bounces@oss.sgi.com>
In-Reply-To: <537CFECF.9070701@ccur.com>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
List-Id: linux-rt-users.vger.kernel.org

On Wed, 21 May 2014, John Blackwood wrote:
> I'm not 100% sure that the patch below will fix your problem, but we
> saw something that sounds pretty familiar to your issue involving the
> nvidia driver and the preempt-rt patch.  The nvidia driver uses the
> completion support to create their own driver's notion of an internally
> used semaphore.

And why should we care about that? If they abuse the completion code
then it's their problem. And it has nothing to do at all with the
problem Austin is observing.
 
> Some tasks were failing to ever wakeup from wait_for_completion() calls
> due to a race in the underlying do_wait_for_common() routine.

Why are you not fixing the nvidia crap instead of hacking utter shite
into the core kernel?

Thanks,

	tglx

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
