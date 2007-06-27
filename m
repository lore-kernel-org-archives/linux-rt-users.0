From: Ingo Molnar <mingo@elte.hu>
Subject: Re: poison_obj latency
Date: Wed, 27 Jun 2007 14:34:35 +0200
Message-ID: <20070627123435.GA24977@elte.hu>
References: <200706271251.58092.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Manfred Gruber <m.gruber@tirol.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:53537 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703AbXF0Mep (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2007 08:34:45 -0400
Content-Disposition: inline
In-Reply-To: <200706271251.58092.m.gruber@tirol.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Manfred Gruber <m.gruber@tirol.com> wrote:

> hi !
> 
> I use a arm4vt ep93xx processor with 2.6.21.5-rt18. 
> When i run cyclictest with -i 10000 and -n -p 90 -b 1000 i see some strange 
> latencies in poison_obj.

disable SLAB_DEBUG. And look into your 'dmesg' output, the -rt kernel 
will warn about any other kernel config options as well that are known 
to cause large latencies:

VFS: Mounted root (ext3 filesystem) readonly.
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging option is turned on in your .config:   *
*                                                                           *
*        CONFIG_SLAB                                                        *
*                                                                           *
*  it may increase runtime overhead and latencies.                          *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 324k freed

	Ingo
