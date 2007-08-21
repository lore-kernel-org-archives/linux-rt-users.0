From: Manfred Gruber <m.gruber@tirol.com>
Subject: Re: PI mutex support on ARM
Date: Tue, 21 Aug 2007 08:58:27 +0200
Message-ID: <200708211048.35443.m.gruber@tirol.com>
References: <200708201453.14641.m.gruber@tirol.com> <3efb10970708201159q69a8757ay605e8567b4233922@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de,
	linux@arm.linux.org.uk, mingo@elte.hu
To: "Remy Bohmer" <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:41368 "EHLO
	viefep32-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751716AbXHUIsj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Aug 2007 04:48:39 -0400
In-Reply-To: <3efb10970708201159q69a8757ay605e8567b4233922@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Remy !

thanks a lot, i will test it on a ARM-v4 with 2.6.23-rc2-rt2 and 
2.6.21.5-rt20.

I have a application which makes a lot of pthread_mutex_lock/unlock 
between rt and non-rt tasks with PI. So i will look what happens.

thanks
	fred

Am Monday 20 August 2007 schrieben Sie:
> Hello Manfred,
>
> At http://www.spinics.net/lists/arm-kernel/msg42349.html you can find
> a patch that will probably work. Due to the lack of proper atomic
> instructions on the ARM-v4 core this patch is likely to be the best
> possible solution.
>
> Kind Regards,
>
> Remy
