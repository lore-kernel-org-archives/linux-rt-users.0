From: John Kacur <jkacur@redhat.com>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 30 Nov 2011 14:39:55 +0100
Message-ID: <CAONaPpH5QgZ4peSWACmyT-6JRsd+e3Moip9Fu4v2kuTknP40Ow@mail.gmail.com>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	<4EC384FD.1040106@tum.de>
	<alpine.LFD.2.02.1111161605580.4902@ionos>
	<4ED35D9A.7090401@tum.de>
	<CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
	<alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
	<1322620613.17003.110.camel@frodo>
	<CAONaPpEp=bBJWZ4DzAem0TE+_2q5t+G=99_jdJxVsCwXZ4Mk9g@mail.gmail.com>
	<1322660085.17003.112.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Schauss <schauss@tum.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:55092 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab1K3Nj4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 08:39:56 -0500
Received: by qao25 with SMTP id 25so266061qao.19
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Nov 2011 05:39:55 -0800 (PST)
In-Reply-To: <1322660085.17003.112.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Nov 30, 2011 at 2:34 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 2011-11-30 at 09:23 +0100, John Kacur wrote:
>
>> Steve - I'm aware that this is a false positive, I discussed this with
>> Peter already. Normally I don't like the idea of changing code for a
>> tool, but if you see the comment that they wrote above where I put the
>> unlock - it was an extraordinary thing NOT to drop the lock here, as
>> slab_destroy is normally called without it. It doesn't seem like good
>> form to me to hold a lock longer than you need it, and it is a simple
>> solution to getting rid of the lockdep splat. (false positive, or
>> false negative, depending on how you see it.) That being said, I'm not
>> adverse to another solution either, but this one should work and is
>> simple.
>
> This is a mainline issue, and it should go there. If mainline accepts
> it, then fine. Otherwise, it's not going to go into -rt.
>

Quoting myself "Could you try the following patch to see if it gets
rid of your lockdep
splat? (plan to neaten it up and send it to lkml if it works for you.)"

I never requested this go into -rt directly.

John
