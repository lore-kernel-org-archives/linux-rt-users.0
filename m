From: Clark Williams <williams@redhat.com>
Subject: Re: 1us latency?
Date: Mon, 3 Aug 2015 11:44:22 -0500
Message-ID: <20150803114422.0efbea1b@sluggy>
References: <55BF4CD7.8000007@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: pavel <pavel@pavlinux.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52195 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbbHCQoZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Aug 2015 12:44:25 -0400
In-Reply-To: <55BF4CD7.8000007@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 3 Aug 2015 14:13:27 +0300
pavel <pavel@pavlinux.ru> wrote:

> # ./cyclictest -S -p fifo
> defaulting realtime priority to 9
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.00 0.03 0.05 1/218 4240
> 
> T: 0 ( 4174) P: 9 I:1000 C: 430806 Min:      1 Act:    1 Avg:    1 Max:      10
> T: 1 ( 4175) P: 9 I:1500 C: 287204 Min:      1 Act:    1 Avg:    1 Max:       6
> T: 2 ( 4176) P: 9 I:2000 C: 215403 Min:      1 Act:    2 Avg:    1 Max:      11
> T: 3 ( 4177) P: 9 I:2500 C: 172322 Min:      1 Act:    1 Avg:    1 Max:       9
> T: 4 ( 4178) P: 9 I:3000 C: 143602 Min:      1 Act:    1 Avg:    1 Max:      10
> T: 5 ( 4179) P: 9 I:3500 C: 123087 Min:      1 Act:    1 Avg:    1 Max:      11
> T: 6 ( 4180) P: 9 I:4000 C: 107701 Min:      1 Act:    1 Avg:    1 Max:      10
> T: 7 ( 4181) P: 9 I:4500 C: 108232 Min:      1 Act:    2 Avg:    1 Max:      11
> 
> 
> It possible? 1us latency?  o_O
> 
> kernel- 3.18.19-rt15
> cyclictest V 0.92
> Intel(R) Xeon(R) CPU E3-1246 v3 @ 3.50GHz
> MSI MS-7823/B85M-G43 (MS-7823), BIOS V3.14B3 06/23/2014
> --

No, your latency is 11us. Max latency is what we care about, not the
average. 
