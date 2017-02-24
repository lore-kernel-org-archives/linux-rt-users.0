From: Wargreen <wargreen@lebib.org>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Fri, 24 Feb 2017 23:09:28 +0100
Message-ID: <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: linux-rt-users@vger.kernel.org
To: Pankaj Gupta <pagupta@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lebib.org ([89.234.152.46]:56737 "EHLO lebib.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbdBXWJo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Feb 2017 17:09:44 -0500
In-Reply-To: <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you for your reply.
> It looks like some other task holding the mutex resulting
> these tasks to sleep and hung the system.
>
> One step to debug this is to find out which task is holding
> the mutex and for how long? Taking crash of hung system
> and see whats going on is one way but a harsh one
Because my bad english and my light technical background, i don't
understand how can i find this task.
Can you guide me ?

> Another step is start with version where it was working before?
> and try to bisect or narrow down.
=46rom memory, it's happen with 4.0.4, 4.1.3 and 4.9.0, on two computers
(both with intel CPU). So i don't know if it was worked one day.

> Others might have better ideas.
I take all ideas !
It's my workstation (as well as my all-day computer) for real time audio
processing so i'm open to alls test who can fix this problem.

Is it the best place, or i should also post on the radeon mailing ?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



