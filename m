From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: cyclictest - trouble explaning results
Date: Wed, 11 Jun 2008 14:33:31 -0300
Message-ID: <20080611173331.GG12756@unix.sh>
References: <20080611151437.234900@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Oleg Galimov <Galimov@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sr05-03.mta.terra.com.br ([200.154.152.62]:46119 "EHLO
	sr05-03.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbYFKReW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jun 2008 13:34:22 -0400
Content-Disposition: inline
In-Reply-To: <20080611151437.234900@gmx.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jun 11, 2008 at 05:14:37PM +0200, Oleg Galimov wrote:
| Hello all,
| 
| I use cyclictest as a benchmark for my diploma thesis. I have a strange
| behavior however, which I can't explain:
| 
| I have a dual-core cpu. When I run cyclictest on both cores and then
| start a time hog (like cp /dev/zero /dev/null), then the average latency on
| the core where it runs goes down significantly (on my machine it is like
| 30us before and 10us after, when using rt-patch). It returns to the
| original values, when I kill the cp process.

Are you using cpufreq or a similar tool?

Cyclictest is not CPU nor I/O intensive and depending on your settings for
cpufreq, it may influence the results. Another good test is, along with
disabling cpufreq, booting with idle=poll.

Luis

| I have a similar behavior but less clearly visible with interbench.
| 
| The results appeared so far on 2.6.22, 2.6.22+rt, 2.6.25 and 2.6.25+rt.
| 
| I hope someone can help me explaining this.
| 
| Thank you,
| 
| Oleg Galimov
| --
| To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

