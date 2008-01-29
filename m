From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: how does Real-time Linux and (Xen) Virtualization work
	together?
Date: Tue, 29 Jan 2008 14:49:38 -0800
Message-ID: <1201646978.6344.42.camel@sven.thebigcorporation.com>
References: <305906.38166.qm@web34603.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Gautam Thaker <ghthaker@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:20232 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYA2Wtp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Jan 2008 17:49:45 -0500
Received: by wx-out-0506.google.com with SMTP id h31so305wxd.4
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Jan 2008 14:49:45 -0800 (PST)
In-Reply-To: <305906.38166.qm@web34603.mail.mud.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 2008-01-29 at 09:12 -0800, Gautam Thaker wrote:
> how well would a set of 2 real-time Linux guest OSes
> work on top of a dom0 host that would be based on
> real-time linux?


Best case, it will work as well as Xen's scheduler and internal locking
allows.

>  Has real-time and virtualization
> interactions been studied in any details? 

You should use KVM.

> I am not
> even sure if a real-time Linux can be the host OS for
> hosting  guest OSes, can it?
> 
You can host RT guest VMs with an RT host 

Sven

> Gautam
> 
> 
>       ____________________________________________________________________________________
> Looking for last minute shopping deals?  
> Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
