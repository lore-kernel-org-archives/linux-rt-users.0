From: Priyanka Gupta Jain <p.priyankagupta@gmail.com>
Subject: Re: looking for something like raw_rwlock_t or some optimization in
 rwlock_t in Linux 3.0
Date: Mon, 7 May 2012 10:19:59 +0530
Message-ID: <CACpc7petSnyR4qwE+F_b-OcdXc9+c5RRrX_u0TiLZnzy2eDWOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34354 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab2EGEuA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 00:50:00 -0400
Received: by yhmm54 with SMTP id m54so3879397yhm.19
        for <linux-rt-users@vger.kernel.org>; Sun, 06 May 2012 21:49:59 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi,

I would really appreciate if someone can help in finding an
alternative to rwlock_t.
I want one particular rw_lock to behave as in native linux not as
mutex of if there is any other optimization that I can do in that
rwlock or in general to all rwlocks as well.
This is required to boost the performance in case of multicore systems

Regards
Priyanka

On Thu, May 3, 2012 at 4:21 PM, Priyanka Gupta Jain
<p.priyankagupta@gmail.com> wrote:
> hi,
>
> I am still looking for the answer to the below. I will be highly
> thankful if someone can help in it.
>
> Is there something like raw_rwlock_t in Linux3.0 which can make the
> rwlock_t behave in similar way as in RT disable.
> This might help me in solving throughput issue in 8-core system due t=
o
> read/write lock.
>
> Regards
> Priyanka
>
> On Wed, Apr 11, 2012 at 10:32 AM, Priyanka Gupta Jain
> <p.priyankagupta@gmail.com> wrote:
>> hi,
>>
>> I am observing drastic throughput reduction in IPSEC traffic with RT
>> enable and disable. Throughput drops from 576 fps to 69fps.
>> Please note that I am using 8-core system with Linux 3.0.26-rt45 (SM=
P)
>> running on it.
>>
>> With the help of ftrace (function graph) in case of RT enable, I cou=
ld
>> see xfrm_policy_get_afinfo() and xfrm_policy_put_afinfo taking time(=
)
>> sometimes taking time arounnd 1.43 msec and =A01.351msec respectivel=
y.
>>
>> As in my test case, I was writing afinfo_policy before starting the
>> traffic without chainging in between, it was safe to remove read loc=
k
>> and read unlock from xfrm_policy_get_afinfo() and
>> xfrm_policy_put_afinfo() functions. With the read lock/unlock remove=
d,
>> I could see throughput rising from 69fps to 133fps.
>>
>> Now I need your suggestions for the below:
>> 1) Removing the read lock is not a good way as the system might now
>> work properly in the real set-up. But with the change of read-write
>> lock to mutex by PREEMPT_RT patch, I am not able to fully utilize
>> 8-core system leading to drastic reduction in throughput. So what is
>> the suggested way to tackle this situation.
>>
>> 2) Even after removing the read lock, I could see the difference in
>> IPSEC thoughput in RT enable (133fps) and RT disable (576fps). Any
>> suggestion?.
>>
>>
>> Regards
>> Priyanka
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
