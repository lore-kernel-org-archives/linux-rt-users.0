From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: Newbie question about profiling.
Date: Thu, 23 Sep 2010 16:58:52 +0200
Message-ID: <AANLkTi=mXtZHFdkJsMNEd6rzkTW1UXt_7SpXNH+=YO6s@mail.gmail.com>
References: <AANLkTi=6NUEod+pFZPhyZL0v8C-v1iMvQDZnuKgWxj9E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Lars Segerlund <lars.segerlund@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50372 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab0IWO6x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Sep 2010 10:58:53 -0400
Received: by qwh6 with SMTP id 6so1187343qwh.19
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 07:58:52 -0700 (PDT)
In-Reply-To: <AANLkTi=6NUEod+pFZPhyZL0v8C-v1iMvQDZnuKgWxj9E@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Lars,

On Thu, Sep 23, 2010 at 4:42 PM, Lars Segerlund
<lars.segerlund@gmail.com> wrote:

> =A0I was thinking that if I could create a realtime task to test for =
a
> specific thing, I really would like a log of what the kernal was doin=
g
> right before this.
> =A0The only way I can think of is creating a module with a ring buffe=
r (
> spill over ), and tracing the scheduler or interrupt handler .... ( b=
y
> hack=EDng some code to specifically do this ), this would only add a
> small overhead AFAIK.
>
> =A0Any idea's anyone ? or hints ?
>
> =A0It seem's like just the thing that already might have a solution i=
n
> place, so I figured I should not reinvent the wheel.

Yeah in the last couple of years a lot of tools have been developed to
do exaclty this kind of thing. You could look for ..

- FTrace https://rt.wiki.kernel.org/index.php/Ftrace
- Tuna
- LTTng
=2E.

Im sure there are a couple more but Ive used ftrace and LTTng and they
are pretty cool.

best regards
/prady

--=20
http://www.prady.in
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
