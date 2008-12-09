From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH] [RT] avoid preemption in memory controller code
Date: Tue, 9 Dec 2008 10:32:31 +0900
Message-ID: <20081209103231.ba6b3a39.kamezawa.hiroyu@jp.fujitsu.com>
References: <1228746854-23875-1-git-send-email-tim@klingt.org>
	<493DC628.5060900@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tim Blechmann <tim@klingt.org>, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
To: Li Zefan <lizf@cn.fujitsu.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:49360 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbYLIBd1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Dec 2008 20:33:27 -0500
In-Reply-To: <493DC628.5060900@cn.fujitsu.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 09 Dec 2008 09:13:12 +0800
Li Zefan <lizf@cn.fujitsu.com> wrote:

> CC: Balbir Singh <balbir@linux.vnet.ibm.com>
> CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> Tim Blechmann wrote:
> > the lru_lock of struct mem_group_per_zone is used to avoid preemption
> > during the __mem_cgroup_stat_add_safe function.
> > therefore, a raw_spinlock_t should be used.
> > 
> 
> FYI, this lru_lock no longer exists in -mm tree. The following patch
> removes that lock:
> 
> 	http://marc.info/?l=linux-mm&m=122665814801979&w=2
> 
> > Signed-off-by: Tim Blechmann <tim@klingt.org>
> > ---
> >  mm/memcontrol.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 517f945..8661732 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -95,9 +95,9 @@ enum mem_cgroup_zstat_index {
> >  
> >  struct mem_cgroup_per_zone {
> >  	/*
> > -	 * spin_lock to protect the per cgroup LRU
> > +	 * raw_spin_lock to protect the per cgroup LRU
> >  	 */
> > -	spinlock_t		lru_lock;
> > +	raw_spinlock_t		lru_lock;
> >  	struct list_head	active_list;
> >  	struct list_head	inactive_list;
> >  	unsigned long count[NR_MEM_CGROUP_ZSTAT];

yes..I remvoed that. Please see mmotm and subscribe linux-mm, 
if you have interests  memory resource controller.

Anyway, thanks.

-Kame

