From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: PI mutex support on ARM
Date: Mon, 20 Aug 2007 20:59:38 +0200
Message-ID: <3efb10970708201159q69a8757ay605e8567b4233922@mail.gmail.com>
References: <200708201453.14641.m.gruber@tirol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de,
	linux@arm.linux.org.uk, mingo@elte.hu
To: "Manfred Gruber" <m.gruber@tirol.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:48396 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbXHTS7k (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Aug 2007 14:59:40 -0400
Received: by nz-out-0506.google.com with SMTP id s18so500890nze
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Aug 2007 11:59:40 -0700 (PDT)
In-Reply-To: <200708201453.14641.m.gruber@tirol.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Manfred,

At http://www.spinics.net/lists/arm-kernel/msg42349.html you can find
a patch that will probably work. Due to the lack of proper atomic
instructions on the ARM-v4 core this patch is likely to be the best
possible solution.

Kind Regards,

Remy

2007/8/20, Manfred Gruber <m.gruber@tirol.com>:
> hi !
>
> Is about the PI Mutex issue on ARM some work going on?
> Or does someone have an information for me how to implement this for a armv4
> correct ?
>
> thanks
>         fred
>
>
