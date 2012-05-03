From: Priyanka Gupta Jain <p.priyankagupta@gmail.com>
Subject: looking for something like raw_rwlock_t in Linux 3.0
Date: Thu, 3 May 2012 16:21:00 +0530
Message-ID: <CACpc7pc_mb6tDVOjaVPx3=aWzwySkn6D93BFab0FaTcBzLcrpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:34709 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753981Ab2ECKvB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 06:51:01 -0400
Received: by ghrr11 with SMTP id r11so1585134ghr.19
        for <linux-rt-users@vger.kernel.org>; Thu, 03 May 2012 03:51:00 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi,

I am still looking for the answer to the below. I will be highly
thankful if someone can help in it.

Is there something like raw_rwlock_t in Linux3.0 which can make the
rwlock_t behave in similar way as in RT disable.
This might help me in solving throughput issue in 8-core system due to
read/write lock.

Regards
Priyanka

On Wed, Apr 11, 2012 at 10:32 AM, Priyanka Gupta Jain
<p.priyankagupta@gmail.com> wrote:
> hi,
>
> I am observing drastic throughput reduction in IPSEC traffic with RT
> enable and disable. Throughput drops from 576 fps to 69fps.
> Please note that I am using 8-core system with Linux 3.0.26-rt45 (SMP=
)
> running on it.
>
> With the help of ftrace (function graph) in case of RT enable, I coul=
d
> see xfrm_policy_get_afinfo() and xfrm_policy_put_afinfo taking time()
> sometimes taking time arounnd 1.43 msec and =A01.351msec respectively=
=2E
>
> As in my test case, I was writing afinfo_policy before starting the
> traffic without chainging in between, it was safe to remove read lock
> and read unlock from xfrm_policy_get_afinfo() and
> xfrm_policy_put_afinfo() functions. With the read lock/unlock removed=
,
> I could see throughput rising from 69fps to 133fps.
>
> Now I need your suggestions for the below:
> 1) Removing the read lock is not a good way as the system might now
> work properly in the real set-up. But with the change of read-write
> lock to mutex by PREEMPT_RT patch, I am not able to fully utilize
> 8-core system leading to drastic reduction in throughput. So what is
> the suggested way to tackle this situation.
>
> 2) Even after removing the read lock, I could see the difference in
> IPSEC thoughput in RT enable (133fps) and RT disable (576fps). Any
> suggestion?.
>
>
> Regards
> Priyanka
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
