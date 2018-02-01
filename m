From: Julia Cartwright <julia-acOepvfBmUk@public.gmane.org>
Subject: Re: High CPU load when using USB Bluetooth on 4.14.15-rt13 kernel
Date: Thu, 1 Feb 2018 13:01:50 -0600
Message-ID: <20180201190150.GA868@jcartwri.amer.corp.natinst.com>
References: <CALw8SCWyD8-AVtqKvPZeNQuyLfvvdLe7ZtRWuh9KH09WNDDHuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>,
        <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mirza Krak <mirza.krak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALw8SCWyD8-AVtqKvPZeNQuyLfvvdLe7ZtRWuh9KH09WNDDHuA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Feb 01, 2018 at 10:58:28AM +0100, Mirza Krak wrote:
> Hi.

Hello Mirza.

[..]
> I have tried running a 4.14.15 vanilla kernel, and this does not have
> this problem which means that it is the following combo
>
>     RT + USB Bluetooth
>
> That seem to the problem.
>
> Before I start digging deep in to the stacks I wanted to post my
> problem to the community to see if someone is having a similar problem
> on a different hardware or if you have any pointers on how to further
> debug this.

One suggestion I would have would be to re-do your testing on mainline
v4.14.15 booted with the 'threadirqs' kernel command line parameter.

The reason being that without this option, interrupts aren't threaded in
mainline, so it very well could be that your hardware is still
misbehaving, however it's execution time just isn't being accounted for
in the same way.

   Julia
