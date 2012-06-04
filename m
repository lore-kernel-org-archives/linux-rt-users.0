From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: file system bug
Date: Mon, 4 Jun 2012 15:26:25 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1206041525150.3086@ionos>
References: <4FC77A06.2090706@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, rtlinux@163.com,
	=?GB2312?B?0e7D8ce/?= <mqyoung@gmail.com>
To: Yang Honggang <eagle.rtlinux@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41407 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab2FDN02 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jun 2012 09:26:28 -0400
In-Reply-To: <4FC77A06.2090706@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 31 May 2012, Yang Honggang wrote:
> Hello,
> 
> There is no rt patch from 2.6.34  until 3.0. It said that the reason is that
> there
> is a serious file system bug which will cause file corruption.
> And the bug is fixed by Thomas until the version 2.6.38??
> 
> It will be very grateful if  some detail information about this bug can be
> given.

The bug was only visible with the changes RT did to that
code. Mainline papered over it somehow, but I forgot the details by
now.
