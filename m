From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Seeing 800us of latency with cyclictest on a PC with 2.6.26.8
 rt patch. Is that normal?
Date: Tue, 10 Mar 2009 07:56:16 -0700
Message-ID: <1236696976.28103.40.camel@sven.thebigcorporation.com>
References: <loom.20090310T140426-205@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Brian Hutchinson <b.hutchman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:14642 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbZCJO4S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Mar 2009 10:56:18 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1999402qwi.37
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2009 07:56:16 -0700 (PDT)
In-Reply-To: <loom.20090310T140426-205@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2009-03-10 at 14:06 +0000, Brian Hutchinson wrote:
> We don't have our target hardware yet so I'm trying to get a jump on some of the
> newer 2.6 kernel features using a PC.
>  

What hardware are you testing on? 

> Compiled a 2.6.26.8 with the 2.6.26.8-rt16 patch applied for a Dell Core Duo
> laptop and when I run cyclictest the max latency is up around 800us with the
> avg. around 65us.
> 

You should compare to the 2.6.24-RT patch set first of all, I would
expect worst-cases to be 25% of what you are seeing.

If it does not, then your configuration may have too much debugging
turned on (boot log warns about some of these) - or you are indeed
getting some SMI interference.

> I'm running the CFS scheduler in real time mode.
> 
> Is this the best I'm going to see on a PC?  I've been reading everything I can
> get my hands on and it looks like SMI and BIOS may hinder me from getting much
> below what I'm seeing.
> 

SMIs can be turned off in many cases. 

Some vendors have warranty/support programs tied to SMI architectures,
in these cases you might be able to press them for a custom BIOS
(depending on volume and how much hell you want to raise)

Cheers,

Sven

> TIA!
> 
> Regards,
> 
> Brian 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

