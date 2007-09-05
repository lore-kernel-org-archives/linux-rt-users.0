From: Manfred Gruber <m.gruber@tirol.com>
Subject: Re: PI mutex support on ARM
Date: Wed, 5 Sep 2007 18:36:02 +0200
Message-ID: <200709051836.02683.m.gruber@tirol.com>
References: <200708201453.14641.m.gruber@tirol.com> <200709041348.42229.m.gruber@tirol.com> <3efb10970709050557i24dbdc3bub65a5eea249ae8f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	williams@redhat.com
To: "Remy Bohmer" <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:25125 "EHLO
	viefep33-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756796AbXIEQgG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2007 12:36:06 -0400
In-Reply-To: <3efb10970709050557i24dbdc3bub65a5eea249ae8f1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hi Remy !

Am Wednesday 05 September 2007 schrieben Sie:
> Hello Manfred,
>
> > My question if I run the pi_stress, my watchdog triggers, if watchdog is
> > disabled i get this:
> > Is this the correct behaviour ? Or does it show a problem ?
>
> Depends on the priority of your watchdog-feeder thread. If it is not
> running in RT mode, with a priority higher than used in the pi-stress
> test, then yes it is normal that the watchdog kicks in. pi-stress
> takes 100% CPU-load, and leaves no room for non-RT processes.
>
> The output you get seems normal to me...

Ok, thanks.

The only difference between you patch and now 2.6.23-rc4-rt1 is that now a 
raw_ spinlock is used. So i think when using your patch on 2.6.21.5-rt20, 
because a customer has this kernel running, i have there also to use a 
raw_spinlock ?

thanks, 
regards manfred
