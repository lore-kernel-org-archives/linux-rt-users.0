From: Xianwei Zeng <linux.xianwei.zeng@gmail.com>
Subject: Re: [rt sched] SCHED_FIFO task of lower rt_priority blocks higher one
Date: Thu, 4 Mar 2010 14:18:55 +0900
Message-ID: <ac85e7a01003032118l1bdc1d22we08f2b50626c2535@mail.gmail.com>
References: <ac85e7a01003031921x2102d554q86c76e560f7ef6f4@mail.gmail.com>
	 <1ca41c0f1003031952u7a9ea0w5adf4f0438b8fe0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Karthik Singaram Lakshmanan <karthiksingaram@gmail.com>,
	hancockrwd@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:36215 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab0CDFSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Mar 2010 00:18:55 -0500
Received: by pzk32 with SMTP id 32so432273pzk.4
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2010 21:18:55 -0800 (PST)
In-Reply-To: <1ca41c0f1003031952u7a9ea0w5adf4f0438b8fe0c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Thanks for your replies.

I made a mistake about the priority inside the kernel and
sched_setscheduler system call.
I thought both of them are the same: numerically lower priority value
is higher schedule priority.
But in fact, they are opposite:

  * Kernel: numerically lower value is high priority
  * sched_setscheduler() and related system calls:  numerically lower
value is lower priority

It is said in  "man sched_get_priority_max" output:

       Processes with numerically higher priority values  are
scheduled  before  processes
       with numerically lower priority values. Thus, the value
returned by sched_get_prior-
       ity_max() will be greater than the value returned by
sched_get_priority_min().

Thanks.

On Thu, Mar 4, 2010 at 12:52 PM, Karthik Singaram Lakshmanan
<karthiksingaram@gmail.com> wrote:
> Hi,
> =A0=A0=A0 If I am not mistaken, higher value of sched_priority denote=
s higher
> priority.
> =A0=A0=A0 Therefore, looking at
> =A0 =A0=A0 =A0=A0 normal_prio =3D MAX_RT_PRIO - 1 - task->rt_priority=
;
> =A0=A0=A0=A0=A0=A0=A0 you can see that a higher task->rt_priority wil=
l translate to a
> lower value of normal_prio, thereby occupying an earlier bit.


--=20
Best Regards,
Zeng Xianwei
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
