From: raz ben yehuda <raziebe@gmail.com>
Subject: Re: Hard real time in user space with preempt_rt patch
Date: Tue, 24 Apr 2012 09:05:44 +0300
Message-ID: <1335247544.10715.1.camel@raz>
References: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Anisha Kaul <born.rebel.83@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64960 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab2DXGFv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Apr 2012 02:05:51 -0400
Received: by wibhq7 with SMTP id hq7so287840wib.1
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Apr 2012 23:05:49 -0700 (PDT)
In-Reply-To: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-04-24 at 11:16 +0530, Anisha Kaul wrote:
> From: https://rt.wiki.kernel.org/articles/f/r/e/Frequently_Asked_Questions_7407.html
> 
> > Real-time only has impact on the kernel; Userspace does not notice the difference except for better real time behavior.
> 
> Does it mean that if we write the applications in user space, they
> won't get the hard real time effect?
> The threads running in the userspace won't get the hard real time effect?
user DOES get real time. The quote means that you need not to change the
application. in short, you u usleep for 2 ms, you wake after 2ms if you
have the system correctly tuned.
> I am not able to understand the English behind the quote. Please clarify.
> 
> Regards,
> Anisha
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


