From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: 2.6.23.1-rt9 (and others)
Date: Wed, 07 Nov 2007 08:40:37 -0500
Message-ID: <47317A05.BA47.005A.0@novell.com>
References: <1194413959.8827.66.camel@localhost.localdomain>
 <4731C90E.7030509@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: "Dragan Noveski" <perodog@gmx.net>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:29687 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755098AbXKGNnc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2007 08:43:32 -0500
In-Reply-To: <4731C90E.7030509@gmx.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

>>> On Wed, Nov 7, 2007 at  9:17 AM, in message <4731C90E.7030509@gmx.net>, Dragan
Noveski <perodog@gmx.net> wrote: 

> hallo, i just tried to compile rt9 and rt7 and both times i get this 
> error at about the end of the 'make && make modules' step:
> 
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o: In function `sched_init':
> (.init.text+0x1af): undefined reference to `cpupri_init'
> make: *** [.tmp_vmlinux1] Fehler 1
> 
> 
> i am on uniprozessor machine here, IBM-thinkpad-r50e + debian testing.
> if you need parts of my config file, just feel free to tell me so and  i 
> ll try to provide you the information!

Doh!  Your error made me realize that I broke uniprocessor in -rt9.  Will fix right away.

As far as -rt7 is concerned, that doesn't make a lot of sense since cpupri isnt introduced until -rt9.  Perhaps your tree was dirtied from a previous application of -rt9?  Let me know if that doesn't appear to be the case.

Regards,
-Greg
