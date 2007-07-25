From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 15:05:36 +0200
Message-ID: <20070725130536.GA12334@elte.hu>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu>
	<46A4B7C2.1070304@free.fr> <20070723160442.GA7995@elte.hu>
	<46A5B8E3.4060004@free.fr> <46A74A58.1070704@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <46A74A58.1070704@free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Sender: oprofile-list-bounces@lists.sourceforge.net
Errors-To: oprofile-list-bounces@lists.sourceforge.net
List-Id: linux-rt-users.vger.kernel.org


* John Sigler <linux.kernel@free.fr> wrote:

> >With a pair of the following in the middle:
> >
> >softirq--4     0....  670us : call_rcu (rt_run_flush)
> >softirq--4     0D..1  670us : __rcu_advance_callbacks (call_rcu)

> Any idea what went wrong in the above function trace? Why is the 
> kernel spinning in circles that way?

does your test-app have higher priority than softirq--4 ?

	Ingo

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
