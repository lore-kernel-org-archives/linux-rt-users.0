From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Subject: RE: Kernel versus patch version
Date: Sat, 27 Feb 2016 13:48:41 +0000
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA3C43F3@tethys>
References: <AF04265A3FC2B144B9892F621A394E13EA3C436A@tethys>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "otavio.salvador@ossystems.com.br" <otavio.salvador@ossystems.com.br>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:45350 "EHLO
	dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756332AbcB0NtU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 08:49:20 -0500
In-Reply-To: <AF04265A3FC2B144B9892F621A394E13EA3C436A@tethys>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi friends,

I'm trying to understand how to fit a kernel version with a RT patch. 

In summary, I'm working with a kernel version of 3.14.52 (released by Freescale for the iMX6 family) and I'm not sure about the criteria to choose the RT patch version. 

The WIKI [1] mention that we need to make sure that the RT-Preempt version fits the kernel version we intend to use. For example, if we have a kernel version 3.x.y (without z or security or bug fixes), the RT path must be "patches-3.x.y-rtxx", where xx is the RT patch release. 

The RT patch repository [2] doesn't contain a release that fit the 3.14.52 kernel.

Considering this context, I have a some questions:

- Which revision could be more convenient for the 3.14.52 kernel?
- Can I use a different RT patch release that differ on the .y number (3.x.y)? 
- Must I need to patch the kernel to 3.14.61 and use the latest RT patch release by Steve [3] some days ago? 

Thanks for your help and appreciated your feedback,

Julio 

[1] RT PREEMPT HOWTO: https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO 
[2] RT Patch repository: https://www.kernel.org/pub/linux/kernel/projects/rt/3.14/
[3] [ANNOUNCE] 3.14.61-rt62 http://www.spinics.net/lists/linux-rt-users/msg14623.html




