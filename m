From: Venkat Subbiah <venkat.mlist@gmail.com>
Subject: Re: Enabling function trace on call during module init
Date: Fri, 13 Sep 2013 20:59:05 -0700
Message-ID: <CA+P49Arra6LEO2ZpZG4WNv5uh5LkvdO=zA3Xo3U9T5YrtJX6aw@mail.gmail.com>
References: <CA+P49ArN2Nki5oy5MdwKGdcCUYv4i7oEJkypkKWB618T9nHvug@mail.gmail.com>
	<20130907204811.5d52a6b1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:57665 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756282Ab3IND7H (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Sep 2013 23:59:07 -0400
Received: by mail-vc0-f181.google.com with SMTP id hz10so1547534vcb.40
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Sep 2013 20:59:06 -0700 (PDT)
In-Reply-To: <20130907204811.5d52a6b1@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven,

Thanks a lot for the info.

-Venkat

On Sat, Sep 7, 2013 at 5:48 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 6 Sep 2013 20:55:54 -0700
> Venkat Subbiah <venkat.mlist@gmail.com> wrote:
>
>> Hello,
>>
>> Would like to be able to trace function calls executed during the
>> initialization of the kernel module. Is that possible?
>>
>
> Well, yes and no, and it depends ;-)
>
>
> You wont be able to trace any function that is annotated with "__init",
> or even "__exit". That's because the init section does not have a
> standard way of cleaning them up (for boot, modules are different, but
> are still affected by it).
>
> As ftrace modifies code, and it modifies locations of functions, it can
> not safely modify code that suddenly disappeared without it knowing it,
> otherwise you may end up with broken NIC cards.
>
> Note, I do plan on adding code that will fix this in the future, but
> today, unfortunately, we don't have it.
>
> For functions that are not marked by __init, they will be traced. If
> you trace all functions, they will be traced when the module is loaded.
> This may not help you either, because by tracing all functions, you
> will probably lose the data you want due to overflow of the buffers.
>
> This too may change in the future, but currently we don't have it :-/
>
> -- Steve
