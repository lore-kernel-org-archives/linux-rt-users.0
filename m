From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: RT Problem on Powermac G5 (more info)
Date: Fri, 15 Mar 2013 13:54:55 -0700
Message-ID: <CDAB4622-D08F-453E-A23F-1E2544BEDBF3@thebigcorporation.com>
References: <DUB002-W1234C65DFF1F08EEE03C9BDE1ED0@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: - - <man.johnson@outlook.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44264 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131Ab3COUy6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Mar 2013 16:54:58 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so4313983pbc.17
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Mar 2013 13:54:58 -0700 (PDT)
In-Reply-To: <DUB002-W1234C65DFF1F08EEE03C9BDE1ED0@phx.gbl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Quick general advice, without looking at your specific links:

Try some other configurations first, e.g. instead of configuring PREEMPT_FULL, 
configure a more basic PREEMPT mode, and see if you can get something running.

Then turn on features (e.g. IRQ threading, and so on, and see when it breaks)

BTW what's up with the oddball - - in the SMTP header?

On Mar 15, 2013, at 4:39 AM, - - <man.johnson@outlook.com> wrote:

> Hello,
> I have posted my config here: "http://pastebin.com/Fxw2Ergz",
> I hope that with the photo of the error message which can be 
> downloaded here: "http://views.airpost.net/?imagepage=oops.jpg"
> in full format you will have enough to provide a first diagnosis.
> I'd like to know also if someone has already an experience of 
> rt-kernel on powerpc64. Thanks again 		 	   		  --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

