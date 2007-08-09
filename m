From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Thu, 9 Aug 2007 14:47:19 +0200
Message-ID: <3efb10970708090547j3e4c597fi88ff51c5c4d8e61c@mail.gmail.com>
References: <200708081514.31864.jbe@pengutronix.de>
	 <200708081409.28105.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	"Juergen Beisert" <jbe@pengutronix.de>
To: "Darren Hart" <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:22755 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939659AbXHIMrV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Aug 2007 08:47:21 -0400
Received: by py-out-1112.google.com with SMTP id d32so786629pye
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Aug 2007 05:47:19 -0700 (PDT)
In-Reply-To: <200708081409.28105.dvhltc@us.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Darren,

> I disagree.  The point of real-time is to provide user-space with more control
> of what get's run, when, instead of something else - including system
> interrupts, etc.  For instance, if networking should take a higher priority
> than their application, but disk i/o should take a lower one, the user needs
> to be able to control that.  chrt is the correct approach for -rt in my
> opinion.

I believe this depends on the environment where the RT-kernel is used.
Therefor this might be true for Realtime Desktop/Server applications,
but, for RT-Embedded systems it is possible (likely) that the entire
kernel is pre-configured for 1 single purpose, and that some developer
wants to set the priorities for that purpose only. In that case there
is usually no user that cares anything about what is running on the
system, as long as his device works, so that user will never come to
the idea to use 'chrt'.

In these case the default priorities at 50 are useless and the
developer has to have a way to configure the priorities. So I
understand the question of Juergen.
To suit my needs, I did this by just patching the kernel thread
priorities at the places where they are started. (And I am still happy
with my solution. Note that because it is very application specific, I
never expect a patch like this to get to the mainline)

Kind Regards,

Remy
