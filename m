From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH -rt] Revert "net: use synchronize_rcu_expedited()"
Date: Mon, 26 Oct 2015 17:44:22 -0700
Message-ID: <20151027004422.GH5105@linux.vnet.ibm.com>
References: <1445886895-3692-1-git-send-email-joshc@ni.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445886895-3692-1-git-send-email-joshc@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Oct 26, 2015 at 02:14:55PM -0500, Josh Cartwright wrote:
> This reverts commit be3fc413da9eb17cce0991f214ab019d16c88c41.
> 
> While the use of synchronize_rcu_expedited() might make
> synchronize_net() "faster", it does so at significant cost on RT
> systems, as expediting a grace period forcibly preempts any
> high-priority RT tasks (via the stop_machine() mechanism).
> 
> Without be3fc413da9e reverted, we can observe a latency spike up to 30us
> with cyclictest by rapidly unplugging/reestablishing an ethernet link.
> 
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Josh Cartwright <joshc@ni.com>

Hmmm...  If I remember correctly, using expedited here resulted
in impressive performance improvements in some important cases.
Perhaps things have changed (I must defer to Eric), but if not, how
about something like this instead?

	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREMPT_RT_FULL))
		synchronize_rcu_expedited();
	else
		synchronize_rcu();

Alternatively, a boot-time option could be used:

	if (rtnl_is_locked() && !some_rt_boot_parameter)
		synchronize_rcu_expedited();
	else
		synchronize_rcu();

I believe that the first alternative is better because it does the right
thing without user intervention.  The second would be preferred should
distros want to offer full RT by default, but I am guessing thta most
distros would be reluctant to do this for some time to come.

Either way, these approaches have the advantage of giving RT users the
latency they need, even in the face of networking configuration changes,
while giving non-RT users the required performance of the networking
configuration changes themselves.

							Thanx, Paul

> ---
>  net/core/dev.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f8c23de..869ef62 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6969,10 +6969,7 @@ EXPORT_SYMBOL(free_netdev);
>  void synchronize_net(void)
>  {
>  	might_sleep();
> -	if (rtnl_is_locked())
> -		synchronize_rcu_expedited();
> -	else
> -		synchronize_rcu();
> +	synchronize_rcu();
>  }
>  EXPORT_SYMBOL(synchronize_net);
> 
> -- 
> 2.5.1
> 
