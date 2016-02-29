From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: AW: AW: Large latencies with 4.4.1-rt6
Date: Mon, 29 Feb 2016 22:05:53 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602292204380.3638@nanos>
References: <1A2AF5F768264E479963C4D8C015EB691B692C5C@dlrexmbx03.intra.dlr.de> <20160225152930.GC16161@linutronix.de> <1A2AF5F768264E479963C4D8C015EB691B6974A2@dlrexmbx03.intra.dlr.de> <56CF2BCD.3050109@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB691B69F0A3@DLREXMBX01.intra.dlr.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1532921459-1456779953=:3638"
Cc: bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
To: Martin.Wirth@dlr.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42621 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbcB2VHO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 16:07:14 -0500
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB691B69F0A3@DLREXMBX01.intra.dlr.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1532921459-1456779953=:3638
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 29 Feb 2016, Martin.Wirth@dlr.de wrote:
> I tested a bunch of kernels today and the outcome is:
> 
> 4.4.0-rt2:   good
> 4.4.0-rt3:   good
> 4.4.1-rt4:   good
> 4.4.1-rt5:   bad
> 4.4.1-rt6:   bad
> 4.4.2-rt7:   bad
> 4.4.3-rt9:   bad
> 4.4.3-rt9 with commit b3b36ee61c780407737a321007a24cfe9c3668a7 reverted:   good
> 
> (good means max cyclictest latencies < 25 µs,  bad means latencies > 500 µs)
> 
> I'm not a kernel developer, so I have not the slightest clue if the revert
> makes sense or only is plastering over the real problem.

The latter :)

Can you please send me your .config and tell me your cyclictes command line ?

Thanks,

	tglx
--8323329-1532921459-1456779953=:3638--
