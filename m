From: John Kacur <jkacur@redhat.com>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 30 Nov 2011 09:23:56 +0100
Message-ID: <CAONaPpEp=bBJWZ4DzAem0TE+_2q5t+G=99_jdJxVsCwXZ4Mk9g@mail.gmail.com>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	<4EC384FD.1040106@tum.de>
	<alpine.LFD.2.02.1111161605580.4902@ionos>
	<4ED35D9A.7090401@tum.de>
	<CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
	<alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
	<1322620613.17003.110.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Schauss <schauss@tum.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48572 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab1K3IX6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 03:23:58 -0500
Received: by qadc14 with SMTP id c14so2691606qad.19
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Nov 2011 00:23:57 -0800 (PST)
In-Reply-To: <1322620613.17003.110.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Nov 30, 2011 at 3:36 AM, Steven Rostedt <rostedt@goodmis.org> w=
rote:
> On Tue, 2011-11-29 at 15:31 +0100, John Kacur wrote:
>> On Mon, 28 Nov 2011, John Kacur wrote:
>
>> > Hmm, I think I see how this can happen.
>> >
>> > cache_flusharray()
>> > spin_lock(&l3->list_lock);
>> > free_block(cachep, ac->entry, batchcount, node);
>> > =A0 =A0 =A0 =A0 slab_destroy()
>> > =A0 =A0 =A0 =A0 kmem_cache_free()
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __cache_free()
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cache_flusharray()
>> >
>>
>> Could you try the following patch to see if it gets rid of your lock=
dep
>> splat? (plan to neaten it up and send it to lkml if it works for you=
=2E)
>>
>> >From 29bf37fc62098bc87960e78f365083d9f52cf36a Mon Sep 17 00:00:00 2=
001
>> From: John Kacur <jkacur@redhat.com>
>> Date: Tue, 29 Nov 2011 15:17:54 +0100
>> Subject: [PATCH] Drop lock in free_block before calling slab_destroy=
 to prevent lockdep splats
>>
>> This prevents lockdep splats due to this call chain
>> cache_flusharray()
>> spin_lock(&l3->list_lock);
>> free_block(cachep, ac->entry, batchcount, node);
>> =A0 =A0 =A0 =A0slab_destroy()
>> =A0 =A0 =A0 =A0kmem_cache_free()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__cache_free()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cache_flusharray()
>
> John,
>
> No, this is a false positive, and the code is correct, lockdep just
> needs to be tweaked. If this was a real bug, then it would have locke=
d
> up here and not have continued, as spinlocks are not recursive.
>
> This was complained about in mainline too:
>
> =A0https://lkml.org/lkml/2011/10/3/364
>
> There was a fix to a similar bug that Peter pointed out, but this bug
> doesn't look like it was fixed.
>
> Peter?
>

Steve - I'm aware that this is a false positive, I discussed this with
Peter already. Normally I don't like the idea of changing code for a
tool, but if you see the comment that they wrote above where I put the
unlock - it was an extraordinary thing NOT to drop the lock here, as
slab_destroy is normally called without it. It doesn't seem like good
form to me to hold a lock longer than you need it, and it is a simple
solution to getting rid of the lockdep splat. (false positive, or
false negative, depending on how you see it.) That being said, I'm not
adverse to another solution either, but this one should work and is
simple.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
