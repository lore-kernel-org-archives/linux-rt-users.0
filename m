Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEA19258A
	for <linux-rt-users@vger.kernel.org>; Tue, 29 Oct 2024 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240165; cv=none; b=KEO03HXeJvYkT4AudGToYq53QiwidJWycIfxKD/mHMe7krnR97uiuM0HNEl1FEPO9oDCDVuJjaC8AHamsQSdkmEAYy/ZPPl+q0Qxr+i3itZWyHmNJlON5ve/Dqdv3tA/et8GWNCvxDtrvrzLlcfZ2YZWSYY7hi7VeKHKmRx8IrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240165; c=relaxed/simple;
	bh=cQlFA2Mb1I6dgWU5eCr2E4xm48hx7/o+WEYkexwawMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXUxMlGXCVQejFZns96xmADjb/Xywtr0hIaQy7aeAh+0Ob0WD9htaGf6uQDWZ7xQyRUEKeSSkvppStAvpf/vvKBf92xDfdUscEj6KkzxTj7U+c3bMGzQtoB62R21TAGXVS18GzWyjq/yfElRtWziwPH/wK38v1Tt1G2P0rurnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5LYtbq7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5LYtbq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730240161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+087KhWkOO5rYWwkppyud4q93fDXCofZWuocbJXl4o=;
	b=N5LYtbq7ihFo7fvK8/ROdPCHr4GmyVlti+mqMYPoK1BAMIb1y8zbzNFh0lXZsqFwsU3WZE
	X1Dbv+wQFtKtOrE1fB/JDr+lw4eHg4eT1paVQhnVXGS0rE/PNhY+Hsoj12341cEcPtqGWH
	oGBMFsHiUU56bl486QmM5Klt24HYswQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-ioCM9GwlMWmYsO7rmtdTIw-1; Tue,
 29 Oct 2024 18:15:58 -0400
X-MC-Unique: ioCM9GwlMWmYsO7rmtdTIw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 308CB195609D;
	Tue, 29 Oct 2024 22:15:57 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.170])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 088DD19560AA;
	Tue, 29 Oct 2024 22:15:53 +0000 (UTC)
Date: Tue, 29 Oct 2024 19:15:52 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	linux-rt-users@vger.kernel.org, kernel-rts-sst <kernel-rts-sst@redhat.com>, 
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] pi_stress: Add memory barrier to resolve crash
Message-ID: <q4i6uhr7kg2gj4u5ghwkvemvvy73mggu7myirjm4uwndpra2mi@yicsw5d6p5tf>
References: <20241024162620.349934-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024162620.349934-1-jwyatt@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Oct 24, 2024 at 12:26:14PM -0400, John B. Wyatt IV wrote:
> This patch is also an error report seen on RHEL 9 and Fedora 40.
> pi_stress crashes if you run this near full cores with one core
> (2 threads) free for housekeeping. The crash usually happens at
> around 2 hours of pi_stress running. This issue was reproduced
> on a RHEL server with 2 sockets of 10 cores/20 threads (total 40
> threads) and a Fedora server with 2 sockets of 56 cores/112
> threads (total 226 threads).
> 
> The pthread_barrier_wait should guarantee that only one
> thread at a time interacts with the variables below that
> if block.
> 
> GCC -O2 optimization rearranges the two increments above the wait
> function calls. This causes a race issue found by Helgrind.
> You can prove this by commenting out the memory barrier
> and compiling with `-O0`. The crash does not happen with -O0.
> Thank you to Valentin Schneider <vschneid@redhat.com> for
> suggesting about -O2.
> 
> Add a memory barrier to force GCC to increment the variables
> below the pthread calls. The memory barrier prevented any crashes
> for several 24 hours tests. This function depends on C11.
> 
> Reported-by: Valgrind's Helgrind tool
> 
> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> ---
>  src/pi_tests/pi_stress.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 371e906..37023a1 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -44,6 +44,7 @@
>  #include <stdint.h>
>  #include <inttypes.h>
>  #include <limits.h>
> +#include <stdatomic.h>
>  
>  #include "rt-sched.h"
>  #include "rt-utils.h"
> @@ -952,12 +953,31 @@ void *high_priority(void *arg)
>  			    ("high_priority[%d]: pthread_barrier_wait(finish): %x", p->id, status);
>  			return NULL;
>  		}
> +
> +
> +		/**
> +		 * The pthread_barrier_wait should guarantee that only one
> +		 * thread at a time interacts with the variables below that
> +		 * if block.
> +		 *
> +		 * GCC -O2 rearranges the two increments above the wait
> +		 * function calls causing a race issue if you run this
> +		 * near full cores with one core (2 threads) free for
> +		 * housekeeping. This causes a crash at around 2 hour of
> +		 * running. You can prove this by commenting out the barrier
> +		 * and compiling with `-O0`. The crash does not show with
> +		 * -O0.
> +		 *
> +		 * Add a memory barrier to force GCC to increment the variables
> +		 * below the pthread calls. This funcion depends on C11.
> +		 **/

I agree with Crystal. AFAIU, the compiler should not reorder before
pthread_barrier_wait(). Something odd is going on here. However, I am
not familiar with the code base. What's the repo for this?

Btw, did you look at the generated assembly code?

> +		atomic_thread_fence(memory_order_seq_cst);
> +

If the problem is program order, a simple compiler barrier with acquire
semantics should work:

        atomic_signal_fence(memory_order_acquire);

>  		/* update the group stats */
>  		p->total++;
>  
>  		/* update the watchdog counter */
>  		p->watchdog++;
> -
>  	}
>  	set_shutdown_flag();
>  
> -- 
> 2.47.0
> 

