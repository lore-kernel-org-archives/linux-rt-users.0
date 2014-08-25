From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: CpuFreq Laptop Scaling broken?
Date: Mon, 25 Aug 2014 15:02:28 +0100
Message-ID: <CAKudYbNNA3TLR0gyesiwy_38AtjNgf4bVjgd7+rguLxiVHCzUw@mail.gmail.com>
References: <CAKudYbOjXe3JRGDsE3A_=Vd7NEU+_eDO3po3+47CS80=TN363g@mail.gmail.com>
	<CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, rjw@rjwysocki.net
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:58706 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbaHYOCa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2014 10:02:30 -0400
Received: by mail-la0-f51.google.com with SMTP id pn19so12743721lab.24
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Aug 2014 07:02:29 -0700 (PDT)
In-Reply-To: <CAKohpoktdiBvOY=xTY==kLaAfSqqAcfHxAq9Jkk7cHE3f_NyHA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 25, 2014 at 2:55 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> You tried both these as root? Even 'sudo' may not work..
Yes, the original output was all as root (not sudo, genuine root).

> I haven't seen the rt code since sometime, what tag should I look at ?
I'm running 3.14.12-rt9-1-rt  (as packaged for Arch here:
https://aur.archlinux.org/packages/linux-rt )

Cheers, -Harry
