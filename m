From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: patch for 3.4.27
Date: Mon, 5 Dec 2016 22:37:25 +0200
Message-ID: <CAJ2oMhL8nVkQBnwgfAhBDRumc6MLrJib5ZBsp9JKrr68QBb+Nw@mail.gmail.com>
References: <CAJ2oMh+N3Y1g1zu5UjJ=X4TF3WmbfZiU3Y+OhtoZFjyNEZSr6Q@mail.gmail.com>
 <CAFq1FnZnN4zDmwWD45Fmdgd=vdSpuifcutFVtWpd79KyZfG7uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Matt Byrne <matthewlbyrne@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36177 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbcLEUh1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Dec 2016 15:37:27 -0500
Received: by mail-wm0-f48.google.com with SMTP id g23so109330771wme.1
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Dec 2016 12:37:26 -0800 (PST)
In-Reply-To: <CAFq1FnZnN4zDmwWD45Fmdgd=vdSpuifcutFVtWpd79KyZfG7uQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Dec 5, 2016 at 7:43 PM, Matt Byrne <matthewlbyrne@gmail.com> wrote:
> I wouldn't try mixing patches; I think the lines and files won't match.
> Couldn't hurt to try though.
>

Hi Mat,
Just to be sure I understand:
linux-rt patches are for specific kernel version for
example:3.4.1_rc9, not for all versions (for example I won't find
patch for 3.4.27), Right ?

Thanks,
Ran

> The answer to your question depends on whether you're using the preempt
> patch(es) (PREEMPT_RT) or just the preempt bits that have made it into the
> kernel.  The extensions let userspace, including irq threads (e.g., of your
> video card, midi, etc.) preempt kernel land lower priority processes.  Start
> on page 14 of this pdf: events.linuxfoundation dot
> org/sites/events/files/slides/rtmux_1 dot pdf and check out the graphics - a
> picture's worth 1K words in this case, at least for me.  Have fun!
>
> On Mon, Dec 5, 2016 at 9:20 AM Ran Shalit <ranshalit@gmail.com> wrote:
>>
>> Hello,
>>
>> I am newcomer with RT linux.
>> I have made some general reading about RT patch.
>> I see that there is a patch for 3.4.1_rc9.
>> I wanted to ask if I can try to apply this patch on 3.4.27 ?
>>
>> Another question:
>> Is it correct to assume that kernel is always more real-time than
>> userspace even when using CONFIG_PREEMPT ?
>>
>> Thank you,
>> Ran
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
