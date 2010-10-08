From: walimis <walimisdev@gmail.com>
Subject: Re: Strange behaviour on MPC5200
Date: Fri, 8 Oct 2010 10:07:18 +0800
Message-ID: <20101008020718.GA14157@ubuntu.mshome.net>
References: <m2pqvmhxjp.fsf@ohwell.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Detlev Zundel <dzu@denx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58650 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab0JHCH0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Oct 2010 22:07:26 -0400
Received: by iwn6 with SMTP id 6so51929iwn.19
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Oct 2010 19:07:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2pqvmhxjp.fsf@ohwell.denx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Oct 07, 2010 at 04:44:58PM +0200, Detlev Zundel wrote:
>Hi,
>
>during tests with the rt-preempt kernel on PowerPC, I stumbled across
>this really weird phenomenon of cyclictest latencies > 30ms.  The test
>system is a TQM5200 supported mainline, so the complete kernel source is
>unmodified mainline + rt-patch.  The -00001 in the kernel revision is
>due to the fact that I commited the results of applying the respective
>rt-patch to my local git repo.
>
>To debug the problem, I turned the latency tracers on and started
>cyclictest with 'cyclictest -n -p80'.  This looks quite good, hackbench
>and the cache calibrator do not do much harm, _until_ I start to do a
>ping flood from outside.  Then within a few seconds the high latencies
>occur.  To test for a regression, I did the same test under
>2.6.33.7-rt29 and 2.6.31.12-rt21.  Both versions yield similar results.
did you try mpc5121ads board with cyclictest test?                                                                                  
I wonder whether it's about powerpc arch common issue or 5200 special                                                               
issue.                                                                                                                              
                                                                                                                                    
Thanks                                                                                                                              
walimis
>
>Attached are the trace outputs for those events (gziped as they are
>larger than 300KiB).  
>
>It looks like the scheduling goes completely wrong as there is even the
>idle task running before the runnable cyclictest gets scheduled in.  Can
>someone give me a hint on what may be wrong here?
>
>Thanks
>  Detlev
>
>--
>DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
>HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de



