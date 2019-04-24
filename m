Return-Path: <SRS0=e0E4=S2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08673C10F11
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Apr 2019 20:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0AA218D3
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Apr 2019 20:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfDXUH1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:07:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730519AbfDXUH1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Apr 2019 16:07:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6C0542BCD;
        Wed, 24 Apr 2019 20:07:26 +0000 (UTC)
Received: from ovpn-117-112.phx2.redhat.com (ovpn-117-112.phx2.redhat.com [10.3.117.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 689485D9C8;
        Wed, 24 Apr 2019 20:07:26 +0000 (UTC)
Message-ID: <1a771e7bfe8f7cc296809307cc75372c7cec42be.camel@redhat.com>
Subject: Re: [PATCH] printk: kmsg_dump: remove mutex usage
From:   Scott Wood <swood@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Date:   Wed, 24 Apr 2019 15:07:25 -0500
In-Reply-To: <87pnpb79nv.fsf@linutronix.de>
References: <91d59e3f2074265c834b9a7ea48a7b41292fc9f8.camel@redhat.com>
         <87pnpb79nv.fsf@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 24 Apr 2019 20:07:26 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2019-04-24 at 16:36 +0200, John Ogness wrote:
> @@ -2830,16 +2829,18 @@ void kmsg_dump(enum kmsg_dump_reason reason)
>  		if (dumper->max_reason && reason > dumper->max_reason)
>  			continue;
>  
> -		/* initialize iterator with data about the stored records */
> -		dumper->active = true;
> +		/*
> +		 * use a local copy to avoid modifying the
> +		 * iterator used by any other cpus/contexts
> +		 */
> +		memcpy(&dumper_local, dumper, sizeof(dumper_local));
>  
> -		kmsg_dump_rewind(dumper);
> +		/* initialize iterator with data about the stored records */
> +		dumper_local.active = true;
> +		kmsg_dump_rewind(&dumper_local);
>  
>  		/* invoke dumper which will iterate over records */
> -		dumper->dump(dumper, reason);
> -
> -		/* reset iterator */
> -		dumper->active = false;
> +		dumper_local.dump(&dumper_local, reason);
>  	}

When would a dumper (or anything else that checks it) ever see active be
false?

>  	rcu_read_unlock();
>  }
> @@ -2951,9 +2952,7 @@ bool kmsg_dump_get_line(struct kmsg_dumper *dumper,
> bool syslog,
>  {
>  	bool ret;
>  
> -	mutex_lock(&kmsg_dump_lock);
>  	ret = kmsg_dump_get_line_nolock(dumper, syslog, line, size, len);
> -	mutex_unlock(&kmsg_dump_lock);
>  
>  	return ret;
>  }
> @@ -3105,9 +3104,7 @@ void kmsg_dump_rewind_nolock(struct kmsg_dumper
> *dumper)
>   */
>  void kmsg_dump_rewind(struct kmsg_dumper *dumper)
>  {
> -	mutex_lock(&kmsg_dump_lock);
>  	kmsg_dump_rewind_nolock(dumper);
> -	mutex_unlock(&kmsg_dump_lock);
>  }
>  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>  

Any reason not to get rid of the wrappers now that the lock's gone?

-Scott


