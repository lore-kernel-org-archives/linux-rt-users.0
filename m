From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [4.4.4-rt11] Possiblie recursive locking detected in kswapd /
 mb_cache_shrink_scan()
Date: Mon, 21 Mar 2016 10:34:11 -0300
Message-ID: <20160321133411.GA29388@uudg.org>
References: <20160314210058.GE29798@uudg.org>
 <alpine.DEB.2.11.1603190933150.3978@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:32812 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468AbcCUNeQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Mar 2016 09:34:16 -0400
Received: by mail-qk0-f172.google.com with SMTP id s5so79024501qkd.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Mar 2016 06:34:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1603190933150.3978@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Mar 19, 2016 at 09:33:34AM +0100, Thomas Gleixner wrote:
| On Mon, 14 Mar 2016, Luis Claudio R. Goncalves wrote:
| 
| > Hello,
| > 
| > I just started using 4.4.4-rt11 this afternoon and saw the lockdep splat below.
| > Is this something new or did I miss a patch floating on the list?
| 
| That's new. Looking into it.

Thanks!

Please let me know if you want me to run any test or trace. I will be more
than glad on helping.

Luis
