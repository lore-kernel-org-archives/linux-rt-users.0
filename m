From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Enabling function trace on call during module init
Date: Sat, 7 Sep 2013 20:48:11 -0400
Message-ID: <20130907204811.5d52a6b1@gandalf.local.home>
References: <CA+P49ArN2Nki5oy5MdwKGdcCUYv4i7oEJkypkKWB618T9nHvug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Venkat Subbiah <venkat.mlist@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:10644 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab3IHAsN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Sep 2013 20:48:13 -0400
In-Reply-To: <CA+P49ArN2Nki5oy5MdwKGdcCUYv4i7oEJkypkKWB618T9nHvug@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 6 Sep 2013 20:55:54 -0700
Venkat Subbiah <venkat.mlist@gmail.com> wrote:

> Hello,
> 
> Would like to be able to trace function calls executed during the
> initialization of the kernel module. Is that possible?
> 

Well, yes and no, and it depends ;-)


You wont be able to trace any function that is annotated with "__init",
or even "__exit". That's because the init section does not have a
standard way of cleaning them up (for boot, modules are different, but
are still affected by it).

As ftrace modifies code, and it modifies locations of functions, it can
not safely modify code that suddenly disappeared without it knowing it,
otherwise you may end up with broken NIC cards.

Note, I do plan on adding code that will fix this in the future, but
today, unfortunately, we don't have it.

For functions that are not marked by __init, they will be traced. If
you trace all functions, they will be traced when the module is loaded.
This may not help you either, because by tracing all functions, you
will probably lose the data you want due to overflow of the buffers.

This too may change in the future, but currently we don't have it :-/

-- Steve
