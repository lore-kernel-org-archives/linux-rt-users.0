From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: fork() blocking rt-threads?
Date: Sun, 18 Oct 2009 02:11:22 -0400
Message-ID: <75b66ecd0910172311i36c519b1xec6b0cb0c4eb18e8@mail.gmail.com>
References: <20091016162521.457c18ee@gmx.at> <20091016162258.GH3394@uudg.org>
	 <87k4yvb8s8.fsf@usbix.spacelabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Nedko Arnaudov <nedko@arnaudov.name>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:58176 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbZJRGLT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 18 Oct 2009 02:11:19 -0400
Received: by pxi1 with SMTP id 1so468568pxi.33
        for <linux-rt-users@vger.kernel.org>; Sat, 17 Oct 2009 23:11:24 -0700 (PDT)
In-Reply-To: <87k4yvb8s8.fsf@usbix.spacelabs.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Oct 16, 2009 at 12:31 PM, Nedko Arnaudov <nedko@arnaudov.name> wrote:
>> Another question that comes to mind is: was Ardour running with a realtime
>> priority too? Higher or lower prio than jack's?
>
> Ardour process has realtime thread(s) started by libjack.

AFAICT, fork() is inherently unusable from any thread of a process
with realtime threads.  It locks the page tables and the process
structure of the parent among other things.

Anyone know if posix_spawn() is supported by any major distro's glibc?
 Apparently it was developed to solve this exact problem.

http://www.opengroup.org/onlinepubs/009695399/functions/posix_spawn.html

Lee
