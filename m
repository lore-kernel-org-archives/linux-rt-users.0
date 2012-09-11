From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: x86 question ...
Date: Tue, 11 Sep 2012 13:42:44 +0200
Message-ID: <504F23B4.3070003@xenomai.org>
References: <CAF-VNaqQC94rTrT9E=Dkp0f-NC0YyWXi2rWjsn3XOFMp+feJ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Lars Segerlund <lars.segerlund@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xenomai.org ([88.191.95.136]:45973 "EHLO xenomai.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143Ab2IKMCL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 08:02:11 -0400
In-Reply-To: <CAF-VNaqQC94rTrT9E=Dkp0f-NC0YyWXi2rWjsn3XOFMp+feJ9w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/11/2012 12:55 AM, Lars Segerlund wrote:

>  I read that on arm there was a set of patches for using a single
> virtual adress space, ( ie. all processes live in the same mapping so
> to speak , but still protected ), which greatly reduced context
> switching time on that platform, does anyone know if the same would be
> true for x86 ( maily x86_64 ).


If the patch you are talking about is the FCSE patch, no, it will not
work for x86:
- the FCSE patch allows avoiding to flush the cache at every context
switch on armv4 and armv5, because their cache architecture (VIVT)
requires this cache flush otherwise, but x86 have a PIPT cache, so, no
cache flush is needed during the context switches;
- the FCSE patch requires hardware support, the FCSE (Fast Context
Switch Extension) pid register, despite the fact that every process
lives in a separate 32MiB slice below the 3GB limit, its address-space
appears to be [0;32MiB[, this allows "fork" to work; x86, as far as I
know, has no such hardware.

The advantage compared to uCLinux is that you still have memory
protection, but the performances are probably a bit worse because the
TLB is still invalidated at every context switch. So, these are
different trade-off.

-- 
                                                                Gilles.
