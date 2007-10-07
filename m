From: "Jaswinder Singh" <jaswinderlinuxrt@gmail.com>
Subject: Re: Porting intLock()
Date: Sun, 7 Oct 2007 18:57:44 +0530
Message-ID: <1985e0f60710070627i27009a6aib5aaa7aa82f62dd8@mail.gmail.com>
References: <loom.20071004T185733-342@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Morten Mossige" <morten.mossige@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:51380 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbXJGN1o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Oct 2007 09:27:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1316340wah
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Oct 2007 06:27:44 -0700 (PDT)
In-Reply-To: <loom.20071004T185733-342@post.gmane.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Morten,

On 10/5/07, Morten Mossige <morten.mossige@gmail.com> wrote:
> Hi
> I'm porting an application from another realtime-os to Linux. This
> application makes use of intLock() from time to time. I still need the the
> application to be compilable on both Linux and my old os, so I  need a
> portabel intLock()
> I have tried the following approach:
> When a thread needs to do intLock, I boost the thread-pri to max, and when
> the thread does intUnLock() I set the thread-pri back. This woorks quite ok,

I think your approach is good if it is working.

> but by using this approach, I will also lock other threads in other
> applications running on Linux.

Someone has to pay. If you are boosting someone on the same time you
are also suppressing others, this is how real-time works.

> What I really need is a way of blocking all other threads in my application,
> without affecting other applications.

If you block other applications they will be affected. No solution for this.

Jaswinder Singh.


> I know I can use mutex'es and semaphores, but that will require a major
> rewriting of the application, and that is somthing I dont want to do.
> Can someone come up with an idea how this is done best?
> Morten
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
