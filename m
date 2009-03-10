From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Seeing 800us of latency with cyclictest on a PC with 2.6.26.8
 rt  patch. Is that normal?
Date: Tue, 10 Mar 2009 09:33:21 -0700
Message-ID: <1236702801.28103.51.camel@sven.thebigcorporation.com>
References: <loom.20090310T140426-205@post.gmane.org>
	 <1236696976.28103.40.camel@sven.thebigcorporation.com>
	 <3d1967ab0903100834s3426b865r652dec7f2bd3de1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Brian Hutchinson <b.hutchman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:50957 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbZCJQdX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Mar 2009 12:33:23 -0400
Received: by qyk28 with SMTP id 28so1753062qyk.33
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2009 09:33:20 -0700 (PDT)
In-Reply-To: <3d1967ab0903100834s3426b865r652dec7f2bd3de1b@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2009-03-10 at 11:34 -0400, Brian Hutchinson wrote:
> Thanks for your quick reply.
> 
> Specifically, my laptop is a Dell Latitude D620.  I turned off a lot
> of the features in Kernel Hacking section (stack checking etc.) 
> 

Laptops are a bit notorious for heavy BIOS activity.

> I haven't ran cyclictest with the -b option yet as I can't find some
> of the .config parameters in this kernel that match the cyclictest
> latency checking documentation.  Before I beat my head against the
> wall too hard I thought I'd ping others and see if what I'm seeing is
> normal or if others were able to run on a PC and obtain very low
> latency.
> 

this is out of a script I use.

sudo chrt -f 80 /usr/bin/time /usr/local/bin/cyclictest -n -q -p 99 -a -t -i 500
 -l $NLOOPS -h 10000 -m | tee -a $LOGFILE


> I'm trying to come up to speed on the latest 2.6 kernels after having
> most experience with 2.4 and early 2.6.  I see the TSC isn't used
> anymore.  I thought about just not using ACPI but I think that will
> kill my high res timers.  I do see a local ACPI otion so I don't know
> if that will make high res timers work ... I'm reading
> conflicting/dated info. so I thought I'd consult the experts so they
> can show me the way :)
> 

ACPI is fine, deadlock detect is not...

Of the available patch sets, the 2.6.24-RT patch set is being used by a
few distros. 

The 2.6.22 RT Kernel Suse ships is equally well tested and performs
better, or worse, depending who is getting paid by whom to do the
benchmark :)

Point is: Use the .22. or the .24 to get best-case numbers for your
config and platform, then take that config forward to .26 and beyond,
let us know about regressions.

I can offer you the configs for 2.6.22 in these packages as
tested/optimal.

http://ftp.suse.com/pub/projects/kernel/kotd/SLERT10_BRANCH/


Sven

> Regards,
> 
> Brain
> 
> 
> On Tue, Mar 10, 2009 at 10:56 AM, Sven-Thorsten Dietrich
> <sven@thebigcorporation.com> wrote:
>         On Tue, 2009-03-10 at 14:06 +0000, Brian Hutchinson wrote:
>         > We don't have our target hardware yet so I'm trying to get a
>         jump on some of the
>         > newer 2.6 kernel features using a PC.
>         >
>         
>         
>         What hardware are you testing on?
>         
>         > Compiled a 2.6.26.8 with the 2.6.26.8-rt16 patch applied for
>         a Dell Core Duo
>         > laptop and when I run cyclictest the max latency is up
>         around 800us with the
>         > avg. around 65us.
>         >
>         
>         
>         You should compare to the 2.6.24-RT patch set first of all, I
>         would
>         expect worst-cases to be 25% of what you are seeing.
>         
>         If it does not, then your configuration may have too much
>         debugging
>         turned on (boot log warns about some of these) - or you are
>         indeed
>         getting some SMI interference.
>         
>         > I'm running the CFS scheduler in real time mode.
>         >
>         > Is this the best I'm going to see on a PC?  I've been
>         reading everything I can
>         > get my hands on and it looks like SMI and BIOS may hinder me
>         from getting much
>         > below what I'm seeing.
>         >
>         
>         
>         SMIs can be turned off in many cases.
>         
>         Some vendors have warranty/support programs tied to SMI
>         architectures,
>         in these cases you might be able to press them for a custom
>         BIOS
>         (depending on volume and how much hell you want to raise)
>         
>         Cheers,
>         
>         Sven
>         
>         
>         > TIA!
>         >
>         > Regards,
>         >
>         > Brian
>         >
>         > --
>         > To unsubscribe from this list: send the line "unsubscribe
>         linux-rt-users" in
>         > the body of a message to majordomo@vger.kernel.org
>         > More majordomo info at
>          http://vger.kernel.org/majordomo-info.html
>         
>         
> 

