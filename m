From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [RFC v0 1/1] fs/locks: Use plain percpu spinlocks instead of
 lglock to protect file_lock
Date: Fri, 20 Feb 2015 15:33:25 +0100
Message-ID: <54E745B5.4020605@bmw-carit.de>
References: <1424355974-30952-1-git-send-email-daniel.wagner@bmw-carit.de>	<1424355974-30952-2-git-send-email-daniel.wagner@bmw-carit.de> <20150219154943.47dc1e4f@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-fsdevel@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	John Kacur <jkacur@redhat.com>,
	<linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Jeff Layton <jlayton@poochiereds.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:51821 "EHLO
	mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbbBTOdc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2015 09:33:32 -0500
In-Reply-To: <20150219154943.47dc1e4f@tlielax.poochiereds.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Jeff,

On 02/19/2015 09:49 PM, Jeff Layton wrote:
> On Thu, 19 Feb 2015 15:26:14 +0100
> Daniel Wagner <daniel.wagner@bmw-carit.de> wrote:
>> Whenever we insert a new lock we are going to grab besides the i_lock
>> also the corresponding percpu file_lock_lock. The global
>> blocked_lock_lock is only used when blocked_hash is involved.
>>
> 
> Ok, good. I like that part -- I hate the blocked_lock_lock, but freezing
> the file locking state is the only way I've found to ensure the
> correctness of deadlock detection. Bummer.

Okay, I'll look into that.

>> file_lock_list exists to be being able to produce the content of
>> /proc/locks. For listing the all locks it seems a bit excessive to
>> grab all locks at once. We should be okay just grabbing the
>> corresponding lock when iterating over the percpu file_lock_list.
>>
> 
> True, but that's not a terribly common event, which is why I figured
> the lg_lock was an acceptable tradeoff there. That said, if you can get
> rid of it in favor of something more efficient then that sounds good to
> me. If it helps the -rt kernels, then so much the better...

Great! I was hoping to hear that :)

>> file_lock_lock protects now file_lock_list and fl_link, fl_block and
>> fl_next allone. That means we need to define which file_lock_lock is
>> used for all waiters. Luckely, fl_link_cpu can be reused for fl_block
>> and fl_next.
>>
> 
> Ok, so when a lock is blocked, we'll insert the waiter onto the
> fl_block list for the blocker, and use the blocker's per-cpu spinlock
> to protect that list. Good idea.

Let's hope it doesn't explode. So far I am still confident it works.


>> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Jeff Layton <jlayton@poochiereds.net>
>> Cc: "J. Bruce Fields" <bfields@fieldses.org>
>> Cc: John Kacur <jkacur@redhat.com>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-rt-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>>
> 
> Thanks for the patch. Some general comments first:
> 
> - fs/locks.c has seen a fair bit of overhaul during the current merge
>   window, and this patch won't apply directly. I'd suggest cleaning it up
>   after -rc1 is cut.

I just rebased it and splited it a bit up. Couldn't wait...

> - the basic idea seems sound, but this is very "fiddly" code. It would
>   be nice to see if you can break this up into multiple patches. For
>   instance, maybe convert the lglock to the percpu spinlocks first in a
>   separate patch, and just keep it protecting the file_lock_list. Once
>   that's done, start changing other pieces to be protected by the percpu
>   locks. Small, incremental changes like that are much easier to deal
>   with if something breaks, since we can at least run a bisect to narrow
>   down the offending change. They're also easier to review.

I complete agree. Sorry to send such a bad initial version. I should
have known it better.

> - the open-coded seqfile stuff is pretty nasty. When I did the original
>   change to use lglocks, I ended up adding seq_hlist_*_percpu macros to
>   support it. Maybe consider doing something like that here too, though
>   this is a bit more complex obviously since you want to be able to just
>   hold one spinlock at a time.

Ok.

> - it would also be good to start thinking about adding lockdep
>   assertions to this code. I simply didn't realize how wonderful they
>   were when I did the global spinlock to i_lock conversion a year or two
>   ago. That can really help catch bugs, and as the (spin)locking gets
>   more complex in this code, that'd be good to help ensure correctness.

I'll give it a try.

Many thanks for the quick review. Really appreciated!

cheers,
daniel
