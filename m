From: Robert Johnson <rjohnson@sierraphotonics.com>
Subject: PowerPC PPC32 CONFIG_HIGHMEM dependency question
Date: Mon, 17 Mar 2014 17:41:25 +0000
Message-ID: <d23eabd04d35481db8b483f9630341fd@SPIEXCHMAIL01.sierraphotonics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 66-162-147-187.static.twtelecom.net ([66.162.147.187]:51135
	"EHLO spibarracuda01.sierraphotonics.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757101AbaCQRlM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Mar 2014 13:41:12 -0400
Received: from SPIEXCHMAIL01.sierraphotonics.com ([192.168.10.45]) by spibarracuda01.sierraphotonics.com with ESMTP id Cy8J333o005Tecy9 for <linux-rt-users@vger.kernel.org>; Mon, 17 Mar 2014 10:41:11 -0700 (PDT)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I am using an embedded single board computer (SBC) that has a Freescale P2020 processor.  The vendor board support package (BSP) for this product currently uses a 3.0.4 Linux kernel.  In looking through the RT patch for various Linux kernel versions even up through 3.12.13-rt21, I see that CONFIG_HIGHMEM is not allowed if CONFIG_PREEMPT_RT_FULL is selected (see arch/powerpc/Kconfig).

The result for my SBC is that if I enable CONFIG_PREEMPT_RT_FULL in the kernel, I am then only able to access 1GB of RAM instead of the 4GB that is resident.

Is there any way to get CONFIG_PREEMPT_RT_FULL to work with CONFIG_HIGHMEM?

If I want to use CONFIG_HIGHMEM, should I consider the use of CONFIG_PREEMPT_RTB which does not appear to have a dependency?
