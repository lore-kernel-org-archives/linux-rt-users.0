From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 5/9] cyclictest: use correct type when allocating
 cpu bitmask size
Date: Wed, 16 Sep 2015 00:19:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509160019040.13077@riemann.fritz.box>
References: <cover.1441038216.git.joshc@ni.com> <d84777ffa73511c9343c2ebc71573f56a788e743.1441038216.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36837 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbIOWTr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2015 18:19:47 -0400
Received: by wicgb1 with SMTP id gb1so48556416wic.1
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2015 15:19:46 -0700 (PDT)
In-Reply-To: <d84777ffa73511c9343c2ebc71573f56a788e743.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 31 Aug 2015, Josh Cartwright wrote:

> On any sane platform sizeof(long) == sizeof(unsigned long), so this
> does not actually fix a real bug, but the code should at least be
> consistent.
> 
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  src/cyclictest/rt_numa.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> index caa80e6..9da9fd8 100644
> --- a/src/cyclictest/rt_numa.h
> +++ b/src/cyclictest/rt_numa.h
> @@ -229,7 +229,7 @@ static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
>  			 * max_cpus bits */
>  			int nlongs = (max_cpus+BITS_PER_LONG-1)/BITS_PER_LONG;
>  
> -			mask->maskp = calloc(nlongs, sizeof(long));
> +			mask->maskp = calloc(nlongs, sizeof(unsigned long));
>  			if (mask->maskp) {
>  				mask->maskp[cpu/BITS_PER_LONG] |=
>  					(1UL << (cpu % BITS_PER_LONG));
> -- 
> 2.5.0
> 
> --

Suspect this isn't the only inconsistency here between longs and unsigned 
longs, but
Signed-off-by: John Kacur <jkacur@redhat.com>
