From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH-rt] rtmutex/rt: don't BUG for -EDEADLK when
 detect_deadlock is off
Date: Wed, 11 Feb 2015 14:36:51 -0500
Message-ID: <CAP=VYLrQ7LRGUBMngZz2LE-REi+7cU1jduePnwiNoeOEbPWynQ@mail.gmail.com>
References: <1413418164-9405-1-git-send-email-paul.gortmaker@windriver.com> <loom.20150205T085239-980@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	rostedt@goodmis.org
To: =?UTF-8?Q?Philipp_T=C3=B6lke?= <philipp.toelke@fos4x.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:47124 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbbBKThX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Feb 2015 14:37:23 -0500
Received: by mail-wg0-f43.google.com with SMTP id n12so5653308wgh.2
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Feb 2015 11:37:22 -0800 (PST)
In-Reply-To: <loom.20150205T085239-980@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Feb 5, 2015 at 2:58 AM, Philipp T=C3=B6lke <philipp.toelke@fos4=
x.de> wrote:
> Hi everybody,
>
> Paul Gortmaker <paul.gortmaker <at> windriver.com> writes:
>>  -this patch is against 3.10-rt, but the code for all recent -rt
>>   that include the recent linux-stable rtmutex changes should have
>>   the same issue.  [The 3.14-rt has a trivial path change where the
>>   kernel/rtmutex.c of v3.10 becomes kernel/locking/rtmutex.c but
>>   aside from that it applies to 3.14 too]
>>
>>  -I'd got a report of this BUG_ON triggering on a v3.4-rt based
>>   kernel; that kernel was using my integration of the tglx rtmutex
>>   stable changes into 3.4-rt as described here:
>>       https://lkml.org/lkml/2014/9/23/944
>>   but the related code in rostedt's 3.10.53-rt56 (in linux-stable-rt=
)
>>   and in tglx's 3.14.12-rt9 patch queue is AFAICT identical.  So I
>>   have to conclude that anything using the stable rtmutex changes
>>   can inadvertently suffer the same BUG trigger.
>>
>>  -this change gets us back to the pre-rtmutex stable commit behaviou=
r,
>>   but I suspect that smarter people than me can advise on a way to
>>   achieve the same end result.  So I'll wait before adding anything
>>   to the linux-stable-rt branches I'd put here at:
>>       https://git.kernel.org/cgit/linux/kernel/git/paulg/linux-stabl=
e-rt.git
>
> What is the status of this patch? I have a machine here I can get to =
crash in
> about half an hour by doing a bidirectional iperf as proposed in
> <http://thread.gmane.org/gmane.linux.rt.user/12681>.
>
> Ffor posterity: The command is "iperf -c 1.2.3.4 -i 10 -d -l 64k -t 5=
0400"
> which would normally do a 14 hour-iperf test against 1.2.3.4.
>
> My machine crashes with both 3.10.53-rt56 and 3.14.29-rt26. After
> applying your patch to 3.14 the machine has not crashed in 24 hours.

Yeah, FWIW, I've been using it on 3.4, 3.10 and 3.14 since my original =
post.

>
> Have "smarter people" had a chance to advise about this patch? Is the=
re any
> reason not to use it?

1) No, and 2) not AFAIK.   I've added Steve to Cc:  hopefully he can
take a look and decide whether to merge it to stable-rt git repo.  It
seems like the results from you, myself and others do indicate it is
a real issue though... and if this isn't the way to fix it then we will
need some other fix.

Paul.
--

>
> Regards,
> Philipp T=C3=B6lke
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
