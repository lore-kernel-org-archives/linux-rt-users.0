From: "Remy Bohmer" <l.pinguin@gmail.com>
Subject: Re: v2.6.22.1-rt3
Date: Fri, 13 Jul 2007 13:36:56 +0200
Message-ID: <3efb10970707130436v70ddbae2w51af0a19fa5c297c@mail.gmail.com>
References: <1184325752.12353.312.camel@chaos>
Reply-To: linux@bohmer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>
To: "Thomas Gleixner" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:21706 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbXGMLg5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 07:36:57 -0400
Received: by py-out-1112.google.com with SMTP id d32so731004pye
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Jul 2007 04:36:56 -0700 (PDT)
In-Reply-To: <1184325752.12353.312.camel@chaos>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

>  http://www.tglx.de/projects/preempt-rt/2.6.22.1

This is a dead link...
It should be: http://www.tglx.de/projects/preempt-rt/2.6.22.1-rt3/

Remy

>
> more info about the -rt patchset can be found in the RT wiki:
>
>    http://rt.wiki.kernel.org
>
> This release is bugfix release:
>
> - update of the x8664 -hrt queue (resolve boot problems)
> - gtod vsyscall fix from Gregory Haskins
>
> to build a 2.6.22.1-rt3 tree, the following patches should be applied:
>
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.22.1.tar.bz2
>    http://www.tglx.de/projects/preempt-rt/2.6.22.1-rt3/patch-2.6.22.1-rt3.patch
>
>
>         Thomas
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
