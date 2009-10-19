From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: fork() blocking rt-threads?
Date: Mon, 19 Oct 2009 19:57:43 -0400
Message-ID: <75b66ecd0910191657g56ecae1fp5ffebfeae80015ef@mail.gmail.com>
References: <20091016162521.457c18ee@gmx.at> <20091016162258.GH3394@uudg.org>
	 <87k4yvb8s8.fsf@usbix.spacelabs.org>
	 <75b66ecd0910172311i36c519b1xec6b0cb0c4eb18e8@mail.gmail.com>
	 <20091019103339.583b6511@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nedko Arnaudov <nedko@arnaudov.name>,
	linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:36791 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088AbZJSX5k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Oct 2009 19:57:40 -0400
Received: by pxi1 with SMTP id 1so799869pxi.33
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2009 16:57:44 -0700 (PDT)
In-Reply-To: <20091019103339.583b6511@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 On Mon, Oct 19, 2009 at 11:33 AM, Clark Williams <williams@redhat.com>=
 wrote:
> Just tried it on a RHEL5.4 and Fedora 11 system. The pthread_spawn(3P=
)
> function is implemented using vfork(2) under the covers. Makes sense,
> since the stated intent is to work without VM.
>
> Still, anyone wanting to create processes/threads in a realtime
> environment needs to do that stuff up front, since there's a ton of
> work required to make a scheduleable entity. Whether you're just
> creating a pthread or you're generating a full-up process, memory wil=
l
> have to be allocated and locks taken. =A0Not sure I'd depend on
> *anything* to do the right thing for me...

Interesting.

Last time I tested it, pthread creation could be realtime safe, if you
allocate and mlock() a pool of memory beforehand and use
pthread_setstack on the preallocated and pre-locked memory.

However I for one did not think that any system call from a
non-realtime thread will cause realtime threads of the same process to
get blocked.  I can't think of any other action that does that.

Regarding the Ardour help menu issue, does this mean that using gtk
APIs from a non RT thread of a process with RT threads is unsafe?

Lee
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
