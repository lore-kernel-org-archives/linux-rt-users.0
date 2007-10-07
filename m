From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: 2.6.23-rc9-rt2
Date: Sun, 7 Oct 2007 19:05:17 +0530
Message-ID: <1985e0f60710070635l7016bad1t9c4d4cb1a966534f@mail.gmail.com>
References: <1191536413.5210.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:15617 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbXJGNfT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Oct 2007 09:35:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so508250rvb
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Oct 2007 06:35:17 -0700 (PDT)
In-Reply-To: <1191536413.5210.19.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steve,

Do you have any plans to support nested or reentrant Interrupt Handling schemes.

Thank you,

Jaswinder SIngh.

On 10/5/07, Steven Rostedt <rostedt@goodmis.org> wrote:
> We are pleased to announce the 2.6.23-rc9-rt2 tree, which can be
> downloaded from the new location:
>
>  http://www.kernel.org/pub/linux/kernel/projects/rt/
>
> Changes since 2.6.23-rc9-rt1
>
>   - x86_64 disable IST for debug (Andi Kleen)
>
>   - Better handling of dynticks going bad in RCU (Steven Rostedt)
>
>   - Preempt RCU boosting (Steven Rostedt based on Paul E. McKenney's
>     stuff)
>
> Again, this still holds experimental code. But I've been running it on a
> few boxes already (and even the box I'm writing this on).
>
> to build a 2.6.23-rc9-rt2 tree, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.tar.bz2
>   http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.23-rc9.bz2
>   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23-rc9-rt2.bz2
>
> The broken out patches are also available.
>
> -- Steve
>
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
