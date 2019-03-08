Return-Path: <SRS0=UNtE=RL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D3C43381
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Mar 2019 06:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F0D20684
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Mar 2019 06:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfCHGbJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:31:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfCHGbJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Mar 2019 01:31:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5862FE6A75;
        Fri,  8 Mar 2019 06:31:09 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E9705D719;
        Fri,  8 Mar 2019 06:31:09 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id F026B3FB10;
        Fri,  8 Mar 2019 06:31:08 +0000 (UTC)
Date:   Fri, 8 Mar 2019 01:31:08 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Yongxin Liu <yongxin.liu@windriver.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        dan j williams <dan.j.williams@intel.com>,
        paul gortmaker <paul.gortmaker@windriver.com>,
        linux-nvdimm@lists.01.org
Message-ID: <1859347572.10599669.1552026668860.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190306095709.23138-1-yongxin.liu@windriver.com>
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
Subject: Re: [PATCH RT] nvdimm: make lane acquirement RT aware
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.134, 10.4.195.22]
Thread-Topic: nvdimm: make lane acquirement RT aware
Thread-Index: 4ghs9+nDfy/dsrzSA79Oy7bSbkhtAA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 08 Mar 2019 06:31:09 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


> Currently, nvdimm driver isn't RT compatible.
> nd_region_acquire_lane() disables preemption with get_cpu() which
> causes "scheduling while atomic" spews on RT, when using fio to test
> pmem as block device.
> 
> In this change, we replace get_cpu/put_cpu with local_lock_cpu/
> local_unlock_cpu, and introduce per CPU variable "ndl_local_lock".
> Due to preemption on RT, this lock can avoid race condition for the
> same lane on the same CPU. When CPU number is greater than the lane
> number, lane can be shared among CPUs. "ndl_lock->lock" is used to
> protect the lane in this situation.
> 
> This patch is derived from Dan Williams and Pankaj Gupta's proposal from
> https://www.mail-archive.com/linux-nvdimm@lists.01.org/msg13359.html
> and https://www.spinics.net/lists/linux-rt-users/msg20280.html.
> Many thanks to them.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Pankaj Gupta <pagupta@redhat.com>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
> Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>

This patch looks good to me.

Acked-by: Pankaj Gupta <pagupta@redhat.com>

> ---
>  drivers/nvdimm/region_devs.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index fa37afcd43ff..6c5388cf2477 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -18,9 +18,13 @@
>  #include <linux/sort.h>
>  #include <linux/io.h>
>  #include <linux/nd.h>
> +#include <linux/locallock.h>
>  #include "nd-core.h"
>  #include "nd.h"
>  
> +/* lock for tasks on the same CPU to sequence the access to the lane */
> +static DEFINE_LOCAL_IRQ_LOCK(ndl_local_lock);
> +
>  /*
>   * For readq() and writeq() on 32-bit builds, the hi-lo, lo-hi order is
>   * irrelevant.
> @@ -935,18 +939,15 @@ int nd_blk_region_init(struct nd_region *nd_region)
>  unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
>  {
>  	unsigned int cpu, lane;
> +	struct nd_percpu_lane *ndl_lock, *ndl_count;
>  
> -	cpu = get_cpu();
> -	if (nd_region->num_lanes < nr_cpu_ids) {
> -		struct nd_percpu_lane *ndl_lock, *ndl_count;
> +	cpu = local_lock_cpu(ndl_local_lock);
>  
> -		lane = cpu % nd_region->num_lanes;
> -		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
> -		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
> -		if (ndl_count->count++ == 0)
> -			spin_lock(&ndl_lock->lock);
> -	} else
> -		lane = cpu;
> +	lane = cpu % nd_region->num_lanes;
> +	ndl_count = per_cpu_ptr(nd_region->lane, cpu);
> +	ndl_lock = per_cpu_ptr(nd_region->lane, lane);
> +	if (ndl_count->count++ == 0)
> +		spin_lock(&ndl_lock->lock);
>  
>  	return lane;
>  }
> @@ -954,17 +955,14 @@ EXPORT_SYMBOL(nd_region_acquire_lane);
>  
>  void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
>  {
> -	if (nd_region->num_lanes < nr_cpu_ids) {
> -		unsigned int cpu = get_cpu();
> -		struct nd_percpu_lane *ndl_lock, *ndl_count;
> -
> -		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
> -		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
> -		if (--ndl_count->count == 0)
> -			spin_unlock(&ndl_lock->lock);
> -		put_cpu();
> -	}
> -	put_cpu();
> +	struct nd_percpu_lane *ndl_lock, *ndl_count;
> +	unsigned int cpu = smp_processor_id();
> +
> +	ndl_count = per_cpu_ptr(nd_region->lane, cpu);
> +	ndl_lock = per_cpu_ptr(nd_region->lane, lane);
> +	if (--ndl_count->count == 0)
> +		spin_unlock(&ndl_lock->lock);
> +	local_unlock_cpu(ndl_local_lock);
>  }
>  EXPORT_SYMBOL(nd_region_release_lane);
>  
> --
> 2.14.4
> 
> 
