From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: Triggering UserCode from KernelModule (IRQ)
Date: Wed, 22 Apr 2009 07:36:50 -0700
Message-ID: <1240411010.7763.11.camel@desktop>
References: <6669682.1240409688443.JavaMail.ngmail@webmail19.ha2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fifo99.com ([67.223.236.141]:44289 "EHLO fifo99.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbZDVOqI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Apr 2009 10:46:08 -0400
In-Reply-To: <6669682.1240409688443.JavaMail.ngmail@webmail19.ha2.local>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2009-04-22 at 16:14 +0200, M. Koehrer wrote:
> Hi all!
> 
> I am currently evaluting the RT_PREEMPT kernel as a replacement for a Xenomai based real time application.
> (Intel Core2Duo PCs).
> So far, everything works really fine and the performance is about the same as with Xenomai.
> Great work!

I thought I saw something someplace about Xenomai supporting preempt_rt
as a real time layer. So you might not need to do much to your
application in order to switch ..

Daniel

