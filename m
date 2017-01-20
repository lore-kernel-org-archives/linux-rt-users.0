From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Re: Crash in kernel/locking/rtmutex.c
Date: Fri, 20 Jan 2017 01:45:32 -0500
Message-ID: <CAEYdEeR1Z0RWkGJ1PUyMujZf3kHqxZE-B6yHpXcNkcXVJg75Mg@mail.gmail.com>
References: <CAEYdEeQ63HZzi8yJk4eAAa=XeEeOFR_wqnL_PW3d6Nt5N955pQ@mail.gmail.com>
 <20170117201906.GB1335@jcartwri.amer.corp.natinst.com> <CACRpkdbxZw6QLKA0A8b=VuHmtkSHFywDT19pFZ3ioQ0kA=3VNg@mail.gmail.com>
 <CAEYdEeQ00axyXD0noFJDsPxHeMb0qhC6jTG4Lee7En+cOqHkXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Julia Cartwright <julia@ni.com>, linux-rt-users@vger.kernel.org,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35188 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdATGqD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Jan 2017 01:46:03 -0500
In-Reply-To: <CAEYdEeQ00axyXD0noFJDsPxHeMb0qhC6jTG4Lee7En+cOqHkXw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Julia, Linus, and others,

we applied the patch and ran out setup for four hours continuously
without encountering the crash.  That's the longest we've run it to
date.  Thank you for your help and especially for your very speedy
replies.

-Brian

On Wed, Jan 18, 2017 at 11:39 AM, Brian Wrenn <dcbrianw@gmail.com> wrote:
> Hi Julia and Linus,
>
> we haven't gotten to testing with the patch, but I will report back
> when we have done so.
>
> Thank you very much for the help.
>
> On Wed, Jan 18, 2017 at 3:49 AM, Linus Walleij <linus.walleij@linaro.org>=
 wrote:
>> On Tue, Jan 17, 2017 at 9:19 PM, Julia Cartwright <julia@ni.com> wrote:
>>
>>> Can you give the following patch a try?  Even though this problem is
>>> only observable on -rt kernels, the below patch is suitable for
>>> inclusion in mainline.  (The below is ontop of -next, you may have to
>>> finnagle it a bit to work on the linaro frankenkernel).
>>
>> This looks like one of the RT cases pointed out by Grygorii i
>> Documentation/gpio/driver.txt
>> and the patch looks fine.
>>
>> Once you have confirmation that it solves the problem, add
>> a Tested-by: tag and send to the GPIO mailinglist & me and
>> make sure to get Bj=C3=B6rn Andersson on the CC so he can review
>> it swiftly.
>>
>> Yours,
>> Linus Walleij
